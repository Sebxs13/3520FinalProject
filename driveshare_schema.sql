/*

CS 3520 - Database Theory Section 002
Final Project: Database for DriveShare application
Group Members: Matthew Hamp, Brooke Mahrt and Sebastian Osorio

This file contains the schema model for DriveShare application.

*/

DROP DATABASE IF EXISTS driveshare;
CREATE DATABASE driveshare;
USE driveshare;

-- table structure for table 'User'
CREATE TABLE IF NOT EXISTS User (
	userId INT PRIMARY KEY AUTO_INCREMENT,
	firstName VARCHAR(20) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	email VARCHAR(320) UNIQUE NOT NULL,
	phoneNumber VARCHAR(20) UNIQUE NOT NULL,
	userType enum('Driver', 'Passenger') NOT NULL
);


-- table structure for table 'Passenger'

CREATE TABLE IF NOT EXISTS Passenger(
	passengerId INT PRIMARY KEY AUTO_INCREMENT,
	rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5)
	FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);


-- table structure for table 'Driver'

CREATE TABLE IF NOT EXISTS Driver (
	driverId INT PRIMARY KEY AUTO_INCREMENT,
	licenseNumber VARCHAR(50) UNIQUE NOT NULL,
	vehicleType VARCHAR(50) NOT NULL,
	rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5) NOT NULL,
	FOREIGN KEY userId REFERENCES User(userId) on DELETE CASCADE
);


-- table structure for table 'Booking'

CREATE TABLE IF	NOT EXISTS Booking(
	bookingId INT PRIMARY KEY AUTO_INCREMENT,
	driverId INT,
	userId INT,
	rideId INT,
	seatCount INT NOT NULL CHECK (seatCount > 0),
	FOREIGN KEY (driverId) REFERENCES Driver(userId) ON DELETE CASCADE,
	FOREIGN KEY (userId) REFERENCES Passenger(userId) ON DELETE CASCADE
);


-- table structure for table 'Notification'

CREATE TABLE IF NOT EXISTS Notification (
	notificationId INT PRIMARY KEY AUTO_INCREMENT,
	userId INT,
	message VARCHAR(1000),
	stampTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
