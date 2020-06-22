-- MySQL Script generated by MySQL Workbench
-- Mon Jun 22 17:06:39 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema expressFood
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema expressFood
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `expressFood` DEFAULT CHARACTER SET utf8 ;
USE `expressFood` ;

-- -----------------------------------------------------
-- Table `expressFood`.`StatutLivreur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`StatutLivreur` (
  `idStatutLivreur` INT NOT NULL AUTO_INCREMENT,
  `latitude` INT NULL,
  `longitude` INT NULL,
  `temps` INT NULL,
  `Statut` ENUM('En Livraison', 'Indisponible', 'Libre') NULL,
  PRIMARY KEY (`idStatutLivreur`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `expressFood`.`Utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`Utilisateur` (
  `idUtilisateur` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL,
  `prenom` VARCHAR(255) NULL,
  `password` INT NULL,
  `email` VARCHAR(255) NULL,
  `telephone` INT NULL,
  `role` ENUM('Administrateur', 'Chef Cuisinier', 'Livreur', 'Client') NULL,
  `StatutLivreur_idStatutLivreur` INT NOT NULL,
  PRIMARY KEY (`idUtilisateur`),
  CONSTRAINT `fk_Utilisateur_StatutLivreur1`
    FOREIGN KEY (`StatutLivreur_idStatutLivreur`)
    REFERENCES `expressFood`.`StatutLivreur` (`idStatutLivreur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Utilisateur_StatutLivreur1_idx` ON `expressFood`.`Utilisateur` (`StatutLivreur_idStatutLivreur` ASC) ;


-- -----------------------------------------------------
-- Table `expressFood`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`Adresse` (
  `idAdresse` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NULL,
  `rue` VARCHAR(255) NULL,
  `ville` VARCHAR(255) NULL,
  `codePostal` INT NULL,
  `etage` INT NULL,
  `batiment` VARCHAR(255) NULL,
  PRIMARY KEY (`idAdresse`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `expressFood`.`Commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`Commande` (
  `idCommande` INT NOT NULL AUTO_INCREMENT,
  `dateCreation` DATETIME NULL,
  `dateLivraison` DATETIME NULL,
  `statutCommande` ENUM('En Attente', 'En Livraison', 'Livrer', 'Annulee') NULL,
  `paiement` TINYINT NULL,
  `nbCommande` VARCHAR(45) NULL,
  `Utilisateur_idUtilisateur` INT NOT NULL,
  PRIMARY KEY (`idCommande`),
  CONSTRAINT `fk_Commande_Utilisateur1`
    FOREIGN KEY (`Utilisateur_idUtilisateur`)
    REFERENCES `expressFood`.`Utilisateur` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Commande_Utilisateur1_idx` ON `expressFood`.`Commande` (`Utilisateur_idUtilisateur` ASC) ;


-- -----------------------------------------------------
-- Table `expressFood`.`Plat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`Plat` (
  `idPlat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL,
  `description` LONGTEXT NULL,
  `type` ENUM('Dessert', 'Plat Principale') NULL,
  `platDuJour` TINYINT NULL,
  `prix` INT NULL,
  `Utilisateur_idUtilisateur` INT NOT NULL,
  PRIMARY KEY (`idPlat`),
  CONSTRAINT `fk_Plat_Utilisateur1`
    FOREIGN KEY (`Utilisateur_idUtilisateur`)
    REFERENCES `expressFood`.`Utilisateur` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Plat_Utilisateur1_idx` ON `expressFood`.`Plat` (`Utilisateur_idUtilisateur` ASC) ;


-- -----------------------------------------------------
-- Table `expressFood`.`client_Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`client_Adresse` (
  `Utilisateur_idUtilisateur` INT NOT NULL,
  `Adresse_idAdresse` INT NOT NULL,
  CONSTRAINT `fk_Utilisateur_has_Adresse_Utilisateur1`
    FOREIGN KEY (`Utilisateur_idUtilisateur`)
    REFERENCES `expressFood`.`Utilisateur` (`idUtilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utilisateur_has_Adresse_Adresse1`
    FOREIGN KEY (`Adresse_idAdresse`)
    REFERENCES `expressFood`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Utilisateur_has_Adresse_Adresse1_idx` ON `expressFood`.`client_Adresse` (`Adresse_idAdresse` ASC) ;

CREATE INDEX `fk_Utilisateur_has_Adresse_Utilisateur1_idx` ON `expressFood`.`client_Adresse` (`Utilisateur_idUtilisateur` ASC) ;


-- -----------------------------------------------------
-- Table `expressFood`.`Commande_has_Plat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `expressFood`.`Commande_has_Plat` (
  `Commande_idCommande` INT NOT NULL,
  `Plat_idPlat` INT NOT NULL,
  `quantite` INT NULL,
  CONSTRAINT `fk_Commande_has_Plat_Commande1`
    FOREIGN KEY (`Commande_idCommande`)
    REFERENCES `expressFood`.`Commande` (`idCommande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_has_Plat_Plat1`
    FOREIGN KEY (`Plat_idPlat`)
    REFERENCES `expressFood`.`Plat` (`idPlat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Commande_has_Plat_Plat1_idx` ON `expressFood`.`Commande_has_Plat` (`Plat_idPlat` ASC) ;

CREATE INDEX `fk_Commande_has_Plat_Commande1_idx` ON `expressFood`.`Commande_has_Plat` (`Commande_idCommande` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;