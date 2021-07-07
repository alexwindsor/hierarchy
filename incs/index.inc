


<div class="row my-3">
  <div class="col-sm-9 form-inline">
    <span style="font-size:150%;"><?= str_replace($page["title"], "", $makeNavigation->branch); ?></span><span style="font-size:150%;" id="title"><?= $page["title"] ?></span>
    <input type="text" name="title"  id="edit_title" class="form-control" value="<?php echo $page["title"]; ?>" style="display:none" required>
  </div>


  <?php if ($makeNavigation->parent_id > 0) {?>
  <div class="col-sm-2 p-3 mx-2 border rounded">

    <button type="button" class="btn btn-danger btn-sm mb-2" data-toggle="modal" data-target="#delete_confirmation">Delete page</button><br>
    <label>Move page to a different branch? <input type="checkbox" name="move" id="move"></label>
    <label>Edit Page? <input type="checkbox" name="edit" id="edit"></label>
  </div>
<?php } ?>
</div>

<div class="row my-3">
  <div class="col-sm">
    <div id="text">
      <?= $makeNavigation->text_to_html($page["text"]); ?>
    </div>
      <textarea name="text" id="edit_text" class="form-control" rows="10" style="display:none"><?= $page["text"]; ?></textarea>
  </div>
</div>


<input type="submit" value="Update" id="edit_update" class="form-control btn btn-info" style="display:none">

<br><br>
<div class="form-inline">
<?php echo $makeNavigation->branch; ?>&nbsp;/&nbsp;<input type="text" class="form-control mr-2" name="child_title" placeholder="new child page"> <input type="submit" class="inline btn btn-sm btn-info" value="add">
</div>
