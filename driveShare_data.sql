
-- we will use this file to load data into the DriveShare database

INSERT INTO User (firstName, lastName, email, phoneNumber, userType) VALUES
('Gertrude', 'Rich', 'grich@gmail.com', '801-411-0095', 'Passenger'),
('Donna', 'Johnson', 'donnafjohnson@outlook.com', '623-011-3129', 'Driver'),
('Charlie', 'Lee', 'charliell@gmail.com', '324-019-3482', 'Passenger'),
('Wyatt', 'Cox', 'wsc@gmail.com', '021-018-3282', 'Driver');

INSERT INTO Passenger (rating, userId) VALUES
(4.8, 1),
(4.2, 3);

INSERT INTO Driver (licenseNumber, vehicleType, rating, userId) VALUES
('3CDC1', 'suv', 4.9, 2);

INSERT INTO Booking (driverId, userId, rideId, seatCount) VALUES
(1, 1, 1, 2),
(1, 3, 2, 1);

INSERT INTO Notification (userId, message) VALUES
(1, 'Your ride has been confirmed.'),
(3, 'Driver is en route.');

INSERT INTO Payment (amount, status, bookingId, tipAmount) VALUES
(25.00, 'completed', 1, 3.54),
(10.50, 'completed', 2, 1.00);

INSERT INTO Ride (bookingId, startLocation, endLocation, distance_m, price, pickupTime, dropoffTime, status) VALUES
(1, '123 Main St', '456 Park Ave', 12000.00, 25.00, '2025-04-18 08:21:10', '2025-04-18 08:53:11', 'completed'),
(2, '789 Elm St', '321 Oak Dr', 5000.00, 10.50, '2025-04-18 09:21:09', '2025-04-18 09:52:57', 'completed');

INSERT INTO Tracking (rideId, driverLocation, eta) VALUES
(1, 'Utah Valley University', '2025-04-18 08:35:00'),
(2, 'Barnes and Noble- Orem', '2025-04-18 09:05:00');

INSERT INTO Vehicle (driverId, make, model, year, licensePlate, color) VALUES
(1, 'Toyota', 'RAV4', 2022, 'XYZ1234', 'Blue');

INSERT INTO Review (reviewerId, revieweeId, rideId, rating, comment) VALUES
(1, 2, 1, 5.0, 'Excellent driver!'),
(3, 2, 2, 2.0, 'Stinky, weird, needs driving lessons');

INSERT INTO LocationHistory (rideId, latitude, longitude) VALUES
(1, 40.760780, -111.891045),
(2, 40.768721, -111.891219);

INSERT INTO RidePreference (userId, prefersQuietRide, allowsPets, prefersMusic) VALUES
(1, TRUE, FALSE, TRUE),
(3, FALSE, TRUE, FALSE);

INSERT INTO Message (senderId, receiverId, content, rideId) VALUES
(1, 2, "Hi, I'm ready at the pickup spot.", 1),
(3, 2, 'Thanks for the ride!', 2);

INSERT INTO LoginHistory (userId, ipAddress, deviceInfo) VALUES
(1, '192.168.1.2', 'iPhone 13'),
(2, '192.168.1.3', 'Samsung Galaxy S22');

INSERT INTO Address (street, city, state, zipCode, country) VALUES
('123 Main St', 'Salt Lake City', 'UT', '84101', 'USA'),
('456 Park Ave', 'Provo', 'UT', '84601', 'USA');
