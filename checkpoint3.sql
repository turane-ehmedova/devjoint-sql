-- DevJoint Internship
-- Checkpoint 3
-- Topic:GROUP BY/HAVING ilə aqreqasiya
-- Database: Northwind

--Query 1: Employees və Orders cədvəllərini INNER JOIN edərək
--hər işçinin adını, soyadını və qəbul etdiyi sifarişlərin sayını göstərək.
SELECT Employees.LastName, Employees.FirstName,
count(Orders.OrderID) as totalorders
FROM Employees INNER JOIN Orders on Employees.EmployeeID = Orders.EmployeeID
GROUP by Employees.LastName, Employees.FirstName; 

--Query 2: Categories və Products cədvəllərini INNER JOIN edərək
--hər kateqoriyanın adını və həmin kateqoriyada olan məhsulların sayını göstərək.
SELECT Categories.CategoryName,
count(Products.ProductID) as totalproducts
FROM Categories INNER JOIN Products on Categories.CategoryID = Products.CategoryID
GROUP by Categories.CategoryName;

--Query 3: Categories və Products cədvəllərini INNER JOIN edərək
--hər kateqoriyanın adını və məhsulların orta qiymətini göstərək.
SELECT Categories.CategoryName,
avg(Products.UnitPrice)
FROM Categories INNER JOIN Products on Categories.CategoryID = Products.CategoryID
GROUP by Categories.CategoryName;

--Query 4: Categories və Products cədvəllərini INNER JOIN edərək
--hər kateqoriyanın adını, ən yüksək və ən aşağı məhsul qiymətini göstərək.
SELECT Categories.CategoryName,
max(Products.UnitPrice), min(Products.UnitPrice)
FROM Categories INNER JOIN Products on Categories.CategoryID = Products.CategoryID
GROUP by Categories.CategoryName
LIMIT 5;

--Query 5: Customers və Orders cədvəllərini INNER JOIN edərək
--müştərilərin şirkət adını və verdikləri sifarişlərin sayını göstərək.
--Yalnız 10-dan çox sifariş verən müştəriləri göstərək.
SELECT Customers.CompanyName,
count(Orders.OrderID)
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
GROUP by Customers.CompanyName
HAVING count(OrderID)>10;

--Query 6: Customers və Orders cədvəllərini INNER JOIN edərək
--müştərilərin əlaqə saxlanılan şəxsin adını və verdikləri sifarişlərin sayını göstərək.
--Nəticəni sifariş sayına görə azalan sıra ilə göstərək.
SELECT Customers.ContactName,
count(Orders.OrderID)
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
GROUP by customers.ContactName
ORDER by count(OrderID) DESC;

--Query 7: Customers, Orders və Order Details cədvəllərini INNER JOIN edərək
--müştərinin şirkət adını və sifariş etdiyi məhsulların ümumi miqdarını göstərək.
SELECT Customers.CompanyName,
sum([Order Details].Quantity)
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderId
GROUP by Customers.CompanyName;

--Query 8: Customers, Orders və Order Details cədvəllərini INNER JOIN edərək
--müştərilərin şirkət adını və sifariş etdikləri məhsulların ümumi
--miqdarını göstərək. Nəticəni ən yüksəkdən aşağıya sıralayıb
--ilk 5 müştərini göstərək.
SELECT Customers.CompanyName,
sum([Order Details].Quantity)
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderId
GROUP by Customers.CompanyName
ORDER by sum([Order Details].Quantity) DESC
LIMIT 5;

--Query 9: Orders və Order Details cədvəllərini INNER JOIN edərək
--hər il və ay üzrə satılan məhsulların ümumi miqdarını göstərək.
--strftime -> SQLite-ın tarix funksiyasıdır.
SELECT 
strftime('%Y', Orders.OrderDate) AS Year,
strftime('%m', Orders.OrderDate) AS Month,
sum([Order Details].Quantity)
FROM Orders INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderId
GROUP by 
strftime('%Y', Orders.OrderDate),
strftime('%m', Orders.OrderDate);

--Query 10: Customers, Orders və Order Details cədvəllərini INNER JOIN edərək
--müştərilərin şirkət adını və ümumi gəlirini göstərək.
--Gəliri UnitPrice × Quantity × (1 - Discount) düsturu ilə hesablayıb,
--nəticəni gəlirə görə azalan sırada düzək və ilk 5 müştərini göstərək.
SELECT Customers.CompanyName,
sum(UnitPrice * Quantity * (1 - Discount)) as TotalRevenue
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderId
GROUP by Customers.CompanyName
ORDER by sum(UnitPrice * Quantity * (1 - Discount)) DESC
LIMIT 5;