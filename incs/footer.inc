

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
<?php include "index.js"; ?>
</script>


</body></html>
