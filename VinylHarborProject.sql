CREATE TABLE IF NOT EXISTS Vinyl (
    VinylID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Artist TEXT NOT NULL,
    ReleaseDate DATE NOT NULL,
    Genre TEXT NOT NULL,
    Condition TEXT NOT NULL,
    CoverCondition TEXT NOT NULL,
    Price REAL NOT NULL,
    Description TEXT NOT NULL,
    SellerID INTEGER NOT NULL,
	CustomerID INTEGER NOT NULL,
    OnSell INTEGER NOT NULL CHECK (onSell IN (0, 1)) 
);

CREATE TABLE IF NOT EXISTS Transaction_Vinyl (
    TransactionID INTEGER PRIMARY KEY AUTOINCREMENT,
    VinylID INTEGER REFERENCES Vinyl(VinylID),
    CustomerID INTEGER REFERENCES User(UserID),
    SellerID INTEGER REFERENCES User(UserID),
    TransactionDate DATE,
    TransactionAmount REAL
);

CREATE TABLE IF NOT EXISTS User (
	UserID INTEGER PRIMARY KEY AUTOINCREMENT,
	Username TEXT UNIQUE CHECK (Username NOT LIKE '% %'),
	Name TEXT,
	Email TEXT UNIQUE,
	Phone TEXT ,
	BillingAddress TEXT,
	ShippingAddress TEXT,
	Location TEXT,
	BookmarkedVinyls TEXT,
	SellerRating REAL,
	CustomerRating REAL,
	Description TEXT,
	Password TEXT CHECK (Password NOT LIKE '% %')
);


-- Inserting test records into the Vinyl table
INSERT INTO Vinyl (Title, Artist, ReleaseDate, Genre, Condition, CoverCondition, Price, Description, SellerID, CustomerID, OnSell) 
VALUES 
('Vinyl 1', 'Artist 1', '2023-01-01T22:42:46.187', 'Rock', 'Mint', 'Good', 29.99, 'Description 1', 1, 2, 1),
('Vinyl 2', 'Artist 2', '2022-05-15T22:42:46.187', 'Pop', 'Good', 'Fair', 19.99, 'Description 2', 2, 3, 0),
('Vinyl 3', 'Artist 3', '2023-09-30T22:42:46.187', 'Jazz', 'Mint', 'Excellent', 39.99, 'Description 3', 3, 1, 1);

-- Inserting test records into the User table
INSERT INTO User (Username, Name, Email, Phone, BillingAddress, ShippingAddress, Location, BookmarkedVinyls, SellerRating, CustomerRating, Description, Password) 
VALUES 
('user1', 'John Doe', 'john@example.com', '+123456789', 'Billing Address 1', 'Shipping Address 1', 'Location 1', '[1,2]', 4.5, 3.9, 'User 1 Description', 'password1'),
('user2', 'Jane Smith', 'jane@example.com', '+987654321', 'Billing Address 2', 'Shipping Address 2', 'Location 2', '[3]', 4.2, 4.0, 'User 2 Description', 'password2'),
('user3', 'Alice Johnson', 'alice@example.com', '+111222333', 'Billing Address 3', 'Shipping Address 3', 'Location 3', '[]', 4.8, 4.7, 'User 3 Description', 'password3');



-- Inserting test records into the Transaction_Vinyl table
INSERT INTO Transaction_Vinyl (VinylID, CustomerID, SellerID, TransactionDate, TransactionAmount) 
VALUES 
(1, 2, 1, '2023-02-10T22:42:46.187', 29.99),
(2, 3, 2, '2022-06-01T22:42:46.187', 19.99),
(3, 1, 3, '2023-10-05T22:42:46.187', 39.99);


-- 1. Select all vinyl records
SELECT * FROM Vinyl;

-- 2. Select vinyl records where Genre is 'Rock'
SELECT * FROM Vinyl WHERE Genre = 'Rock';

-- 3. Select the most expensive vinyl record
SELECT * FROM Vinyl ORDER BY Price DESC LIMIT 1;

-- 4. Update the description of Vinyl with ID 2
UPDATE Vinyl SET Description = 'New Description' WHERE VinylID = 2;

-- 5. Delete a transaction with TransactionID 1
DELETE FROM Transaction_Vinyl WHERE TransactionID = 1;

-- 6. Count the number of vinyl records
SELECT COUNT(*) FROM Vinyl;

-- 7. Find the average SellerRating
SELECT AVG(SellerRating) FROM User;

-- 8. List users who have SellerRating above 4.0
SELECT * FROM User WHERE SellerRating  = 0.0;

-- 9. Join to find transactions with user details
SELECT Transaction_Vinyl.TransactionID, User.Username, User.Email 
FROM Transaction_Vinyl 
JOIN User ON Transaction_Vinyl.CustomerID = User.UserID;

-- 10. Calculate the total sales amount
SELECT SUM(TransactionAmount) AS TotalSales FROM Transaction_Vinyl;