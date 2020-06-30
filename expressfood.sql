-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mar. 30 juin 2020 à 13:31
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `expressfood`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `idAdresse` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `rue` varchar(255) NOT NULL,
  `ville` varchar(255) NOT NULL,
  `codePostal` int(11) NOT NULL,
  `etage` int(11) DEFAULT NULL,
  `batiment` varchar(255) NOT NULL,
  PRIMARY KEY (`idAdresse`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`idAdresse`, `numero`, `rue`, `ville`, `codePostal`, `etage`, `batiment`) VALUES
(5, 14, 'Avenue de la place de la république ', 'Rouen', 76000, NULL, 'Appartement'),
(6, 45, 'rue des marthyre', 'Rouen', 76000, NULL, 'Appartement');

-- --------------------------------------------------------

--
-- Structure de la table `clientadresse`
--

DROP TABLE IF EXISTS `clientadresse`;
CREATE TABLE IF NOT EXISTS `clientadresse` (
  `UtilisateurIdUtilisateur` int(11) NOT NULL,
  `AdresseIdAdresse` int(11) NOT NULL,
  KEY `fk_Utilisateur_has_Adresse_Adresse1_idx` (`AdresseIdAdresse`),
  KEY `fk_Utilisateur_has_Adresse_Utilisateur1_idx` (`UtilisateurIdUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `clientadresse`
--

INSERT INTO `clientadresse` (`UtilisateurIdUtilisateur`, `AdresseIdAdresse`) VALUES
(1, 5),
(2, 6);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `idCommande` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreation` datetime NOT NULL,
  `dateLivraison` datetime NOT NULL,
  `statutCommande` enum('En Attente','En Livraison','Livrer','Annulee') NOT NULL,
  `roleCommande` tinyint(4) NOT NULL,
  `paiement` tinyint(4) NOT NULL,
  `UtilisateurIdUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idCommande`),
  KEY `fk_Commande_Utilisateur1_idx` (`UtilisateurIdUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`idCommande`, `dateCreation`, `dateLivraison`, `statutCommande`, `roleCommande`, `paiement`, `UtilisateurIdUtilisateur`) VALUES
(1, '2020-06-18 12:32:00', '2020-06-18 12:40:00', 'Livrer', 0, 1, 4),
(2, '2020-06-17 11:10:00', '2020-06-17 11:16:00', 'En Livraison', 0, 1, 5),
(3, '2020-06-30 13:12:00', '2020-06-30 13:12:00', 'Annulee', 1, 0, 2),
(4, '2020-06-30 11:06:00', '2020-06-30 11:18:00', 'En Attente', 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `commandeplat`
--

DROP TABLE IF EXISTS `commandeplat`;
CREATE TABLE IF NOT EXISTS `commandeplat` (
  `CommandeIdCommande` int(11) NOT NULL,
  `PlatIdPlat` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  KEY `fk_Commande_has_Plat_Plat1_idx` (`PlatIdPlat`),
  KEY `fk_Commande_has_Plat_Commande1_idx` (`CommandeIdCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commandeplat`
--

INSERT INTO `commandeplat` (`CommandeIdCommande`, `PlatIdPlat`, `quantite`) VALUES
(3, 2, 1),
(3, 1, 1),
(4, 2, 1),
(4, 1, 1),
(1, 3, 1),
(1, 5, 1),
(2, 5, 2),
(2, 4, 2);

-- --------------------------------------------------------

--
-- Structure de la table `informationlivreur`
--

DROP TABLE IF EXISTS `informationlivreur`;
CREATE TABLE IF NOT EXISTS `informationlivreur` (
  `idStatutLivreur` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `statu` enum('En Livraison','Indisponible','Libre') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `UtilisateurIdUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idStatutLivreur`),
  KEY `fk_StatutLivreur_Utilisateur1_idx` (`UtilisateurIdUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `informationlivreur`
--

INSERT INTO `informationlivreur` (`idStatutLivreur`, `latitude`, `longitude`, `statu`, `UtilisateurIdUtilisateur`) VALUES
(1, 48.9562, 1.0516, 'En Livraison', 4),
(3, 46.9789, 1.5416, 'Libre', 5);

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

DROP TABLE IF EXISTS `plat`;
CREATE TABLE IF NOT EXISTS `plat` (
  `idPlat` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `type` enum('Dessert','Plat Principale') NOT NULL,
  `platDuJour` tinyint(4) NOT NULL,
  `prix` float NOT NULL,
  `UtilisateurIdUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idPlat`),
  KEY `fk_Plat_Utilisateur1_idx` (`UtilisateurIdUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`idPlat`, `nom`, `description`, `type`, `platDuJour`, `prix`, `UtilisateurIdUtilisateur`) VALUES
(1, 'Ragout d’agneau aux pommes de terre', 'Ragout d’agneau aux pommes de terre Bonjour tout le monde, Voila la cuisine que préfère mon époux et un ragout d’agneau aux pommes de terre est son plat favoris, enfin si on ajoute à la liste les haricots blancs en sauce rouge', 'Plat Principale', 1, 12.9, 6),
(2, 'Melon mariné à la plancha', 'Melon grillé à la poil, et revient avec un chalumeau.', 'Dessert', 1, 4.9, 6),
(3, 'Escalope de poulet à la moutarde', '4 escalopes de poulet, 2 cuillères à soupe de moutarde, 6 cuillères à soupe de crème fraiche allégée, 1 noisette de beurre, poivre concassé.', 'Plat Principale', 0, 11, 7),
(4, 'Pommes de terre sauce ciboulette', '4 grosses pommes de terre, 20 cl de crème fraîche épaisse, 1 gousse d\'ail, 3 cuillères à soupe de ciboulette ciselée, sel, poivre.', 'Plat Principale', 0, 8.9, 7),
(5, 'Tarte chocolat poire', '1 rouleau de pâte sablée, 5 poires, 100 g de chocolat noir dessert, 3 oeufs, 20 cl de crème fraîche, 60 g de sucre, amandes effilées.', 'Dessert', 0, 4.3, 6),
(6, 'Tarte au citron meringuée', '250 g de farine, 120 g de beurre, 5 oeufs, 265 g de sucre, 3 citrons bio, une cuillère à soupe de Maïzena, sel.', 'Dessert', 0, 6.7, 7);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` int(11) NOT NULL,
  `role` enum('Administrateur','Chef Cuisinier','Livreur','Client') NOT NULL,
  PRIMARY KEY (`idUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `nom`, `prenom`, `password`, `email`, `telephone`, `role`) VALUES
(1, 'Mich', 'Mich', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'michmich@live.fr', 635485948, 'Client'),
(2, 'totu', 'Gabriel', '3b92a281bba1b0b0912e1a2e2a04d0243e3f1c44', 'gabriel@live.fr', 520314515, 'Client'),
(3, 'testu', 'admin', '181b5e5fca4658d1f89e9e02e5e1385e64eea48a', 'admin@expressfood.fr', 235625635, 'Administrateur'),
(4, 'payonr', 'Paul', 'bf32753ed0c2f7630b328113ec650f98b10d32c2', 'paul@live.fr', 653265695, 'Livreur'),
(5, 'triton', 'jaque', '2fafd7314704baae70bd427baf09d8fd51000efe', 't.jaque@gmail.com', 635615254, 'Livreur'),
(6, 'millet', 'jean', 'b77ef67379ea3ac0f0c8dd0e840df4ef2a13a359', 'jean@gmail.com', 235184595, 'Chef Cuisinier'),
(7, 'depeir', 'Alban', 'c47488b3481522c9dd717f4042a3405d64f77356', 'Alban.d@gmail.com', 659338244, 'Chef Cuisinier');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clientadresse`
--
ALTER TABLE `clientadresse`
  ADD CONSTRAINT `fk_Utilisateur_has_Adresse_Adresse1` FOREIGN KEY (`AdresseIdAdresse`) REFERENCES `adresse` (`idAdresse`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Utilisateur_has_Adresse_Utilisateur1` FOREIGN KEY (`UtilisateurIdUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_Commande_Utilisateur1` FOREIGN KEY (`UtilisateurIdUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commandeplat`
--
ALTER TABLE `commandeplat`
  ADD CONSTRAINT `fk_Commande_has_Plat_Commande1` FOREIGN KEY (`CommandeIdCommande`) REFERENCES `commande` (`idCommande`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Commande_has_Plat_Plat1` FOREIGN KEY (`PlatIdPlat`) REFERENCES `plat` (`idPlat`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `informationlivreur`
--
ALTER TABLE `informationlivreur`
  ADD CONSTRAINT `fk_StatutLivreur_Utilisateur1` FOREIGN KEY (`UtilisateurIdUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `plat`
--
ALTER TABLE `plat`
  ADD CONSTRAINT `fk_Plat_Utilisateur1` FOREIGN KEY (`UtilisateurIdUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
