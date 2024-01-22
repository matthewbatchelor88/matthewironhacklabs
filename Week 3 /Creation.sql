CREATE DATABASE CarStore;

USE CarStore;

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY UNIQUE NOT NULL, 
    Name VARCHAR(30),
    Phone_number INT UNIQUE NOT NULL,
    Email VARCHAR(45),
    Address VARCHAR(45), 
    City VARCHAR(30), 
    State VARCHAR(30), 
    Zip_Code INT
);

CREATE TABLE Salespersons (
    Staff_ID INT PRIMARY KEY UNIQUE NOT NULL, 
    Name VARCHAR(45), 
    Store VARCHAR(30)
);

CREATE TABLE Cars (
    VIN INT PRIMARY KEY UNIQUE NOT NULL, 
    Manufacturer VARCHAR(30), 
    Model VARCHAR(20), 
    Year INT NOT NULL, 
    Colour VARCHAR(45) 
);

CREATE TABLE Invoices (
    Invoice_Number INT PRIMARY KEY UNIQUE NOT NULL, 
    Date DATETIME, 
    Car VARCHAR(45), 
    Customer_ID INT, 
    Staff_ID INT,
    VIN INT
);

-- Adding Foreign Key Constraints using ALTER TABLE

ALTER TABLE Invoices
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID);

ALTER TABLE Invoices 
ADD CONSTRAINT fk_staff_id
FOREIGN KEY (Staff_ID) REFERENCES Salespersons(Staff_ID);

ALTER TABLE Invoices 
ADD CONSTRAINT fk_vin
FOREIGN KEY (VIN) REFERENCES Cars(VIN);

