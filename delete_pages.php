<?php

// $ids_to_delete = json_decode($_POST["ids_to_delete"], true);
// $csv = implode("-", $json_ids_to_delete);
// file_put_contents("test", $csv);

$ids_to_delete = json_decode($_POST["ids_to_delete"], true);


// $options = array(
//   PDO::ATTR_EMULATE_PREPARES => false,
//   PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
//   PDO::MYSQL_ATTR_LOCAL_INFILE => true
// );
//
// $conn = new PDO("mysql:host=localhost;dbname=hierarchy;charset=utf8;", "root", "street", $options);
// $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
// $conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

include "classes/dbConn.php";
$dbConn = new DbConn;
$dbConn->makeConn();

$test = "123";

$query = "delete from hierarchy where id = ";

for ($i = 0; $i < count($ids_to_delete); $i++) {
  $query .= "? or id = ";
}

$query = substr($query, 0, -9);

// file_put_contents("test", $query);
// die();

$stmt = $dbConn->conn->prepare($query);
// $stmt->execute([$this->id, $this->title, $this->text, $this->child_title, $this->new_parent_id]);
$stmt->execute($ids_to_delete);
$stmt = null;



 ?>
