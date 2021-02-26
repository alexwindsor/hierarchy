

<br><br>

<?php echo $makeNavigation->fullNavigation; ?>

<br><br>

</form>


<!-- Modal -->
<div class="modal fade" id="delete_confirmation" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Delete Page <?php echo $page["title"]; ?> ?</h4>
      </div>

      <?php
      if ($makeNavigation->deletable_hierarchy != "") {
        echo "<div class='modal-body'>";
        echo "This will mean deleting all the pages in the branch beneath this page:<br><br>";
        echo $makeNavigation->deletable_hierarchy;
        echo "</div>";
      }
      ?>

      <div class="modal-footer text-center">
        <button type="button" class="btn btn-danger" id="delete_yes">DELETE</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

</div>

<script type="text/javascript">

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

// if 'move branch' checkbox is checked, stop form submit if no new_parent_id radio input is checked
$("#h_form").submit(function() {
  if ($(".move_radio").css('display') == "inline" && !$("input[name='new_parent_id']:checked").val()) {
    alert("You need to select a new branch to move this one to, from the hierarchy below.");
    return false;
  }
});
</script>


</body></html>
