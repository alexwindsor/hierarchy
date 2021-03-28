

<div class="row my-3">
  <div class="col-sm-10">
    <input type="text" name="title" class="form-control" value="<?php echo $page["title"]; ?>" required>
  </div>

  <div class="col-sm-2">
    <?php if ($makeNavigation->parent_id > 0) {?>
    <button type="button" class="btn btn-danger btn-sm m-2" data-toggle="modal" data-target="#delete_confirmation">Delete page</button><br>
    <label>Move page to a different branch? <input type="checkbox" name="move" id="move"></label>
    <?php } ?>
  </div>
</div>

<div class="row my-3">
  <div class="col-sm">
    <textarea name="text" class="form-control" rows="10"><?php echo $page["text"]; ?></textarea>
  </div>
</div>


<input type="submit" value="Update" class="form-control btn btn-info">

<br><br>

<?php echo $makeNavigation->branch; ?> / <input type="text" class="inline" name="child_title" placeholder="new child page"> <input type="submit" class="inline btn btn-sm btn-info" value="add">
