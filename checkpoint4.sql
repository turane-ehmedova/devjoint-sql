-- DevJoint Internship
-- Checkpoint 4
-- Topic:Çox addımlı məntiq üçün subquery və CTE(WITH) 
-- Database: Northwind

--Query 1:Products cədvəlindən məhsulun adını və qiymətini göstərək.
--Orta qiymətdən yüksək qiymətə malik məhsulları SUBQUERY istifadə edərək seçək.
SELECT ProductName, UnitPrice
FROM Products WHERE UnitPrice>
(SELECT avg(UnitPrice)
FROM Products);

--Query 2:Customers cədvəlindən şirkət adını göstərək.
--Orders cədvəlində ən azı bir sifarişi olan müştəriləri
-- SUBQUERY və IN operatorundan istifadə edərək seçək.
SELECT CompanyName
FROM Customers WHERE CustomerID in 
(SELECT CustomerID 
FROM Orders);

--Query 3:Products cədvəlindən məhsulun adını və qiymətini göstərək.
--SUBQUERY istifadə edərək ən yüksək qiymətə malik məhsulu seçək.
SELECT ProductName, UnitPrice
FROM Products WHERE UnitPrice =
(SELECT max(UnitPrice)
FROM Products);

--Query 4:Products cədvəlindən məhsulun adını və qiymətini göstərək.
--SUBQUERY istifadə edərək ən aşağı qiymətə malik məhsulu seçək.
SELECT ProductName, UnitPrice
FROM Products WHERE UnitPrice =
(SELECT min(UnitPrice)
FROM Products);

--Query 5:WITH (CTE) istifadə edərək CustomerOrders adlı müvəqqəti cədvəl yaradıb,
--Customers və Orders cədvəllərini INNER JOIN edərək
--hər müştərinin şirkət adını və sifariş sayını hesablayaq.
--Daha sonra müvəqqəti cədvəldən şirkət adını və sifariş sayını göstərək.
WITH CustomerOrders as
(SELECT CompanyName, count(OrderID) as totalorders
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
GROUP by CompanyName)
SELECT CompanyName, totalorders FROM CustomerOrders;

--Query 6:WITH (CTE) istifadə edərək ProductPrice adlı müvəqqəti cədvəl yaradaq.
--Products cədvəlindən məhsulun adını və qiymətini seçək.
--Daha sonra müvəqqəti cədvəldən qiyməti 50-dən böyük olan məhsulları göstərək.
WITH ProductPrice as
(SELECT ProductName, UnitPrice FROM Products)
SELECT ProductName, UnitPrice FROM ProductPrice
WHERE UnitPrice>50;

--Query 7:WITH (CTE) istifadə edərək CustomerOrders adlı müvəqqəti cədvəl yaradaq.
--Customers və Orders cədvəllərini INNER JOIN edərək
--hər müştərinin şirkət adını və sifariş sayını hesablayaq.
--Daha sonra müvəqqəti cədvəldən yalnız 10-dan çox sifarişi olan
--müştəriləri göstərək.
WITH CustomerOrders as
(SELECT CompanyName, count(OrderID) as totalorders
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
GROUP by CompanyName)
SELECT CompanyName, totalorders FROM CustomerOrders
WHERE totalorders>10;

--Query 8:WITH (CTE) istifadə edərək ProductsPrice adlı müvəqqəti cədvəl yaradaq.
--Products cədvəlində hər kateqoriya üzrə məhsulların orta qiymətini hesablayaq.
--Daha sonra müvəqqəti cədvəldən orta qiyməti 30-dan böyük olan
--kateqoriyaları göstərək.
WITH ProductsPrice as
(SELECT CategoryID, avg(UnitPrice) as avgprice 
FROM Products 
GROUP by CategoryID)
SELECT CategoryID, avgprice FROM ProductsPrice
WHERE avgprice>30;

--Query 9:WITH (CTE) istifadə edərək OrdersQuantity adlı müvəqqəti cədvəl yaradaq.
--Orders və Order Details cədvəllərini INNER JOIN edərək
--hər il və ay üzrə satılan məhsulların ümumi miqdarını hesablayaq.
--Daha sonra müvəqqəti cədvəldən ili, ayı və ümumi satılan məhsul miqdarını göstərək.
--strftime() funksiyası SQLite-də tarixdən il (%Y) və ayı (%m) çıxarmaq üçün istifadə olunur.
WITH OrdersQuantity as
(SELECT 
strftime('%Y', Orders.OrderDate) as Year,
strftime('%m', Orders.OrderDate) as Month,
sum([Order Details].Quantity) as totalQuantity
FROM Orders INNER JOIN [Order Details] on Orders.OrderID=[Order Details].OrderID
GROUP by 
strftime('%Y', Orders.OrderDate),
strftime('%m', Orders.OrderDate))
SELECT Year, Month, totalQuantity FROM OrdersQuantity;

--Query 10:WITH (CTE) istifadə edərək CustomersRevenue adlı müvəqqəti cədvəl yaradaq.
--Customers, Orders və Order Details cədvəllərini INNER JOIN edərək
--hər müştərinin ümumi gəlirini hesablayaq.
--Gəliri UnitPrice × Quantity × (1 - Discount) düsturu ilə hesablayıb
--nəticəni TotalRevenue adı ilə saxlayıb gəlirə görə azalan sırada düzək
--və ilk 5 müştərini göstərək.
WITH CustomersRevenue as
(SELECT CompanyName, 
sum(UnitPrice * Quantity * (1 - Discount)) as totalRevenue
FROM Customers INNER JOIN Orders on Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] on Orders.OrderID = [Order Details].OrderID
GROUP by CompanyName)
SELECT CompanyName, totalRevenue FROM CustomersRevenue
ORDER by totalRevenue DESC
LIMIT 5;