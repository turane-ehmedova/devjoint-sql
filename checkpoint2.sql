-- DevJoint Internship
-- Checkpoint 2
-- Topic:JOIN-lar (INNER, LEFT, SELF-join)
-- Database: Northwind

-- Query 1:Customers və Orders cədvəllərini INNER JOIN edərək 
-- müştərinin şirkət adını, ünvanını, göndərilmə adını və ünvanını göstərək.
SELECT Customers.CompanyName, Customers.Address, Orders.ShipName, Orders.ShipAddress
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID;

--Query 2:Customers, Orders və Employees cədvəllərini INNER JOIN edərək
--müştərinin şirkət adını, ünvanını, çatdırılma məlumatlarını,
--işçinin adını və şəhərini göstərək.
SELECT Customers.CompanyName, Customers.Address, Orders.ShipName, Orders.ShipAddress, Employees.FirstName, Employees.City
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees on Orders.EmployeeID = Employees.EmployeeID;

--Query 3:Customers, Orders, Order Details və Products cədvəllərini INNER JOIN edərək 
--müştərinin şirkət adını, sifariş nömrəsini,məhsulun adını və sifariş olunan miqdarı göstərək.
SELECT Customers.CompanyName, Orders.OrderID, Products.ProductName, [Order Details].Quantity
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID
INNER JOIN Products on [Order Details].ProductID = Products.ProductID;

--Query 4: Products, Categories və Suppliers cədvəllərini INNER JOIN edərək
--məhsulun adını, kateqoriyasını, təchizatçı şirkətin adını və məhsulun qiymətini göstərək.
SELECT Products.ProductName, Categories.CategoryName, Suppliers.CompanyName
FROM Products INNER JOIN Categories on Products.CategoryID = Categories.CategoryID
INNER JOIN Suppliers on Products.SupplierID = Suppliers.SupplierID;

--Query 5:Customers və Orders cədvəllərini LEFT JOIN edərək bütün müştərilərin şirkət adını, 
--əlaqə saxlanılan şəxsin adını,sifariş nömrəsini və sifariş tarixini göstərək.
SELECT Customers.CompanyName, Customers.ContactName, Orders.OrderID, Orders.OrderDate
FROM Customers LEFT JOIN Orders on Customers.CustomerID = Orders.CustomerID;

--Query 6: Employees və Orders cədvəllərini LEFT JOIN edərək bütün işçilərin adını və 
--soyadını, qəbul etdikləri sifarişlərin nömrəsini və tarixini göstərək.
SELECT Employees.FirstName, Employees.LastName, Orders.OrderID, Orders.OrderDate
FROM Employees LEFT JOIN Orders on Employees.EmployeeID = Orders.EmployeeID;

--Query 7: Customers, Orders və Employees cədvəllərini LEFT JOIN edərək
--bütün müştərilərin şirkət adını, sifariş nömrəsini və işçinin adını göstərək.
SELECT Customers.CompanyName, Orders.OrderID, Employees.FirstName
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
LEFT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID;

--Query 8:Employees cədvəlini özü ilə (SELF JOIN) birləşdirərək
--hər işçinin adını və onun menecerinin adını göstərək.
SELECT e1.FirstName as Employee, e2.FirstName as Manager
FROM Employees e1
INNER JOIN Employees e2 on e1.ReportsTo = e2.EmployeeID;