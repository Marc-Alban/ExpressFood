-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  sam. 27 juin 2020 à 10:55
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
  `batiment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idAdresse`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`idAdresse`, `numero`, `rue`, `ville`, `codePostal`, `etage`, `batiment`) VALUES
(1, 18, 'amre pare', 'romorantin-lanthenay', 41003, 2, 'Immeuble'),
(2, 4, 'rue des martyre', 'lyon', 69003, NULL, NULL),
(3, 45, 'rue des châtier', 'Paris', 91000, 4, 'immeuble');

-- --------------------------------------------------------

--
-- Structure de la table `client_adresse`
--

DROP TABLE IF EXISTS `client_adresse`;
CREATE TABLE IF NOT EXISTS `client_adresse` (
  `Utilisateur_idUtilisateur` int(11) NOT NULL,
  `Adresse_idAdresse` int(11) NOT NULL,
  KEY `fk_Utilisateur_has_Adresse_Adresse1_idx` (`Adresse_idAdresse`),
  KEY `fk_Utilisateur_has_Adresse_Utilisateur1_idx` (`Utilisateur_idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client_adresse`
--

INSERT INTO `client_adresse` (`Utilisateur_idUtilisateur`, `Adresse_idAdresse`) VALUES
(3, 1),
(5, 3),
(5, 2);

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
  `paiement` tinyint(4) NOT NULL,
  `Utilisateur_idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idCommande`),
  KEY `fk_Commande_Utilisateur1_idx` (`Utilisateur_idUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`idCommande`, `dateCreation`, `dateLivraison`, `statutCommande`, `paiement`, `Utilisateur_idUtilisateur`) VALUES
(1, '2020-06-23 08:19:31', '2020-06-23 08:40:31', 'En Livraison', 0, 5),
(2, '2020-06-22 09:00:00', '2020-06-22 09:17:00', 'Livrer', 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `commande_has_plat`
--

DROP TABLE IF EXISTS `commande_has_plat`;
CREATE TABLE IF NOT EXISTS `commande_has_plat` (
  `Commande_idCommande` int(11) NOT NULL,
  `Plat_idPlat` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  KEY `fk_Commande_has_Plat_Plat1_idx` (`Plat_idPlat`),
  KEY `fk_Commande_has_Plat_Commande1_idx` (`Commande_idCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande_has_plat`
--

INSERT INTO `commande_has_plat` (`Commande_idCommande`, `Plat_idPlat`, `quantite`) VALUES
(2, 3, 4),
(2, 4, 3);

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
  `Utilisateur_idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idPlat`),
  KEY `fk_Plat_Utilisateur1_idx` (`Utilisateur_idUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`idPlat`, `nom`, `description`, `type`, `platDuJour`, `prix`, `Utilisateur_idUtilisateur`) VALUES
(1, 'Pommes de terre farcies chorizo ou saucisse', 'J’ai voulu revisiter les pommes de terre farcies que l’on fait souvent avec les tomates farcies, en faisant une farce au chorizo, fromage et une autre avec des tronçons de saucisse de Toulouse et fromage. Une recette simple, de tous les jours comme je les aimes …', 'Plat Principale', 1, 7.9, 4),
(2, 'Crème brûlée au gingembre', 'Tout le plaisir de la crème brûlée est là ! C\'est le contraste entre la douceur de la crème et le croquant du caramel qui rend ces crèmes irrésistibles. Tison ou chalumeau vos crèmes seront bien caramélisées mais il faut savoir que la méthode au chalumeau a l\'avantage certain d\'être beaucoup plus rapide. Quelques secondes suffisent ! Attention cependant de ne pas placer la flamme puissante du chalumeau trop près de la surface à caraméliser sous peine de la voir se briser !\r\n\r\nEt si vous n\'avez ni l\'un ni l\'autre... pas de problème il reste le bon vieux grill de votre four. Un peu plus long c\'est vrai mais quand on aime...', 'Dessert', 1, 4.5, 4),
(3, 'Mousse au chocolat aux oranges confites', 'C’est un test de self contrôle : les blancs montés avec frénésie ou au contraire trop mollement donneront une mousse décevante. Incorporer le chocolat trop chaud dans les blancs les aideront à s’effondrer. La mousse au chocolat, c’est comme les choses de l’amour, tout vient à point à qui sait attendre…', 'Dessert', 0, 3.9, 4),
(4, 'Oeufs au plat\r\n', 'Ici la cuisson se fait dans un plat à oeufs de taille adaptée.. Vous pouvez aussi accompagner vos oeufs au plat de champignons sautés, ils prendront alors l\'appellation forestière ou d\'un concassé de tomates fraîches (appellation dite à la portugaise) de jambon ou de fruits de mer.', 'Plat Principale', 0, 7.8, 4);

-- --------------------------------------------------------

--
-- Structure de la table `statutlivreur`
--

DROP TABLE IF EXISTS `statutlivreur`;
CREATE TABLE IF NOT EXISTS `statutlivreur` (
  `idStatutLivreur` int(11) NOT NULL AUTO_INCREMENT,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `temps` int(11) NOT NULL,
  `Statut` enum('En Livraison','Indisponible','Libre') NOT NULL,
  `Utilisateur_idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idStatutLivreur`),
  KEY `fk_StatutLivreur_Utilisateur1_idx` (`Utilisateur_idUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `statutlivreur`
--

INSERT INTO `statutlivreur` (`idStatutLivreur`, `latitude`, `longitude`, `temps`, `Statut`, `Utilisateur_idUtilisateur`) VALUES
(1, 47.3594, 1.74444, 20, 'Libre', 2),
(2, 45.764, 4.83566, 17, 'Libre', 2);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `password` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telephone` int(11) NOT NULL,
  `role` enum('Administrateur','Chef Cuisinier','Livreur','Client') NOT NULL,
  PRIMARY KEY (`idUtilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `nom`, `prenom`, `password`, `email`, `telephone`, `role`) VALUES
(1, 'millet', 'marc-alban', 1234, 'test@live.fr', 638154851, 'Chef Cuisinier'),
(2, 'jean', 'michmich', 3210, 'michmich@live.fr', 54278458, 'Client'),
(3, 'aya', 'boutani', 4563, 'aya@live.fr', 52438156, 'Livreur'),
(4, 'expressfood', 'expressfood', 95465, 'expressfood@gmail.com', 546231595, 'Administrateur'),
(5, 'dupond', 'jack', 9512365, 'd.jack@gmail.com', 65389457, 'Client');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client_adresse`
--
ALTER TABLE `client_adresse`
  ADD CONSTRAINT `fk_Utilisateur_has_Adresse_Adresse1` FOREIGN KEY (`Adresse_idAdresse`) REFERENCES `adresse` (`idAdresse`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Utilisateur_has_Adresse_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_Commande_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commande_has_plat`
--
ALTER TABLE `commande_has_plat`
  ADD CONSTRAINT `fk_Commande_has_Plat_Commande1` FOREIGN KEY (`Commande_idCommande`) REFERENCES `commande` (`idCommande`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Commande_has_Plat_Plat1` FOREIGN KEY (`Plat_idPlat`) REFERENCES `plat` (`idPlat`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `plat`
--
ALTER TABLE `plat`
  ADD CONSTRAINT `fk_Plat_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `statutlivreur`
--
ALTER TABLE `statutlivreur`
  ADD CONSTRAINT `fk_StatutLivreur_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
