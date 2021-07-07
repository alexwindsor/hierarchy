// warning when first delete button pressed
$("#delete_yes").click(function() {

  var ids_to_delete = [<?php echo implode(", ", $makeNavigation->deletable_ids); ?>];

  var json_ids =  JSON.stringify(ids_to_delete);

  console.log(json_ids);

  $.ajax({
  url: "delete_pages.php",
  data: {
    ids_to_delete : json_ids
  },
  type: 'post',
  cache: false,
  success: function(data) {
    window.location.href="index.php?id=<?php echo $makeNavigation->parent_id; ?>&updateHierarchy";
  }
});

});


// toggle display of radio buttons when 'move branch' checkbox is checked
$("#move").click(function() {
  $(".move_radio").toggle();
  // if ($(".move_radio").css('display') == "inline") alert("You need to select a new branch to move this one to, from the hierarchy below.");
});

// toggle display of text inputs and hide title and text when 'edit' checkbox is checked
$("#edit").click(function() {
  $("#edit_title").toggle();
  $("#title").toggle();
  $("#edit_text").toggle();
  $("#text").toggle();
  $("#edit_update").toggle();
});



// if 'move branch' checkbox is checked, stop form submit if no new_parent_id radio input is checked
$("#h_form").submit(function() {
  if ($(".move_radio").css('display') == "inline" && !$("input[name='new_parent_id']:checked").val()) {
    alert("You need to select a new branch to move this one to, from the hierarchy below.");
    return false;
  }
});
