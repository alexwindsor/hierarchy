-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 08, 2021 at 07:31 AM
-- Server version: 10.3.29-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
CREATE DEFINER=`alex`@`localhost` PROCEDURE `hierarchy` (IN `id` INT UNSIGNED, IN `title` VARCHAR(128), IN `text` TEXT, IN `child_title` VARCHAR(128), IN `new_parent_id` INT UNSIGNED)  NO SQL
BEGIN








IF `id` = 0 THEN
  SELECT MIN(`hierarchy`.`id`) as id, `hierarchy`.`title`, `hierarchy`.`text` FROM `hierarchy`;
END IF;


IF `title` != "" AND `id` > 0 THEN

  IF `new_parent_id` > 0 THEN
    UPDATE `hierarchy` SET `hierarchy`.`parent_id` = `new_parent_id`, `hierarchy`.`title` = `title`, `hierarchy`.`text` = `text` WHERE `hierarchy`.`id` = `id`;
  ELSE
    UPDATE `hierarchy` SET `hierarchy`.`title` = `title`, `hierarchy`.`text` = `text` WHERE `hierarchy`.`id` = `id`;
  END IF;

END IF;


IF `child_title` != "" AND `id` > 0 THEN
  
  INSERT INTO `hierarchy` (`hierarchy`.`parent_id`, `hierarchy`.`title`) VALUES (`id`, `child_title`);
  
  SELECT LAST_INSERT_ID() AS id, `child_title` AS title, "" AS text, 1 as `update_hierarchy`;
END IF;


IF `title` != "" AND `child_title` = "" AND `id` > 0 THEN
  
  SELECT `id` AS id, `title` AS title, `text` AS text, 1 as update_hierarchy;
END IF;


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
  `text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hierarchy`
--

INSERT INTO `hierarchy` (`id`, `parent_id`, `title`, `text`) VALUES
(1, 0, 'Home page', 'This is the home page of the entire website.\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(74, 1, 'Copa America 2001', 'Hosted by Colombia \r\n\r\n\r\n[[http://www.bbc.co.uk|BBC Website]] h asjhf jlsdhbfk jsbdf khas d fkhasbdfa asd [[http://www.hello.com|HELLO magazine]]\r\nf asdf \r\nads\r\nf asdf adsf asdf asdf asdf [[https://www.theguardian.com/uk|The Guardian Website]] aldskjhf lasdf lasndf \r\n[[http://google.com|Google]] lakmsdf lkmasdlfkmas dlkfm alsdkmf als.\r\n\r\n\r\n\r\n'),
(75, 74, 'Mexico v. Colombia', 'Final :\r\n\r\nMexico 0 Colombia 1\r\n\r\n..in Bogota'),
(76, 75, 'Mexico v. Uruguay', 'Semi Final :\r\n\r\nMexico 1 Uruguay 0\r\n\r\n...in Pereira'),
(77, 75, 'Honduras v. Colombia', 'Semi final :\r\n\r\nHonduras 0 Colombia 2\r\n\r\n..in Manizales'),
(78, 76, 'Chile v. Mexico', 'Quarterfinal :\r\n\r\nChile 0 Mexico 2\r\n\r\n..in Pereira'),
(79, 76, 'Uruguay v. Costa Rica', 'Quarterfinal :\r\n\r\nUruguay 2 Costa Rica 1\r\n\r\n..in Armenia'),
(80, 77, 'Brazil v. Honduras', 'Quarterfinal :\r\n\r\nBrazil 0 Honduras 2\r\n\r\n..in Manizales'),
(81, 77, 'Colombia v. Peru', 'Quarterfinal :\r\n\r\nColombia 3 Peru 0\r\n\r\n..in Armenia'),
(83, 1, 'test', 'Here is a link\r\n\r\n[[https://www.bbc.co.uk/news|BBC News]]');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
