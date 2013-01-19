SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
CREATE SCHEMA IF NOT EXISTS `tasksdb` DEFAULT CHARACTER SET latin1 ;
USE `mydb` ;
USE `tasksdb` ;

-- -----------------------------------------------------
-- Table `tasksdb`.`groups`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasksdb`.`groups` (
  `Group_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `Group_Name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`Group_ID`) )
  ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasksdb`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasksdb`.`users` (
  `User_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `User_Name` VARCHAR(45) NULL DEFAULT NULL ,
  `User_Password` VARCHAR(45) NULL DEFAULT NULL ,
  `User_Additional` VARCHAR(45) NULL DEFAULT NULL ,
  `Userscol` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`User_ID`) ,
  UNIQUE INDEX `User_ID_UNIQUE` (`User_ID` ASC) )
  ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasksdb`.`projects`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasksdb`.`projects` (
  `Project_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `Project_Name` VARCHAR(45) NULL DEFAULT NULL ,
  `Project_Deadline` DATE NULL DEFAULT NULL ,
  `Project_Additional` VARCHAR(45) NULL DEFAULT NULL ,
  `Users_User_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`Project_ID`) ,
  INDEX `fk_Projects_Users_idx` (`Users_User_ID` ASC) ,
  CONSTRAINT `fk_Projects_Users`
  FOREIGN KEY (`Users_User_ID` )
  REFERENCES `tasksdb`.`users` (`User_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasksdb`.`statuses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasksdb`.`statuses` (
  `Status_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `Status_Name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`Status_ID`) )
  ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `tasksdb`.`tasks`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tasksdb`.`tasks` (
  `Task_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `Task_Name` VARCHAR(45) NULL DEFAULT NULL ,
  `Task_Desc` VARCHAR(1000) NULL DEFAULT NULL ,
  `Task_Progress` INT(11) NULL DEFAULT NULL ,
  `Task_Start` DATE NULL DEFAULT NULL ,
  `Task_End` DATE NULL DEFAULT NULL ,
  `Task_Priority` VARCHAR(45) NULL DEFAULT NULL ,
  `Projects_Project_ID` INT(11) NULL DEFAULT NULL ,
  `Groups_Group_ID` INT(11) NULL DEFAULT NULL ,
  `Statuses_Status_ID` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`Task_ID`) ,
  INDEX `fk_Tasks_Projects1_idx` (`Projects_Project_ID` ASC) ,
  INDEX `fk_Tasks_Groups1_idx` (`Groups_Group_ID` ASC) ,
  INDEX `fk_Tasks_Statuses1_idx` (`Statuses_Status_ID` ASC) ,
  CONSTRAINT `fk_Tasks_Groups1`
  FOREIGN KEY (`Groups_Group_ID` )
  REFERENCES `tasksdb`.`groups` (`Group_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_Projects1`
  FOREIGN KEY (`Projects_Project_ID` )
  REFERENCES `tasksdb`.`projects` (`Project_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_Statuses1`
  FOREIGN KEY (`Statuses_Status_ID` )
  REFERENCES `tasksdb`.`statuses` (`Status_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
  AUTO_INCREMENT = 12
  DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;