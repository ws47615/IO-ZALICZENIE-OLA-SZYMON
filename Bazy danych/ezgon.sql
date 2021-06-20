-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ezgon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ezgon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ezgon` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `ezgon` ;

-- -----------------------------------------------------
-- Table `ezgon`.`uzytkownicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezgon`.`uzytkownicy` (
  `id_uzytkownika` INT NOT NULL AUTO_INCREMENT,
  `nazwa_uzytkownika` VARCHAR(45) NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(120) NOT NULL,
  `haslo` VARCHAR(120) NOT NULL,
  `pracownik` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_uzytkownika`),
  UNIQUE INDEX `id_uzytkownika_UNIQUE` (`id_uzytkownika` ASC) VISIBLE,
  UNIQUE INDEX `nazwa_uzytkownika_UNIQUE` (`nazwa_uzytkownika` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `ezgon`.`godziny`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezgon`.`godziny` (
  `godziny_id` INT NOT NULL AUTO_INCREMENT,
  `id_uzytkownika` INT NOT NULL,
  `pon_od` TIME NULL,
  `pon_do` TIME NULL,
  `wt_od` TIME NULL,
  `wt_do` TIME NULL,
  `sr_od` TIME NULL,
  `sr_do` TIME NULL,
  `cz_od` TIME NULL,
  `cz_do` TIME NULL,
  `pt_od` TIME NULL,
  `pt_do` TIME NULL,
  PRIMARY KEY (`godziny_id`),
  UNIQUE INDEX `godziny_id_UNIQUE` (`godziny_id` ASC) VISIBLE,
  INDEX `fk_godziny_uzytkownicy_idx` (`id_uzytkownika` ASC) VISIBLE,
  CONSTRAINT `fk_godziny_uzytkownicy`
    FOREIGN KEY (`id_uzytkownika`)
    REFERENCES `ezgon`.`uzytkownicy` (`id_uzytkownika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ezgon`.`uslugi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezgon`.`uslugi` (
  `id_uslugi` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(100) NOT NULL,
  `cena` DECIMAL(8,2) NOT NULL,
  `czas` TIME NULL,
  `opis` TEXT NULL,
  PRIMARY KEY (`id_uslugi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ezgon`.`uzytkownik_usluga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezgon`.`uzytkownik_usluga` (
  `id_uzytkownika` INT NOT NULL,
  `id_uslugi` INT NOT NULL,
  `modyfikacja` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_uzytkownik_usluga_uzytkownicy1_idx` (`id_uzytkownika` ASC) VISIBLE,
  INDEX `fk_uzytkownik_usluga_uslugi1_idx` (`id_uslugi` ASC) VISIBLE,
  CONSTRAINT `fk_uzytkownik_usluga_uzytkownicy1`
    FOREIGN KEY (`id_uzytkownika`)
    REFERENCES `ezgon`.`uzytkownicy` (`id_uzytkownika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uzytkownik_usluga_uslugi1`
    FOREIGN KEY (`id_uslugi`)
    REFERENCES `ezgon`.`uslugi` (`id_uslugi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ezgon`.`zmarli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezgon`.`zmarli` (
  `id_zmarli` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(120) NOT NULL,
  `data_urodzenia` DATE NOT NULL,
  `ulica` VARCHAR(120) NOT NULL,
  `miejscowosc` VARCHAR(120) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_zmarli`),
  UNIQUE INDEX `pesel_UNIQUE` (`pesel` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ezgon`.`rezerwacje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ezgon`.`rezerwacje` (
  `id_rezerwacje` INT NOT NULL AUTO_INCREMENT,
  `id_zmarli` INT NOT NULL,
  `id_uslugi` INT NOT NULL,
  `id_uzytkownika` INT NOT NULL,
  `rezerwacja_dzien` DATETIME NULL,
  `rezerwacja_godzina` TIME NULL,
  `status` ENUM('oczekuje', 'rezerwacja', 'wykonana') NULL,
  PRIMARY KEY (`id_rezerwacje`),
  INDEX `fk_rezerwacje_zmarli1_idx` (`id_zmarli` ASC) VISIBLE,
  INDEX `fk_rezerwacje_uslugi1_idx` (`id_uslugi` ASC) VISIBLE,
  INDEX `fk_rezerwacje_uzytkownicy1_idx` (`id_uzytkownika` ASC) VISIBLE,
  CONSTRAINT `fk_rezerwacje_zmarli1`
    FOREIGN KEY (`id_zmarli`)
    REFERENCES `ezgon`.`zmarli` (`id_zmarli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezerwacje_uslugi1`
    FOREIGN KEY (`id_uslugi`)
    REFERENCES `ezgon`.`uslugi` (`id_uslugi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezerwacje_uzytkownicy1`
    FOREIGN KEY (`id_uzytkownika`)
    REFERENCES `ezgon`.`uzytkownicy` (`id_uzytkownika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
