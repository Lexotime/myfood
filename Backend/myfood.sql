-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 06, 2021 at 03:47 PM
-- Server version: 10.4.11-MariaDB
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
-- Database: `myfood`
--

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `numeorTel` int(15) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `adresse` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commandes`
--

CREATE TABLE `commandes` (
  `numCommande` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `etatCommande` tinyint(1) NOT NULL,
  `etatLivraison` tinyint(1) NOT NULL,
  `livreur_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `detailCommandes`
--

CREATE TABLE `detailCommandes` (
  `id` int(15) NOT NULL,
  `commande_id` int(15) NOT NULL,
  `menu_id` int(15) NOT NULL,
  `quantite` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `detailReservations`
--

CREATE TABLE `detailReservations` (
  `id` int(15) NOT NULL,
  `reservation_id` int(15) NOT NULL,
  `menu_id` int(15) NOT NULL,
  `quantite` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `livreurs`
--

CREATE TABLE `livreurs` (
  `numeroTel` int(15) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `disponible` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(15) NOT NULL,
  `titre` varchar(100) NOT NULL,
  `img` varchar(100) NOT NULL,
  `descript` varchar(100) NOT NULL,
  `prix` int(15) NOT NULL,
  `resto_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `numReservation` int(15) NOT NULL,
  `client_id` int(15) NOT NULL,
  `nombrePlace` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE `restaurants` (
  `numeroTel` int(15) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nomResto` varchar(100) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `heureOuverture` int(15) NOT NULL,
  `heureFermeture` int(15) NOT NULL,
  `nombreEtoile` int(15) NOT NULL,
  `logo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`numeorTel`);

--
-- Indexes for table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`numCommande`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `livreur_id` (`livreur_id`);

--
-- Indexes for table `detailCommandes`
--
ALTER TABLE `detailCommandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commande_id` (`commande_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `detailReservations`
--
ALTER TABLE `detailReservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservation_id` (`reservation_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `livreurs`
--
ALTER TABLE `livreurs`
  ADD PRIMARY KEY (`numeroTel`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resto_id` (`resto_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`numReservation`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`numeroTel`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detailCommandes`
--
ALTER TABLE `detailCommandes`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detailReservations`
--
ALTER TABLE `detailReservations`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`numeorTel`),
  ADD CONSTRAINT `commandes_ibfk_2` FOREIGN KEY (`livreur_id`) REFERENCES `livreurs` (`numeroTel`);

--
-- Constraints for table `detailCommandes`
--
ALTER TABLE `detailCommandes`
  ADD CONSTRAINT `detailCommandes_ibfk_1` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`numCommande`),
  ADD CONSTRAINT `detailCommandes_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`);

--
-- Constraints for table `detailReservations`
--
ALTER TABLE `detailReservations`
  ADD CONSTRAINT `detailReservations_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`numReservation`),
  ADD CONSTRAINT `detailReservations_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`);

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_ibfk_1` FOREIGN KEY (`resto_id`) REFERENCES `restaurants` (`numeroTel`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`numeorTel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
