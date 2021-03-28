<?php

include "classes/dbConn.php";
include "classes/setAndGetDbData.php";



$id = $_GET["id"] ?? 0;
$new_parent_id = $_POST["new_parent_id"] ?? 0;

$setAndGetDbData =  new SetAndGetDbData($id, $new_parent_id);
$page = $setAndGetDbData->setAndGetDB();


if (isset($page["update_hierarchy"]) || isset($_GET["updateHierarchy"])) {
  include "classes/updateHierarchy.php";
  $updateHierarchy = new UpdateHierarchy();
  header("Location: index.php?id=" . $page["id"]);
}

include "classes/makeNavigation.php";
$makeNavigation = new MakeNavigation($page["id"]);

// =============================================================

include "incs/header.inc";
include "incs/index.inc";
include "incs/footer.inc";
