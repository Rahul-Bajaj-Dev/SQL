-- 1. Retrieve the names of all customers who have placed orders in the last month.
SELECT DISTINCT C.Name 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderDate >= DATEADD(MONTH, -1, GETDATE());

-- 2. Add a new product to the product catalog.
INSERT INTO Products (ProductName, Price, SupplierID) 
VALUES ('New Product Name', 100.00, 1); -- Replace with actual details

-- 3. Update the price of a specific product.
UPDATE Products 
SET Price = 120.00 -- New price
WHERE ProductID = 101; -- Replace with actual ProductID

-- 4. Remove a customer's order from the database.
DELETE FROM Orders 
WHERE OrderID = 202; -- Replace with actual OrderID

-- 5. Fetch the product name and its corresponding supplier name for all products.
SELECT P.ProductName, S.SupplierName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 6. Determine the total revenue generated from orders placed in a specific quarter.
SELECT SUM(O.TotalAmount) AS TotalRevenue
FROM Orders O
WHERE DATEPART(QUARTER, O.OrderDate) = 2 -- Replace with desired quarter
  AND YEAR(O.OrderDate) = 2023; -- Replace with desired year

-- 7. Find the average order value for each customer.
SELECT C.Name, AVG(O.TotalAmount) AS AverageOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name;

-- 8. Identify the customer who has placed the highest number of orders.
SELECT TOP 1 C.Name, COUNT(O.OrderID) AS OrderCount
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name
ORDER BY OrderCount DESC;

-- 9. Speed up the retrieval of customer information based on their email addresses.
CREATE INDEX idx_customer_email ON Customers(Email);

-- 10. Separate customer details (like addresses) into a different table to avoid redundancy.
-- Create a new table for addresses.
CREATE TABLE CustomerAddresses (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    Address NVARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Migrate address data from Customers to CustomerAddresses.
INSERT INTO CustomerAddresses (CustomerID, Address)
SELECT CustomerID, Address
FROM Customers;

-- Remove the Address column from Customers.
ALTER TABLE Customers DROP COLUMN Address;
