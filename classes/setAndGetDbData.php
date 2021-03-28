<?php

class SetAndGetDbData extends DbConn {

  private $id;
  private $title;
  private $text;
  private $child_title;


  function __construct($id, $new_parent_id) {

    $this->id = $id;
    $this->title = $_POST["title"] ?? "";
    $this->text = $_POST["text"] ?? "";
    $this->child_title = $_POST["child_title"] ?? "";
    $this->new_parent_id = $new_parent_id;

    $this->makeConn();

  } // end of function __construct



  public function setAndGetDB() {

    $stmt = $this->conn->prepare("call hierarchy(?, ?, ?, ?, ?)");
    $stmt->execute([$this->id, $this->title, $this->text, $this->child_title, $this->new_parent_id]);
    $page = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $stmt = null;

    if (!isset($page[0])) header("Location: index.php");
    $page = $page[0];

    return $page;

  } // end of function setAndGetDB





} // end of class SetAndGetDbData
