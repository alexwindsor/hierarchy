-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 25, 2021 at 08:46 PM
-- Server version: 10.1.48-MariaDB-0+deb9u1
-- PHP Version: 7.3.27-2+0~20210213.78+debian9~1.gbpc9cf23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hierarchy`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `hierarchy` (IN `id` INT UNSIGNED, IN `title` VARCHAR(128), IN `text` TEXT, IN `child_title` VARCHAR(128), IN `new_parent_id` INT UNSIGNED)  NO SQL
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



END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hierarchy`
--

CREATE TABLE `hierarchy` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `text` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hierarchy`
--

INSERT INTO `hierarchy` (`id`, `parent_id`, `title`, `text`) VALUES
(1, 0, 'Home page', 'This is the home page of the entire website.\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(49, 1, 'Colours', ''),
(50, 49, 'red', NULL),
(51, 49, 'green', NULL),
(52, 49, 'blue', NULL),
(53, 1, 'places', ''),
(54, 53, 'UK', ''),
(55, 54, 'England', ''),
(56, 54, 'Wales', NULL),
(57, 54, 'scotland', ''),
(58, 54, 'northern ireland', NULL),
(59, 55, 'London', ''),
(60, 59, 'Tooting', NULL),
(61, 59, 'hackney', NULL),
(62, 57, 'Edinburgh', NULL),
(63, 1, '1', ''),
(64, 63, '2', ''),
(65, 64, '3', ''),
(66, 65, '4', ''),
(67, 66, '5', ''),
(68, 67, '6', NULL),
(69, 1, 'cars', ''),
(70, 69, 'porsche', NULL),
(71, 69, 'ferrari', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hierarchy`
--
ALTER TABLE `hierarchy`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hierarchy`
--
ALTER TABLE `hierarchy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
