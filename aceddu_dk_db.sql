-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Vært: mysql113.unoeuro.com
-- Genereringstid: 24. 04 2024 kl. 14:22:48
-- Serverversion: 8.0.36-28
-- PHP-version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aceddu_dk_db`
--

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `login`
--

CREATE TABLE `login` (
  `brugernavn` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `kode` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `stjerner` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `players`
--

CREATE TABLE `players` (
  `player_name` varchar(40) NOT NULL,
  `score` int NOT NULL DEFAULT '0',
  `settings` varchar(500) DEFAULT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Data dump for tabellen `players`
--

INSERT INTO `players` (`player_name`, `score`, `settings`, `password`) VALUES
('', 10000, NULL, ''),
('1234', 10, NULL, '123456'),
('123456', 0, NULL, '1234'),
('a', 2, NULL, 'a'),
('Anders J R P', 100, NULL, ''),
('Christian BR', 100, NULL, ''),
('Chrizz', 0, NULL, '1234'),
('Enya lugter', 1, NULL, '1234'),
('Kristian K M', 100, NULL, ''),
('Markus', 6, NULL, '1234'),
('nah', 5, NULL, '1234'),
('nej', 2, NULL, '1234'),
('ok', 3, NULL, '1234'),
('qwerty', 1, NULL, '123456'),
('Rayyan', 7, NULL, '1234'),
('sansun', 8, NULL, '6789'),
('smoelf', 10, NULL, '123456'),
('soobin', 2, NULL, '1234'),
('testkkm', 2, NULL, '1234'),
('Therese', 3, NULL, '1234'),
('Therwesse', 0, NULL, '1234'),
('yay', 3, NULL, '1234');

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `login`
--
ALTER TABLE `login`
  ADD UNIQUE KEY `primary_name` (`brugernavn`);

--
-- Indeks for tabel `players`
--
ALTER TABLE `players`
  ADD UNIQUE KEY `player` (`player_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
