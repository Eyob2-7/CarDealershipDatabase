DROP DATABASE IF EXISTS CarDealership;

CREATE DATABASE IF NOT EXISTS CarDealership;

USE CarDealership;

CREATE TABLE `dealerships` (
    `dealership_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `address` VARCHAR(50),
    `phone` VARCHAR(12),
    PRIMARY KEY (`dealership_id`)
);

CREATE TABLE `vehicles` (
    `VIN` VARCHAR(17) NOT NULL,
    `year` YEAR NOT NULL,
    `make` VARCHAR(30) NOT NULL,
    `model` VARCHAR(30) NOT NULL,
    `vehicle_type` VARCHAR(30),
    `color` VARCHAR(20),
    `odometer` INT UNSIGNED,
    `price` DECIMAL(10,2),
    PRIMARY KEY (`VIN`)
);

CREATE TABLE `inventory` (
    `inventory_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `dealership_id` INT UNSIGNED NOT NULL,
    `VIN` VARCHAR(17) NOT NULL,
    PRIMARY KEY (`inventory_id`)
);

CREATE TABLE `sales_contracts` (
    `sales_contract_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `VIN` VARCHAR(17) NOT NULL,
    `date` DATE NOT NULL,
    `customer_name` VARCHAR(50),
    `customer_email` VARCHAR(50),
    `sales_tax_amount` DECIMAL(10,2),
    `recording_fee` DECIMAL(10,2),
    `processing_fee` DECIMAL(10,2),
    `is_financed` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`sales_contract_id`)
);

CREATE TABLE `lease_contracts` (
    `lease_contract_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `VIN` VARCHAR(17) NOT NULL,
    `date` DATE NOT NULL,
    `customer_name` VARCHAR(50),
    `customer_email` VARCHAR(50),
    `expected_ending_value` DECIMAL(10,2),
    `lease_fee` DECIMAL(10,2),
    PRIMARY KEY (`lease_contract_id`)
);

INSERT INTO `dealerships` (`name`, `address`, `phone`) VALUES
('Superior Motors', '123 Main St', '555-123-4567'),
('Auto Galaxy', '456 Elm St', '555-987-6543'),
('DriveTime Deals', '789 Oak Ave', '555-456-7890');

INSERT INTO `vehicles` (`VIN`, `year`, `make`, `model`, `vehicle_type`, `color`, `odometer`, `price`) VALUES
('1HGCM82633A004352', 2020, 'Honda', 'Accord', 'Sedan', 'Red', 15000, 22000.00),
('2FMDK3GC4BBA76543', 2018, 'Ford', 'Edge', 'SUV', 'Black', 30000, 18000.00),
('1FTFW1EF1EKF51234', 2022, 'Ford', 'F-150', 'Truck', 'Blue', 5000, 45000.00),
('3VWDX7AJ5BM376543', 2019, 'Volkswagen', 'Jetta', 'Sedan', 'White', 20000, 16000.00),
('5NPE24AF0FH043210', 2021, 'Hyundai', 'Sonata', 'Sedan', 'Gray', 10000, 20000.00);

INSERT INTO `inventory` (`dealership_id`, `VIN`) VALUES
(1, '1HGCM82633A004352'),
(1, '2FMDK3GC4BBA76543'),
(2, '1FTFW1EF1EKF51234'),
(2, '3VWDX7AJ5BM376543'),
(3, '5NPE24AF0FH043210');

INSERT INTO `sales_contracts` (`VIN`, `date`, `customer_name`, `customer_email`, `sales_tax_amount`, `recording_fee`, `processing_fee`, `is_financed`) VALUES
('3VWDX7AJ5BM376543', '2024-05-15', 'John Doe', 'john.doe@example.com', 775.00, 150.00, 300.00, 1);

INSERT INTO `lease_contracts` (`VIN`, `date`, `customer_name`, `customer_email`, `expected_ending_value`, `lease_fee`) VALUES
('2FMDK3GC4BBA76543', '2025-01-01', 'Jane Smith', 'jane.smith@example.com', 12000.00, 500.00);
