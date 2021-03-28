<?php

class DbConn {

  private $hostname = "localhost";
  private $user = "alex";
  private $pass = "street";
  private $db = "hierarchy";
  public $conn;

  public function makeConn() {

    $options = array(
      PDO::ATTR_EMULATE_PREPARES => false,
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::MYSQL_ATTR_LOCAL_INFILE => true
    );

    $this->conn = new PDO("mysql:host=" . $this->hostname . ";dbname=" . $this->db . ";charset=utf8;", $this->user, $this->pass, $options);
    $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $this->conn->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

  } // end of function makeConn


}
