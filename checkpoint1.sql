-- DevJoint Internship
-- Checkpoint 1
-- Topic:SELECT/WHERE/ ORDER BY/LIMIT
-- Database: Northwind


-- Query 2:Customers cədvəlindən CompanyName, ContactName və Phone sütunlarını göstərək.
SELECT CompanyName, ContactName, Phone FROM Customers;

-- Query 3: Products cədvəlindən UnitPrice dəyəri 30 ilə 49 arasında olan məhsulların
-- ProductName və QuantityPerUnit sütunlarını göstərək.
SELECT ProductName, QuantityPerUnit FROM Products WHERE UnitPrice>=30 and UnitPrice<=49;
-- Bunu həmçinin BETWEEN vasitəsilə də göstərə bilərik. O zaman belə olacaq:
SELECT ProductName, QuantityPerUnit FROM Products WHERE UnitPrice BETWEEN 30 and 49;

-- Query 4:Employees cədvəlindən FirstName, LastName, TitleOfCourtesy və Extension
-- sütunlarını Extension dəyərinə görə azalan sıra ilə(DESC) göstərək.
SELECT FirstName, LastName, TitleOfCourtesy, Extension FROM Employees ORDER BY Extension DESC;
--Bizə verilən Northwind bazasında Extension sütunu Text tipində olduğundan cavab fərqli
--çıxırdı. Buna görə də onu İNTEGER tipinə çevirdik.
SELECT FirstName, LastName, TitleOfCourtesy, Extension FROM Employees 
ORDER BY CAST(Extension AS INTEGER) DESC;

-- Query 5:Orders cədvəlindən 1997-01-01 tarixindən sonra verilmiş sifarişlərin
-- OrderID, CustomerID və OrderDate sütunlarını tarixə görə artan sıra ilə(ASC)
-- ilk 20 nəticəni göstərək.
SELECT OrderID, CustomerID, OrderDate FROM Orders WHERE OrderDate > '1997-01-01'
ORDER BY OrderDate ASC LIMIT 20;

