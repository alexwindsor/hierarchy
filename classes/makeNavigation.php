<?php

class MakeNavigation {

  private $id;
  private $hierarchy;
  private $behind = true;

  private $id_depth = 0;

  public $fullNavigation;
  public $deletable_ids = array();
  public $deletable_hierarchy;
  private $branch_array = array();
  private $got_flag = false;
  public $branch = "";
  public $parent_id;


  function __construct($id) {

    $this->id = $id;

    $this->hierarchy = json_decode(file_get_contents("hierarchy.json"), true);
    $this->fullNavigation = $this->makeFullNavigation($this->hierarchy, $this->id);

    $this->makeNavBranchArray($this->hierarchy, $this->id);
    $this->makeNavBranch();

  } // end of function __construct




  private function makeFullNavigation($hierarchy, $id, $depth = 0) {

    $sitelinks = "";

    foreach($hierarchy as $key => $page) {
        $sitelinks .= "<div class='ml-5'>";
        if ($key == $id) {
          $this->behind = false;
          $this->id_depth = $depth;
        }

        $key == $id ? $sitelinks .= "<b>" : $sitelinks .= "<a href='index.php?id=" . $key . "'>";
        $sitelinks .= $page["title"];
        $key == $id ? $sitelinks .= "</b>" : $sitelinks .= "</a>";

        $this->behind ? $sitelinks .= "<span class='move_radio'><input type='radio' name='new_parent_id' value='" . $key . "'></span>" : $this->deletable_ids[] = $key;

        if (!$this->behind && $key != $id) $this->deletable_hierarchy .= "<div class='ml-5'>" . $page["title"];

        if (isset($page["subpage"])) {
          $depth++;
          $sitelinks .= $this->makeFullNavigation($page["subpage"], $id, $depth);
          $depth--;
          $depth > $this->id_depth ? : $this->behind = true;
        }

        if (!$this->behind && $key != $id) $this->deletable_hierarchy .= "</div>";
        $sitelinks .= "</div>";
    }

  return $sitelinks;

  } // end of function makeFullNavigation




  private function makeNavBranchArray($hierarchy, $id, $depth = 0) {

    foreach($hierarchy as $key => $page) {

      $this->branch_array[$depth][0] = $key;
      $this->branch_array[$depth][1] = $page["title"];

      if ($key == $id) {
        $this->got_flag = true;
        break;
      }

      elseif (isset($page["subpage"])) {
        $depth++;
        $this->makeNavBranchArray($page["subpage"], $id, $depth);

        if ($this->got_flag) {
          if ($depth >= $this->id_depth) {
            $branch_array_size = count($this->branch_array);
            for ($i = $depth + 1; $i <= $branch_array_size; $i++) {
              unset($this->branch_array[$i]);
            }
          }
          break;
        }
        $depth--;
      }

    }

  } // end of function makeNavigationBranch


  private function makeNavBranch() {

    for ($i = 0; $i < count($this->branch_array); $i++) {
      $this->id == $this->branch_array[$i][0] ? $this->branch .= "<b>" : $this->branch .= "<a href='index.php?id=" . $this->branch_array[$i][0] . "'>";
      $this->branch .= $this->branch_array[$i][1];
      $this->id == $this->branch_array[$i][0] ? $this->branch .= "</b>" : $this->branch .= "</a>";
      if ($this->id !== $this->branch_array[$i][0]) {
        $this->branch .= "&nbsp;/&nbsp;";
      }
    }

    // get the parent_id for use in the page
    $this->parent_id = $this->branch_array[count($this->branch_array) - 2][0] ?? 0;

  } // end of function makeNavBranch


  public function text_to_html($text) {

    // make a preg match thing that makes html links out of [[https://www.bbc.co.uk/news|BBC News]] here

    $text = htmlentities($text);
    $text = str_replace("\n", "<br>", $text);


    return $text;

  }


} // end of class MakeNavigation
