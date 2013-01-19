SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
DROP SCHEMA IF EXISTS `tasak` ;
CREATE SCHEMA IF NOT EXISTS `tasak` DEFAULT CHARACTER SET latin1 ;
USE `mydb` ;
USE `tasak` ;

-- -----------------------------------------------------
-- Table `tasak`.`car`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasak`.`car` (
  `idc` INT(11) NOT NULL AUTO_INCREMENT ,
  `make` VARCHAR(50) NULL DEFAULT NULL ,
  `model` VARCHAR(50) NULL DEFAULT NULL ,
  `regnum` VARCHAR(8) NOT NULL ,
  `price` DOUBLE NULL DEFAULT NULL ,
  `color` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`idc`) )
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasak`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasak`.`users` (
  `idu` INT(11) NOT NULL DEFAULT '0' ,
  `firstName` VARCHAR(50) NULL DEFAULT NULL ,
  `lastName` VARCHAR(50) NULL DEFAULT NULL ,
  `uname` VARCHAR(8) NOT NULL ,
  `password` INT(11) NULL DEFAULT NULL ,
  `isAdmin` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`idu`) )
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasak`.`task`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasak`.`task` (
  `idt` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `priority` VARCHAR(50) NULL DEFAULT NULL ,
  `timeToDo` DOUBLE NULL DEFAULT NULL ,
  `description` VARCHAR(50) NULL DEFAULT NULL ,
  `user_idu` INT(11) NOT NULL ,
  PRIMARY KEY (`idt`) ,
  INDEX `user_idu` (`user_idu` ASC) ,
  CONSTRAINT `task_ibfk_1`
  FOREIGN KEY (`user_idu` )
  REFERENCES `tasak`.`users` (`idu` ))
  ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
