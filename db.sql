-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `EmployeeID` INT NOT NULL,
  `FullName` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NULL,
  `DateOfBirth` DATE NOT NULL,
  `IdentificationType` VARCHAR(45) NOT NULL,
  `IdentificationNumber` VARCHAR(45) NOT NULL,
  `Citizenship` VARCHAR(45) NOT NULL,
  `Visa` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `BankCardNumber` VARCHAR(45) NOT NULL,
  `EmailAddress` VARCHAR(45) NOT NULL,
  `HomePhoneNumber` VARCHAR(45) NULL,
  `MobilePhoneNumber` VARCHAR(45) NOT NULL,
  `Login` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `TypeName` VARCHAR(45) NOT NULL,
  `Discount` FLOAT NOT NULL,
  PRIMARY KEY (`TypeName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Guest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Guest` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Guest` (
  `GuestID` INT NOT NULL,
  `FullName` VARCHAR(45) NOT NULL,
  `IdentificationType` VARCHAR(45) NOT NULL,
  `IdentificationNumber` VARCHAR(45) NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `HomePhoneNumber` VARCHAR(45) NULL,
  `MobilePhoneNumber` VARCHAR(45) NOT NULL,
  `Login` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `CategoryName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GuestID`),
  INDEX `fk_Guest_Category1_idx` (`CategoryName` ASC) VISIBLE,
  CONSTRAINT `fk_Guest_Category1`
    FOREIGN KEY (`CategoryName`)
    REFERENCES `mydb`.`Category` (`TypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Hotel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Hotel` (
  `HotelID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `Region` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`HotelID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee_At_Hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee_At_Hotel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee_At_Hotel` (
  `EmployeeID` INT NOT NULL,
  `HotelID` INT NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `PayRate` VARCHAR(45) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`HotelID`, `EmployeeID`),
  INDEX `fk_Employee_has_Hotel_Hotel1_idx` (`HotelID` ASC) VISIBLE,
  INDEX `fk_Employee_has_Hotel_Employee_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_has_Hotel_Employee`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_Hotel_Hotel1`
    FOREIGN KEY (`HotelID`)
    REFERENCES `mydb`.`Hotel` (`HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Time_Period`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Time_Period` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Time_Period` (
  `DayOfTheWeek` CHAR(1) NOT NULL,
  `SeasonName` VARCHAR(45) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  PRIMARY KEY (`DayOfTheWeek`, `SeasonName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Phone_Number`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Phone_Number` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Phone_Number` (
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `HotelID` INT NOT NULL,
  PRIMARY KEY (`PhoneNumber`, `HotelID`),
  INDEX `fk_Phone_Number_Hotel1_idx` (`HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Phone_Number_Hotel1`
    FOREIGN KEY (`HotelID`)
    REFERENCES `mydb`.`Hotel` (`HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Room_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Room_Type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Room_Type` (
  `TypeName` VARCHAR(45) NOT NULL,
  `Size` DOUBLE NOT NULL,
  `Capacity` INT NOT NULL,
  `NumberOfRooms` INT NOT NULL,
  `NumberOfAvailableRooms` INT NOT NULL,
  `HotelID` INT NOT NULL,
  PRIMARY KEY (`TypeName`, `HotelID`),
  INDEX `fk_Room_Type_Hotel1_idx` (`HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Type_Hotel1`
    FOREIGN KEY (`HotelID`)
    REFERENCES `mydb`.`Hotel` (`HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Room` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Room` (
  `RoomNumber` VARCHAR(5) NOT NULL,
  `Floor` INT NOT NULL,
  `Cleaned` TINYINT NOT NULL,
  `Occupied` TINYINT NOT NULL,
  `NumberOfOccupants` INT NOT NULL,
  `RoomTypeName` VARCHAR(45) NOT NULL,
  `HotelID` INT NOT NULL,
  PRIMARY KEY (`RoomNumber`, `Floor`, `RoomTypeName`, `HotelID`),
  INDEX `fk_Room_Room_Type1_idx` (`RoomTypeName` ASC, `HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Room_Type1`
    FOREIGN KEY (`RoomTypeName` , `HotelID`)
    REFERENCES `mydb`.`Room_Type` (`TypeName` , `HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Single_Stay`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Single_Stay` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Single_Stay` (
  `CheckInDate` DATE NOT NULL,
  `CheckOutDate` DATE NULL,
  `FinalBill` DOUBLE NULL,
  `RoomNumber` VARCHAR(5) NOT NULL,
  `RoomFloor` INT NOT NULL,
  `GuestID` INT NOT NULL,
  PRIMARY KEY (`CheckInDate`, `RoomNumber`, `RoomFloor`, `GuestID`),
  INDEX `fk_Single_Stay_Room1_idx` (`RoomNumber` ASC, `RoomFloor` ASC) VISIBLE,
  INDEX `fk_Single_Stay_Guest1_idx` (`GuestID` ASC) VISIBLE,
  CONSTRAINT `fk_Single_Stay_Room1`
    FOREIGN KEY (`RoomNumber` , `RoomFloor`)
    REFERENCES `mydb`.`Room` (`RoomNumber` , `Floor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Single_Stay_Guest1`
    FOREIGN KEY (`GuestID`)
    REFERENCES `mydb`.`Guest` (`GuestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Feature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Feature` (
  `FeatureName` VARCHAR(45) NOT NULL,
  `RoomTypeName` VARCHAR(45) NOT NULL,
  `HotelID` INT NOT NULL,
  PRIMARY KEY (`FeatureName`, `RoomTypeName`, `HotelID`),
  INDEX `fk_Feature_Room_Type1_idx` (`RoomTypeName` ASC, `HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Feature_Room_Type1`
    FOREIGN KEY (`RoomTypeName` , `HotelID`)
    REFERENCES `mydb`.`Room_Type` (`TypeName` , `HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Additional_Feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Additional_Feature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Additional_Feature` (
  `FeatureName` VARCHAR(45) NOT NULL,
  `Cost` DOUBLE NOT NULL,
  `StartTime` TIME NOT NULL,
  `EndTime` TIME NOT NULL,
  `HotelID` INT NOT NULL,
  PRIMARY KEY (`FeatureName`, `HotelID`),
  INDEX `fk_Additional_Feature_Hotel1_idx` (`HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Additional_Feature_Hotel1`
    FOREIGN KEY (`HotelID`)
    REFERENCES `mydb`.`Hotel` (`HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Initial_Price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Initial_Price` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Initial_Price` (
  `RoomTypeName` VARCHAR(45) NOT NULL,
  `HotelID` INT NOT NULL,
  `DayOfTheWeek` CHAR(1) NOT NULL,
  `SeasonName` VARCHAR(45) NOT NULL,
  `Amount` DOUBLE NOT NULL,
  PRIMARY KEY (`RoomTypeName`, `HotelID`, `DayOfTheWeek`, `SeasonName`),
  INDEX `fk_Room_Type_has_Time_Period_Time_Period1_idx` (`DayOfTheWeek` ASC, `SeasonName` ASC) VISIBLE,
  INDEX `fk_Room_Type_has_Time_Period_Room_Type1_idx` (`RoomTypeName` ASC, `HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Type_has_Time_Period_Room_Type1`
    FOREIGN KEY (`RoomTypeName` , `HotelID`)
    REFERENCES `mydb`.`Room_Type` (`TypeName` , `HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_Type_has_Time_Period_Time_Period1`
    FOREIGN KEY (`DayOfTheWeek` , `SeasonName`)
    REFERENCES `mydb`.`Time_Period` (`DayOfTheWeek` , `SeasonName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Operates_During`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Operates_During` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Operates_During` (
  `HotelID` INT NOT NULL,
  `DayOfTheWeek` CHAR(1) NOT NULL,
  `SeasonName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`HotelID`, `DayOfTheWeek`, `SeasonName`),
  INDEX `fk_Hotel_has_Time_Period_Time_Period1_idx` (`DayOfTheWeek` ASC, `SeasonName` ASC) VISIBLE,
  INDEX `fk_Hotel_has_Time_Period_Hotel1_idx` (`HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Hotel_has_Time_Period_Hotel1`
    FOREIGN KEY (`HotelID`)
    REFERENCES `mydb`.`Hotel` (`HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hotel_has_Time_Period_Time_Period1`
    FOREIGN KEY (`DayOfTheWeek` , `SeasonName`)
    REFERENCES `mydb`.`Time_Period` (`DayOfTheWeek` , `SeasonName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reserves`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Reserves` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Reserves` (
  `RoomTypeName` VARCHAR(45) NOT NULL,
  `HotelID` INT NOT NULL,
  `GuestID` INT NOT NULL,
  `CheckInDate` DATE NOT NULL,
  `CheckOutDate` DATE NOT NULL,
  `NumberOfOccupants` INT NOT NULL,
  PRIMARY KEY (`RoomTypeName`, `HotelID`, `GuestID`),
  INDEX `fk_Room_Type_has_Guest_Guest1_idx` (`GuestID` ASC) VISIBLE,
  INDEX `fk_Room_Type_has_Guest_Room_Type1_idx` (`RoomTypeName` ASC, `HotelID` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Type_has_Guest_Room_Type1`
    FOREIGN KEY (`RoomTypeName` , `HotelID`)
    REFERENCES `mydb`.`Room_Type` (`TypeName` , `HotelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_Type_has_Guest_Guest1`
    FOREIGN KEY (`GuestID`)
    REFERENCES `mydb`.`Guest` (`GuestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Occupies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Occupies` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Occupies` (
  `RoomNumber` VARCHAR(5) NOT NULL,
  `Floor` INT NOT NULL,
  `GuestID` INT NOT NULL,
  `CheckInDate` DATE NOT NULL,
  `CheckOutDate` DATE NULL,
  PRIMARY KEY (`RoomNumber`, `Floor`, `GuestID`),
  INDEX `fk_Room_has_Guest_Guest1_idx` (`GuestID` ASC) VISIBLE,
  INDEX `fk_Room_has_Guest_Room1_idx` (`RoomNumber` ASC, `Floor` ASC) VISIBLE,
  CONSTRAINT `fk_Room_has_Guest_Room1`
    FOREIGN KEY (`RoomNumber` , `Floor`)
    REFERENCES `mydb`.`Room` (`RoomNumber` , `Floor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_has_Guest_Guest1`
    FOREIGN KEY (`GuestID`)
    REFERENCES `mydb`.`Guest` (`GuestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Single_Stay_With_Feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Single_Stay_With_Feature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Single_Stay_With_Feature` (
  `FeatureName` VARCHAR(45) NOT NULL,
  `CheckInDate` DATE NOT NULL,
  `RoomNumber` VARCHAR(5) NOT NULL,
  `Floor` INT NOT NULL,
  `GuestID` INT NOT NULL,
  `NumberOfUsage` INT NOT NULL,
  PRIMARY KEY (`FeatureName`, `CheckInDate`, `RoomNumber`, `Floor`, `GuestID`),
  INDEX `fk_Additional_Feature_has_Single_Stay_Single_Stay1_idx` (`CheckInDate` ASC, `RoomNumber` ASC, `Floor` ASC, `GuestID` ASC) VISIBLE,
  INDEX `fk_Additional_Feature_has_Single_Stay_Additional_Feature1_idx` (`FeatureName` ASC) VISIBLE,
  CONSTRAINT `fk_Additional_Feature_has_Single_Stay_Additional_Feature1`
    FOREIGN KEY (`FeatureName`)
    REFERENCES `mydb`.`Additional_Feature` (`FeatureName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Additional_Feature_has_Single_Stay_Single_Stay1`
    FOREIGN KEY (`CheckInDate` , `RoomNumber` , `Floor` , `GuestID`)
    REFERENCES `mydb`.`Single_Stay` (`CheckInDate` , `RoomNumber` , `RoomFloor` , `GuestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
