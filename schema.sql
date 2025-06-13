-- Drop Creating  Use DataBase

DROP DATABASE IF EXISTS CarDealershipDatabase;

CREATE DATABASE IF NOT EXISTS CarDealershipDatabase;

USE CarDealershipDatabase;

-- Create dealership table
CREATE TABLE dealerships (
    dealership_id INT AUTO_INCREMENT PRIMARY KEY
	,name varchar(50)
    ,address varchar(50)
	,phone varchar(12)

);

-- Create Vehicle table
CREATE TABLE vehicles (
	VIN INT PRIMARY KEY
    ,year INT
	,make VARCHAR(30)
    ,model VARCHAR(30)
    ,vehicleType VARCHAR(30)
    ,color VARCHAR(15)
    ,odometer INT
    ,price DECIMAL(10,2)
    ,sold BOOLEAN
);

-- Create inventory table
CREATE TABLE inventory(
   dealership_id INT
   ,VIN INT
   ,PRIMARY KEY (dealership_id, VIN) -- to prevent duplicates
   ,FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id)
   ,FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
); 

-- create sales_contracts table
CREATE TABLE sales_contracts (
   id INT AUTO_INCREMENT PRIMARY KEY
   ,VIN INT
   ,sale_date DATE
   ,customer_name VARCHAR(50)
   ,customer_email VARCHAR(50)
   ,price DECIMAL(10,2)
   ,tax DECIMAL(10,2)
   ,recording_fee DECIMAL(10,2)
   ,processing_fee DECIMAL(10,2)
   ,is_financed BOOLEAN
   ,total_price DECIMAL(10,2)
   ,monthly_payment DECIMAL(10,2)
   ,FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);

-- create lease_contracts table
CREATE TABLE lease_contracts (
	id INT AUTO_INCREMENT PRIMARY KEY
	,VIN INT
	,lease_date DATE
	,customer_name VARCHAR(50)
	,customer_email VARCHAR(50)
	,price DECIMAL(10,2)
	,total_price DECIMAL(10,2)
	,monthly_payment DECIMAL(10,2)
	,FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);

-- Add sample data to dealership table.
INSERT INTO cardealershipdatabase.dealerships (name,address, phone)
VALUES
('City Auto Mall','123 Main St','123-456-7890'),
('Premier Motors', '456 Elm St', '234-567-8901'),
('Sunrise Cars', '789 Oak Ave', '345-678-9012');

-- Add sample data to vehicle table.
INSERT INTO cardealershipdatabase.vehicles (VIN, year, make, model, vehicleType, color, odometer, price, sold)
 VALUES
(1001, 2020, 'Toyota', 'Camry', 'Sedan', 'Silver', 30000, 22000.00, FALSE),
(1002, 2019, 'Honda', 'Civic', 'Sedan', 'Blue', 40000, 18500.00, FALSE),
(1003, 2021, 'Ford', 'Mustang', 'Coupe', 'Red', 15000, 31000.00, TRUE),
(1004, 2022, 'Tesla', 'Model 3', 'Sedan', 'White', 5000, 40000.00, FALSE);

-- Add sample data to inventory table.
INSERT INTO cardealershipdatabase.inventory (dealership_id, VIN) 
VALUES
(1, 1001),
(1, 1002),
(2, 1003),
(3, 1004),
(2, 1001);  -- Vehicle at multiple locations

-- Add sample data to sales_contract table.
INSERT INTO cardealershipdatabase.sales_contracts
 (VIN, sale_date, customer_name, customer_email, price, tax, recording_fee, processing_fee, is_financed, total_price, monthly_payment)
 VALUES
(1003, '2024-12-15', 'Jane Smith', 'jane@example.com', 31000.00, 1550.00, 100.00, 495.00, TRUE, 33145.00, 550.00);

-- Add sample data to lease_contracts table.
INSERT INTO cardealershipdatabase.lease_contracts
 (VIN, lease_date, customer_name, customer_email, price, total_price, monthly_payment)
 VALUES
(1002, '2025-01-10', 'John Doe', 'john@example.com', 18500.00, 16200.00, 450.00);


-- =========================================================
-- 🚗 QUESTION 1: Get all dealerships
-- =========================================================
SELECT * 
FROM cardealershipdatabase.dealerships;

-- =========================================================
-- 🚙 QUESTION 2: Find all vehicles for a specific dealership
-- =========================================================
SELECT  year
       ,V.make
       ,V.model
       ,V.vehicleType
       ,V.color
       ,V.odometer
       ,V.price
       ,D.name
       
FROM vehicles V
JOIN inventory I
ON I.VIN = V.VIN
JOIN dealerships D
ON I.dealership_id = D.dealership_id
WHERE D.name = 'City Auto Mall' ;

-- =========================================================
-- 🔍 Q4: Find a car by VIN
-- =========================================================
SELECT year
       ,V.make
       ,V.model
       ,V.vehicleType
       ,V.color
       ,V.odometer
       ,V.price 
       ,V.VIN
FROM  vehicles V
WHERE VIN = 1001;

-- =========================================================
-- 🔍 Q4: Find the dealership where a car is located by VIN
-- =========================================================
SELECT D.address
	   ,D.name
       ,I.VIN
FROM dealerships D
JOIN inventory I
ON I.dealership_id= D.dealership_id
WHERE I.VIN = 1001;

-- ==================================================
-- 🚘 QUESTION 5: Dealerships with a Red Ford Mustang
-- ==================================================
SELECT *
FROM cardealershipdatabase.dealerships D
JOIN cardealershipdatabase.inventory I
ON I.dealership_id= D.dealership_id
JOIN cardealershipdatabase.vehicles V
ON V.VIN = I.VIN
WHERE(V.color = 'Red' AND V.make='Ford' AND V.model='Mustang');

-- =========================================================
-- 💰 QUESTION 6: Sales info for a specific dealer & date
-- =========================================================
SELECT      SC.sale_date
			, SC.customer_name
			, SC.customer_email
			, SC.price
			, SC.tax
			, SC.recording_fee
			, SC.is_financed
			, SC.total_price
			, SC.monthly_payment
FROM sales_contracts SC
JOIN inventory I ON I.VIN = SC.VIN
WHERE I.dealership_id = 2 AND SC.sale_date BETWEEN '2024-01-01' AND '2024-12-31';