BEGIN


-- incoming variables:
-- id, title, text, child_title, parent_id, new_parent_id
-- ===============================================

-- set and get all the data for the page according to data received


-- if we don't even have a page id then we just send back the first page in the hierarchy
IF `id` = 0 THEN
  SELECT MIN(`hierarchy`.`id`) as id, `hierarchy`.`title`, `hierarchy`.`text` FROM `hierarchy`;
END IF;

-- if we have data to update the page that the user was on
IF `title` != "" AND `id` > 0 THEN

  IF `new_parent_id` > 0 THEN
    UPDATE `hierarchy` SET `hierarchy`.`parent_id` = `new_parent_id`, `hierarchy`.`title` = `title`, `hierarchy`.`text` = `text` WHERE `hierarchy`.`id` = `id`;
  ELSE
    UPDATE `hierarchy` SET `hierarchy`.`title` = `title`, `hierarchy`.`text` = `text` WHERE `hierarchy`.`id` = `id`;
  END IF;

END IF;

-- if the user added a new subpage to the page that they were on
IF `child_title` != "" AND `id` > 0 THEN
  -- then we insert the child_title into the new subpage and..
  INSERT INTO `hierarchy` (`hierarchy`.`parent_id`, `hierarchy`.`title`) VALUES (`id`, `child_title`);
  -- ..and select (return) the id of the newly created row, the title received and set the flag to 1 to indicate that later php scripts need to update the hierarchy tree
  SELECT LAST_INSERT_ID() AS id, `child_title` AS title, "" AS text, 1 as `update_hierarchy`;
END IF;

-- if post data was sent but a subpage wasn't added (ie. title was blank) then we will already have updated the row in the database and we don't need to get it again, we can just send back the data that was received
IF `title` != "" AND `child_title` = "" AND `id` > 0 THEN
  -- we also send back a variable to indicate that later php scripts need to be run to update the hierarchy tree
  SELECT `id` AS id, `title` AS title, `text` AS text, 1 as update_hierarchy;
END IF;

-- if no form data was sent, we need to get the data for the page id that was sent
IF `title` = "" AND `child_title` = "" AND `id` > 0 THEN
  SELECT `hierarchy`.`id`, `hierarchy`.`title`, `hierarchy`.`text` FROM `hierarchy` WHERE `hierarchy`.`id` = `id`;
END IF;



END
