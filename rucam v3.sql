-- phpMyAdmin SQL Dump
-- version 2.11.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 24, 2015 at 02:04 AM
-- Server version: 5.0.67
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rucam`
--

-- --------------------------------------------------------

--
-- Table structure for table `authorisation`
--

CREATE TABLE IF NOT EXISTS `authorisation` (
  `id` int(11) NOT NULL auto_increment,
  `cards_id` int(11) NOT NULL,
  `fixtures_id` int(11) NOT NULL,
  `start` date NOT NULL,
  `expires` date NOT NULL,
  `checkin` datetime default NULL,
  `checkout` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE IF NOT EXISTS `cards` (
  `id` int(11) NOT NULL auto_increment,
  `competitors_id` int(11) NOT NULL,
  `cardstatus_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cardstatus`
--

CREATE TABLE IF NOT EXISTS `cardstatus` (
  `id` int(11) NOT NULL auto_increment,
  `referred_as` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `competitors`
--

CREATE TABLE IF NOT EXISTS `competitors` (
  `id` int(11) NOT NULL auto_increment,
  `titles_id` int(11) NOT NULL,
  `name` varchar(150) collate utf8_unicode_ci NOT NULL,
  `role` varchar(100) collate utf8_unicode_ci NOT NULL,
  `teams_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `fixtures`
--

CREATE TABLE IF NOT EXISTS `fixtures` (
  `id` int(11) NOT NULL auto_increment,
  `home_teams_id` int(11) NOT NULL,
  `away_teams_id` int(11) NOT NULL,
  `venues_id` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(11) NOT NULL auto_increment,
  `referred_as` varchar(100) collate utf8_unicode_ci NOT NULL COMMENT 'nation',
  `controlledby` varchar(100) collate utf8_unicode_ci NOT NULL,
  `acronym` varchar(50) collate utf8_unicode_ci NOT NULL,
  `nickname` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `titles`
--

CREATE TABLE IF NOT EXISTS `titles` (
  `id` int(11) NOT NULL auto_increment,
  `referred_as` varchar(10) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE IF NOT EXISTS `venues` (
  `id` int(11) NOT NULL auto_increment,
  `referred_as` varchar(100) collate utf8_unicode_ci NOT NULL,
  `town` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

/*
INSERT statements. Inserts all data about teams, titles, competitors, cardstatus, cards and venues.
Will not replace entries on the database that already have the same ID, remove IGNORE pretext to
remove this feature

NOTE: Accents in characters (é,ó,ú) may be required in a few entries but have been left out for the time
being.
**/

INSERT IGNORE INTO `teams` (`id`, `referred_as`, `controlledby`,`acronym`,`nickname`) VALUES
(1, 'England', 'Rugby Football Union', 'RFU', 'England'),
(2, 'Wales', 'Welsh Rugby Union', 'WRU', 'Red Dragons'),
(3, 'Fiji', 'Fiji Rugby Union', 'FRU', 'Flying Fijians'),
(4, 'Australia', 'Australia Ruby Union', 'ARU', 'Wallabies'),
(5, 'Uruguay', 'Union de Rugby del Uruguay', 'URU', 'Teros');

INSERT IGNORE INTO `titles` (`id`, `referred_as`) VALUES
(1, 'Mr'),
(2, 'Ms'),
(3, 'Dr');

INSERT IGNORE INTO `competitors` (`id`, `titles_id`, `name`, `role`, `teams_id`) VALUES
(1, '1', 'Chris Robshaw', 'Captain', '1'),
(2, '1', 'Dylan Hartley', 'Hooker', '1'),
(3, '1', 'Stuart Lancaster', 'Head Coach', '1'),
(4, '2', 'Anna Glowacka', 'Physiotherapist', '1'),
(5, '1', 'Dan Care', 'Scrum-half', '1'),
(6, '1', 'Warren Gatland', 'Head Coach', '2'),
(7, '1', 'Jake Ball', 'Lock', '2'),
(8, '1', 'Rhys Webb', 'Scrum-half', '2'),
(9, '3', 'Vito Gelato', 'Doctor', '2'),
(10, '1', 'John McKee', 'Head Coach', '3'),
(11, '1', 'Akepusi Qera', 'Flanker(Captain)', '3'),
(12, '1', 'Peni Ravai', 'Hooker', '3'),
(13, '3', 'Mary Rose', 'Doctor', '4'),
(14, '1', 'Tom English', 'Wing', '4'),
(15, '1', 'Pablo Lemoine', 'Head Coach', '5'),
(16, '1', 'Alejo Duran', 'Scrum-half','5');

INSERT IGNORE INTO `cardstatus` (`id`, `referred_as`) VALUES
(1, 'Active'),
(2, 'Expired');

INSERT IGNORE INTO `cards` (`id`, `competitors_id`, `cardstatus_id`) VALUES
(1, '1', '1'),
(1, '2', '1'),
(1, '3', '1'),
(1, '4', '1'),
(1, '5', '1'),
(1, '6', '1'),
(1, '7', '1'),
(1, '8', '1'),
(1, '9', '1'),
(1, '10', '1'),
(1, '11', '1'),
(1, '12', '1'),
(1, '13', '1'),
(1, '14', '1'),
(1, '15', '1'),
(1, '16', '1');

INSERT IGNORE INTO `venues` (`id`, `referred_as`,`town`) VALUES
(1, 'Twickenham', 'London'),
(2, 'Millenium', 'Cardiff'),
(3, 'Villa Park', 'Birmingham'),
(4, 'Stadiummk', 'Milton Keynes');











