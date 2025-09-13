CREATE DATABASE Online_Bookstore;
USE Online_Bookstore;

CREATE TABLE Books(
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(50),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Customers(
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders(
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books 
WHERE Genre = "Fiction";

-- 2) Find books published after the year 1950:
SELECT Title,Published_Year FROM Books
WHERE Published_Year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE Country = "Canada";

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) AS total_stock 
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM BOOKS
ORDER BY Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_Amount > 20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre
FROM Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY Stock
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;


-- 12) Retrieve the total number of books sold for each genre:
SELECT Books.Genre,SUM(Orders.Quantity) AS Total_Books
FROM Books INNER JOIN Orders ON Books.Book_ID = Orders.Book_ID
GROUP BY Books.Genre ;


-- 13) Find the average price of books in the "Fantasy" genre:
SELECT Genre,AVG(Price) AS Average_Price
FROM Books
WHERE Genre = "Fantasy";


-- 14) List customers who have placed at least 2 orders:
SELECT Customers.Customer_ID, Customers.Name, COUNT(Orders.Order_ID) AS ORDER_COUNT
FROM Customers JOIN Orders ON Customers.Customer_ID = Orders.Customer_ID
GROUP BY Customers.Customer_ID
HAVING COUNT(Orders.Order_ID) >=2;

-- 15) Find the most frequently ordered book:
SELECT Books.Title,COUNT(Orders.Order_ID) AS MOST_FREQUENT_ORDER_BOOKS
FROM Books JOIN Orders ON Books.Book_ID = Orders.Book_ID
GROUP BY Books.Title
ORDER BY COUNT(Orders.Order_ID) DESC
LIMIT 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books
WHERE Genre = "Fantasy"
ORDER BY Price DESC
LIMIT 3;


-- 17) Retrieve the total quantity of books sold by each author:
SELECT Books.Author , SUM(Orders.Quantity) AS TOTAL_QUANTITY
FROM Books JOIN Orders ON Books.Book_ID = Orders.Book_ID
GROUP BY Books.Author;

-- 18) List the cities where customers who spent over $30 are located:
SELECT DISTINCT Customers.City,Orders.Total_Amount
FROM Customers JOIN Orders ON Customers.Customer_ID = Orders.Customer_ID
WHERE Orders.Total_Amount > 30;

-- 19) Find the customer who spent the most on orders:
SELECT Customers.Customer_ID,Customers.Name,SUM(Orders.Total_Amount) AS TOTAL_SPENT
FROM Customers JOIN Orders ON Customers.Customer_ID = Orders.Customer_ID
GROUP BY Customers.Customer_ID,Customers.Name
ORDER BY TOTAL_SPENT DESC;

-- 20) Calculate the stock remaining after fulfilling all orders:
SELECT Books.Book_ID,Books.Title,Books.Stock,coalesce(SUM(Orders.Quantity),0) AS Order_Quantity,
Books.Stock - coalesce(SUM(Orders.Quantity),0) AS Remaining_Quantity
FROM Books LEFT JOIN Orders ON Books.Book_ID = Orders.Book_ID
GROUP BY Books.Book_ID
ORDER BY Books.Book_ID;

