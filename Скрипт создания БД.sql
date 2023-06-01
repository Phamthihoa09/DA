SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Стройсервис` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Стройсервис` ;

-- -----------------------------------------------------
-- Table `Стройсервис`.`Группа_клиентов`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Группа_клиентов` (
  `ID_группы` INT NOT NULL AUTO_INCREMENT ,
  `Название_группы` VARCHAR(70) NOT NULL ,
  PRIMARY KEY (`ID_группы`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Клиенты`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Клиенты` (
  `ID_клиента` INT NOT NULL AUTO_INCREMENT ,
  `ID_группы` INT NOT NULL ,
  `ФИО_название_организации` VARCHAR(150) NOT NULL ,
  `Дата_рождения` DATE NULL ,
  `Мобильный_телефон` VARCHAR(18) NULL ,
  `Городской_телефон` VARCHAR(20) NULL ,
  `Адрес` VARCHAR(255) NOT NULL ,
  `Паспорт` VARCHAR(255) NULL ,
  `Тип_лица` VARCHAR(30) NOT NULL ,
  `ИНН` VARCHAR(10) NULL ,
  `КПП` VARCHAR(9) NULL ,
  `e-mail` VARCHAR(30) NULL ,
  PRIMARY KEY (`ID_клиента`) ,
  INDEX `ГруппаКл_Клиенты_idx` (`ID_группы` ASC) ,
  CONSTRAINT `ГруппаКл_Клиенты`
    FOREIGN KEY (`ID_группы` )
    REFERENCES `Стройсервис`.`Группа_клиентов` (`ID_группы` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Отделы`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Отделы` (
  `ID_отдела` INT NOT NULL AUTO_INCREMENT ,
  `Название_отдела` VARCHAR(70) NOT NULL ,
  PRIMARY KEY (`ID_отдела`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Сотрудники`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Сотрудники` (
  `ID_сотрудника` INT NOT NULL AUTO_INCREMENT ,
  `ID_отдела` INT NOT NULL ,
  `ФИО` VARCHAR(70) NOT NULL ,
  `Дата_рождения` DATE NOT NULL ,
  `Адрес` VARCHAR(255) NOT NULL ,
  `Телефон` VARCHAR(18) NULL ,
  `Паспорт` VARCHAR(255) NOT NULL ,
  `Должность` VARCHAR(70) NOT NULL ,
  `Тип` VARCHAR(24) NOT NULL ,
  `Статус` VARCHAR(8) NOT NULL ,
  `Логин` VARCHAR(70) NOT NULL ,
  `Пароль` VARCHAR(30) NULL ,
  PRIMARY KEY (`ID_сотрудника`) ,
  INDEX `Отделы_сотрудники_idx` (`ID_отдела` ASC) ,
  CONSTRAINT `Отделы_сотрудники`
    FOREIGN KEY (`ID_отдела` )
    REFERENCES `Стройсервис`.`Отделы` (`ID_отдела` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Группа_услуг`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Группа_услуг` (
  `ID_группы` INT NOT NULL AUTO_INCREMENT ,
  `Название_группы` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`ID_группы`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Услуги`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Услуги` (
  `ID_услуги` INT NOT NULL AUTO_INCREMENT ,
  `ID_группы` INT NOT NULL ,
  `Наименование` VARCHAR(70) NOT NULL ,
  `Описание` LONGTEXT NULL ,
  `Цена` DECIMAL(10,2) NOT NULL ,
  PRIMARY KEY (`ID_услуги`) ,
  CONSTRAINT `ГруппаУсл_Услуги`
    FOREIGN KEY (`ID_услуги` )
    REFERENCES `Стройсервис`.`Группа_услуг` (`ID_группы` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Договора`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Договора` (
  `ID_договора` INT NOT NULL AUTO_INCREMENT ,
  `ID_клиента` INT NOT NULL ,
  `ID_сотрудника` INT NOT NULL ,
  `Номер_договора` VARCHAR(10) NOT NULL ,
  `Дата_заключения` DATE NOT NULL ,
  `Полная_стоимость` DECIMAL(10,2) NOT NULL ,
  `Дата_акта` DATE NULL ,
  PRIMARY KEY (`ID_договора`) ,
  INDEX `Клиент_договор_idx` (`ID_клиента` ASC) ,
  INDEX `Сотрудник_договор_idx` (`ID_сотрудника` ASC) ,
  CONSTRAINT `Клиент_договор`
    FOREIGN KEY (`ID_клиента` )
    REFERENCES `Стройсервис`.`Клиенты` (`ID_клиента` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Сотрудник_договор`
    FOREIGN KEY (`ID_сотрудника` )
    REFERENCES `Стройсервис`.`Сотрудники` (`ID_сотрудника` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Расчеты`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Расчеты` (
  `ID_расчета` INT NOT NULL AUTO_INCREMENT ,
  `ID_договора` INT NOT NULL ,
  `Номер_документа` INT(11) NOT NULL ,
  `Дата_расчета` DATE NOT NULL ,
  `Сумма_оплаты` DECIMAL(10,2) NOT NULL ,
  PRIMARY KEY (`ID_расчета`) ,
  INDEX `Договор_расчет_idx` (`ID_договора` ASC) ,
  CONSTRAINT `Договор_расчет`
    FOREIGN KEY (`ID_договора` )
    REFERENCES `Стройсервис`.`Договора` (`ID_договора` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Стройсервис`.`Сметы`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Стройсервис`.`Сметы` (
  `ID_сметы` INT NOT NULL AUTO_INCREMENT ,
  `ID_договора` INT NOT NULL ,
  `ID_услуги` INT NOT NULL ,
  `Дата_начала` DATE NOT NULL ,
  `Дата_окончания` DATE NOT NULL ,
  PRIMARY KEY (`ID_сметы`) ,
  INDEX `Договор_смета_idx` (`ID_договора` ASC) ,
  INDEX `Услуги_сметы_idx` (`ID_услуги` ASC) ,
  CONSTRAINT `Договор_смета`
    FOREIGN KEY (`ID_договора` )
    REFERENCES `Стройсервис`.`Договора` (`ID_договора` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Услуги_сметы`
    FOREIGN KEY (`ID_услуги` )
    REFERENCES `Стройсервис`.`Услуги` (`ID_услуги` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `Стройсервис` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
