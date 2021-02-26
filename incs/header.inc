<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

  <style>
    .move_radio {
      display: none;
      padding-left: 1%;
    }

  </style>
</head>

<body>

<form method="post" action="index.php?id=<?php echo $page["id"]; ?>" id="h_form">

<br><br>

<div class="container">

<h1>Hierarchy Template Website</h1>

<br><br>

<span style="font-size:150%;"><?php echo $makeNavigation->branch; ?></span>
