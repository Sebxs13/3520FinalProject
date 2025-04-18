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
	userId SMALLINT PRIMARY KEY AUTO_INCREMENT,
	firstName VARCHAR(20) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	email VARCHAR(320) UNIQUE NOT NULL,
	phoneNumber VARCHAR(20) UNIQUE NOT NULL,
	userType enum('Driver', 'Passenger') NOT NULL
);


-- table structure for table 'Passenger'

CREATE TABLE IF NOT EXISTS Passenger(
	passengerId SMALLINT PRIMARY KEY AUTO_INCREMENT,
	rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5),
    userId SMALLINT NOT NULL,
	FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);


-- table structure for table 'Driver'

CREATE TABLE IF NOT EXISTS Driver (
	driverId SMALLINT AUTO_INCREMENT,
	licenseNumber VARCHAR(50) UNIQUE NOT NULL,
	vehicleType ENUM('sedan', 'suv', 'van'),
	rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5) NOT NULL,
    userId SMALLINT NOT NULL,
    PRIMARY KEY (driverId),
	FOREIGN KEY (userId) REFERENCES User(userId) on DELETE CASCADE
);


-- table structure for table 'Booking'

CREATE TABLE IF	NOT EXISTS Booking(
	bookingId SMALLINT PRIMARY KEY AUTO_INCREMENT,
	driverId SMALLINT NOT NULL,
	userId SMALLINT NOT NULL,
	rideId SMALLINT NOT NULL,
	seatCount INT NOT NULL CHECK (seatCount > 0),
	FOREIGN KEY (driverId) REFERENCES Driver(driverId) ON DELETE CASCADE,
	FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);


-- table structure for table 'Notification'

CREATE TABLE IF NOT EXISTS Notification (
	notificationId SMALLINT PRIMARY KEY AUTO_INCREMENT,
	userId SMALLINT,
	message VARCHAR(1000),
	stampTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);

-- table structure for table 'Payment'
CREATE TABLE IF NOT EXISTS Payment (
	paymentId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2),
    transactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('completed', 'failed'),
    bookingId SMALLINT NOT NULL,
    FOREIGN KEY (bookingId) REFERENCES Booking(bookingId)
);

-- table structure for table 'Ride'
CREATE TABLE IF NOT EXISTS Ride (
	rideId SMALLINT AUTO_INCREMENT NOT NULL,
    bookingId SMALLINT NOT NULL UNIQUE,
    startLocation VARCHAR(255),
    endLocation VARCHAR(255),
    distance_m DECIMAL(10,2),
    price DECIMAL(10,2),
    pickupTime DATETIME,
    dropoffTime DATETIME,
    status ENUM('requested', 'accepted', 'in_progress', 'completed', 'canceled'),
    PRIMARY KEY (rideId),
    FOREIGN KEY (bookingId) REFERENCES Booking(bookingId) ON DELETE CASCADE
);

-- table structure for table 'Tracking'
CREATE TABLE IF NOT EXISTS Tracking(
	trackingId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    rideId SMALLINT NOT NULL,
    driverLocation VARCHAR(255), -- e.g. "Downtown Salt Lake", "University Pkwy & State St"
    eta DATETIME,
    FOREIGN KEY (rideId) REFERENCES Ride(rideId)
);

CREATE TABLE IF NOT EXISTS Vehicle (
    vehicleId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    driverId SMALLINT NOT NULL,
    make VARCHAR(50),
    model VARCHAR(50),
    year YEAR,
    licensePlate VARCHAR(20) UNIQUE,
    color VARCHAR(20),
    FOREIGN KEY (driverId) REFERENCES Driver(driverId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Review (
    reviewId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    reviewerId SMALLINT NOT NULL,
    revieweeId SMALLINT NOT NULL,
    rideId SMALLINT NOT NULL,
    rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5),
    comment TEXT,
    reviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reviewerId) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (revieweeId) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (rideId) REFERENCES Ride(rideId) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS LocationHistory (
    locationId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    rideId SMALLINT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    FOREIGN KEY (rideId) REFERENCES Ride(rideId) ON DELETE CASCADE
);
ALTER TABLE Payment
ADD COLUMN tipAmount DECIMAL(10,2) DEFAULT 0.00;

CREATE TABLE IF NOT EXISTS RidePreference (
    preferenceId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    userId SMALLINT NOT NULL,
    prefersQuietRide BOOLEAN DEFAULT FALSE,
    allowsPets BOOLEAN DEFAULT FALSE,
    prefersMusic BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Message (
    messageId INT AUTO_INCREMENT PRIMARY KEY,
    senderId SMALLINT NOT NULL,
    receiverId SMALLINT NOT NULL,
    content TEXT NOT NULL,
    sentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rideId SMALLINT,
    FOREIGN KEY (senderId) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (receiverId) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (rideId) REFERENCES Ride(rideId) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS LoginHistory (
    loginId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    userId SMALLINT NOT NULL,
    loginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ipAddress VARCHAR(45),
    deviceInfo VARCHAR(255),
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Address (
    addressId SMALLINT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zipCode VARCHAR(10),
    country VARCHAR(100)
);

