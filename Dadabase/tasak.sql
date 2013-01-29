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
-- Table `tasak`.`projects`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasak`.`projects` (
  `idp` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(20) NULL DEFAULT NULL ,
  `description` VARCHAR(120) NULL DEFAULT NULL ,
  PRIMARY KEY (`idp`) )
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasak`.`task`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasak`.`task` (
  `idt` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT 'NoName' ,
  `priority` VARCHAR(50) NULL DEFAULT 'Low' ,
  `timeToDo` DOUBLE NULL DEFAULT '10' ,
  `description` VARCHAR(50) NULL DEFAULT 'TBD' ,
  `projects_idp` INT(11) NOT NULL ,
  PRIMARY KEY (`idt`, `projects_idp`) ,
  INDEX `fk_task_projects1_idx` (`projects_idp` ASC) ,
  CONSTRAINT `fk_task_projects1`
  FOREIGN KEY (`projects_idp` )
  REFERENCES `tasak`.`projects` (`idp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
  AUTO_INCREMENT = 42
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
-- Table `tasak`.`users_has_projects`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasak`.`users_has_projects` (
  `users_idu` INT(11) NOT NULL ,
  `projects_idp` INT(11) NOT NULL ,
  PRIMARY KEY (`users_idu`, `projects_idp`) ,
  INDEX `fk_users_has_projects_projects1_idx` (`projects_idp` ASC) ,
  INDEX `fk_users_has_projects_users1_idx` (`users_idu` ASC) ,
  CONSTRAINT `fk_users_has_projects_users1`
  FOREIGN KEY (`users_idu` )
  REFERENCES `tasak`.`users` (`idu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_projects_projects1`
  FOREIGN KEY (`projects_idp` )
  REFERENCES `tasak`.`projects` (`idp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;