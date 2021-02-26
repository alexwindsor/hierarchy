<?php

class UpdateHierarchy extends DbConn {

  private $allPageRows;


  // call all the methods in the class in the right order
  function __construct() {

    $this->makeConn();
    $this->getAllPageRows();
    $this->processPageRowsArray();
    $this->allPageRows = $this->makeHierarchy($this->allPageRows, 0);
    $this->saveAsJson();

  } // end of function __construct


  // get an array of all the page rows from the database
  function getAllPageRows() {

    $this->allPageRows = $this->conn->query("select `id`, `title`, `parent_id` from `hierarchy`")->fetchAll(PDO::FETCH_ASSOC);

  } // end of function getAllPageRows


  // rearrange the array received from the database call so that the page ids become the keys of each item in the array
  private function processPageRowsArray() {

    $pages = array();

    foreach ($this->allPageRows as $page) {
      $pages[$page["id"]]["title"] = $page["title"];
      $pages[$page["id"]]["parent_id"] = $page["parent_id"];
    }

    $this->allPageRows = $pages;
    unset ($pages);

  } // end of function processPageRowsArray


  // recursive function to rearrange the allPageRows array into a hierarchical structure based on ids and parent ids
  private function makeHierarchy($rows, $parent_id) {

    $hierarchy = array();

    foreach($rows as $key => $row) {
        if ($row["parent_id"] == $parent_id) {
            $hierarchy[$key]["title"] = $row["title"];
            $hierarchy[$key]["parent_id"] = $row["parent_id"];
            !$this->makeHierarchy($rows, $key) ? : $hierarchy[$key]["subpage"] = $this->makeHierarchy($rows, $key);
        }
    }

    return $hierarchy;

  } // end of function makeHierarchy


  // finally, we convert the array into json and save it to a file for construction of hierarchical page navigation
  private function saveAsJson() {

    $hierarchy_json = json_encode($this->allPageRows);

    // unset()
    file_put_contents("hierarchy.json", $hierarchy_json);

  } // end of function saveAsJson




} // end of class  UpdateHierarchy
