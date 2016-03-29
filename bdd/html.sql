-- MySQL Script generated by MySQL Workbench
-- 03/21/16 20:13:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema users
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema html
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema html
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `html` ;
USE `html` ;

-- -----------------------------------------------------
-- Table `html`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `html`.`users` (
  `idusers` INT NOT NULL AUTO_INCREMENT,
    `identifiant` VARCHAR(15) NULL,
    `mdp` VARCHAR(15) NULL,
  `nom` VARCHAR(15) NULL,
  `prenom` VARCHAR(15) NULL,
  `photo_profile` VARCHAR(45) NULL,
  PRIMARY KEY (`idusers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `html`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `html`.`photos` (
  `idphotos` INT NOT NULL AUTO_INCREMENT,
  `lien` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `lieu` VARCHAR(45) NULL,
  `lat` FLOAT NULL,
  `long` FLOAT NULL,
  `idusers` INT NOT NULL,
  PRIMARY KEY (`idphotos`),
  INDEX `photos_idusers_idx` (`idusers` ASC),
  CONSTRAINT `photos_idusers`
    FOREIGN KEY (`idusers`)
    REFERENCES `html`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
