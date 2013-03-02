

-- phpMyAdmin SQL Dump
-- version 3.5.4
-- http://www.phpmyadmin.net
--
-- Host: 127.10.200.129:3306
-- Czas wygenerowania: 23 Lut 2013, 07:51
-- Wersja serwera: 5.1.67
-- Wersja PHP: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

DROP SCHEMA tasak;
CREATE DATABASE `tasak` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `tasak`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `tasak`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `idp` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`idp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Zrzut danych tabeli `projects`
--

INSERT INTO `projects` (`idp`, `name`, `description`) VALUES
(1, 'Task list run', 'What you can do with task list'),
(2, 'Mountain expedition', 'Probably Peru and Ands mountains'),
(3, 'New test project', 'This is quite temporary project'),
(7, 'Zrobienie bloga', 'blog dla Kariny'),
(8, 'Praca inzynierska', 'Zaplanowanie pracy inz'),
(9, 'Sprzatanie w garazu', 'Tam jest strasznie trzeba to w koncu zrobic');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `idt` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_polish_ci DEFAULT 'NoName',
  `priority` varchar(50) COLLATE utf8_polish_ci DEFAULT 'Low',
  `timeToDo` double DEFAULT '10',
  `description` varchar(50) CHARACTER SET utf8 DEFAULT 'TBD',
  `project_idp` int(11) DEFAULT NULL,
  `user_idu` int(11) NOT NULL,
  PRIMARY KEY (`idt`),
  KEY `project_idp` (`project_idp`),
  KEY `user_idu` (`user_idu`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=32 ;

--
-- Zrzut danych tabeli `task`
--

INSERT INTO `task` (`idt`, `name`, `priority`, `timeToDo`, `description`, `project_idp`, `user_idu`) VALUES
(1, 'Adding task', 'Hi', 2, 'Add new task', 1, 1),
(2, 'Editing task', 'Hi', 1, 'Edit some task', 1, 1),
(3, 'Delete some task', 'Hi', 1, 'Delete som task. Have a fun', 1, 1),
(4, 'Pagination check', 'High', 3, 'Make more than 5 or 10 task', 1, 2),
(8, 'Visas', 'High', 8, 'So. must find out if visas are realy needed', 2, 1),
(9, 'Plane tickets', 'High', 6, 'Find cheapest way to get to Peru', 2, 2),
(10, 'Culture in Peru', 'Mid', 20, 'Read as much as you can abou', 2, 3),
(11, 'Culture in Peru', 'Mid', 20, 'Read as much as you can about culture in peru ', 2, 3),
(12, 'Culture in Peru', 'Mid', 20, 'Read as much as you can about culture in peru', 2, 3),
(13, 'Culture in Peru', 'Mid', 20, 'Read as much as you can about culture in peru', 2, 3),
(14, 'Task1', 'Mid', 5, 'Description of task1', 3, 1),
(16, 'Znalezc domene', 'High', 3, 'Moze jakas taka jak lolo.pl', 7, 1),
(17, 'Change project', 'Mid', 1, 'Admin can change project of task', 1, 1),
(18, 'Buy maps', 'High', 4, 'Find decend maps', 1, 1),
(19, 'Selenium Grid And', 'High', 3, 'Odpalic grida na wirtualace androida', 8, 1),
(20, 'a1', 'High', 1, 'asas', 1, 1),
(22, 'a1', 'High', 1, 'asas', 1, 1),
(23, 'a1??????????', 'High', 1, 'asas', 1, 1),
(24, 'a', 'High', 1, '1', 8, 1),
(25, 'a1', 'High', 1, '1', 8, 1),
(30, 'a', 'High', 1, '1', 8, 1),
(31, '??Ä???', 'High', 1, '1', 8, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `idu` int(11) NOT NULL DEFAULT '0',
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `uname` varchar(8) NOT NULL,
  `password` int(11) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`idu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`idu`, `firstName`, `lastName`, `uname`, `password`, `isAdmin`) VALUES
(1, 'Przemek', 'Baranski', 'admin', 1234, 1),
(2, 'Janek', 'Baptista', 'user', 1235, 0),
(3, 'Halina', 'Lolicka', 'admin2', 1234, 1),
(4, 'Józef', 'Zapotoczak', 'user2', 1235, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users_has_projects`
--

CREATE TABLE IF NOT EXISTS `users_has_projects` (
  `users_idu` int(11) NOT NULL,
  `projects_idp` int(11) NOT NULL,
  PRIMARY KEY (`users_idu`,`projects_idp`),
  KEY `fk_users_has_projects_projects1_idx` (`projects_idp`),
  KEY `fk_users_has_projects_users1_idx` (`users_idu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `users_has_projects`
--

INSERT INTO `users_has_projects` (`users_idu`, `projects_idp`) VALUES
(1, 1),
(2, 1),
(3, 1),
(1, 2),
(1, 3),
(1, 7),
(1, 8),
(1, 9);

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `task`
--
ALTER TABLE `task`
ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`project_idp`) REFERENCES `projects` (`idp`),
ADD CONSTRAINT `task_ibfk_2` FOREIGN KEY (`user_idu`) REFERENCES `users` (`idu`);

--
-- Ograniczenia dla tabeli `users_has_projects`
--
ALTER TABLE `users_has_projects`
ADD CONSTRAINT `fk_users_has_projects_projects1` FOREIGN KEY (`projects_idp`) REFERENCES `projects` (`idp`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_users_has_projects_users1` FOREIGN KEY (`users_idu`) REFERENCES `users` (`idu`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
