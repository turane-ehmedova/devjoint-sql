-- DevJoint Internship
-- Checkpoint 5
-- Topic:Window funksiyaları (RANK, ROW_NUMBER, SUM() OVER ilə running total) 
-- Database: Northwind

--Query 1:Products cədvəlindən məhsulun adını və qiymətini göstərək.
--ROW_NUMBER() Window Function istifadə edərək məhsulları
--qiymətə görə artan sıraya düzüb hər məhsula sıra nömrəsi verək.
SELECT ProductName, UnitPrice, 
row_number() OVER(ORDER by UnitPrice) as rownum
FROM Products
ORDER by UnitPrice;

--Query 2:Products cədvəlindən məhsulun adını və qiymətini göstərək.
--RANK() Window Function istifadə edərək məhsulları
--qiymətə görə azalan sıraya düzüb hər məhsula sıra nömrəsi verək.
--Eyni qiymətə malik məhsullar olarsa, onlara eyni rank veriləcək.
SELECT ProductName, UnitPrice,
rank() OVER(ORDER by UnitPrice DESC) as ProductRank
FROM Products
ORDER by UnitPrice DESC;

--Query 3:Products cədvəlindən məhsulun adını, kateqoriya nömrəsini və qiymətini göstərək.
--ROW_NUMBER() Window Function və PARTITION BY istifadə edərək
--hər kateqoriya daxilində məhsulları qiymətə görə azalan sıraya düzək
--və hər məhsula sıra nömrəsi verək.
SELECT ProductName, CategoryID, UnitPrice,
row_number() OVER(PARTITION by CategoryID ORDER by UnitPrice DESC) as rownum
FROM Products
ORDER by CategoryID, UnitPrice DESC;

--Query 4:Orders cədvəlindən sifariş nömrəsini, tarixini və daşınma xərcini göstərək.
--SUM() OVER() Window Function istifadə edərək sifarişləri tarixə görə sıralayaq
--və daşınma xərclərinin yığılan cəmini (running total) hesablayaq.
SELECT OrderID, OrderDate, Freight,
sum(Freight) OVER(ORDER by OrderDate) as freightsum
FROM Orders
ORDER by OrderDate;

--Query 5:Orders cədvəlindən sifariş nömrəsini və daşınma xərcini göstərək.
--RANK() Window Function istifadə edərək sifarişləri
--daşınma xərcinə görə azalan sıraya düzək və hər sifarişə sıra nömrəsi verək.
--Eyni daşınma xərcinə malik sifarişlər olarsa, onlara eyni rank veriləcək.
SELECT OrderID, Freight,
rank() over(ORDER by Freight DESC) as FreightRank
FROM Orders
ORDER by Freight DESC;

--Query 6:Employees cədvəlindən işçinin adını və soyadını göstərək.
--ROW_NUMBER() Window Function istifadə edərək işçiləri
--soyadına görə əlifba sırası ilə düzək və hər işçiyə sıra nömrəsi verək.
SELECT FirstName, LastName,
row_number() OVER(ORDER by LastName) as rownum
FROM Employees
ORDER by LastName;

--Query 7:Orders cədvəlindən müştəri nömrəsini, sifariş nömrəsini və sifariş tarixini göstərək.
--ROW_NUMBER() Window Function və PARTITION BY istifadə edərək
--hər müştərinin sifarişlərini tarixə görə sıralayaq
--və hər müştərinin sifarişlərinə ayrıca sıra nömrəsi verək.
SELECT CustomerID, OrderID, OrderDate,
row_number() OVER(PARTITION by CustomerID ORDER by OrderDate) as rownum
FROM Orders
ORDER by CustomerID, OrderDate;

--Query 8: Products cədvəlindən kateqoriya nömrəsini, məhsulun adını və qiymətini göstərək.
--RANK() Window Function və PARTITION BY istifadə edərək
--hər kateqoriya daxilində məhsulları qiymətə görə azalan sıraya düzək
--və hər məhsula rank verək.
--Eyni qiymətə malik məhsullar olarsa, onlara eyni rank veriləcək.
SELECT CategoryID, ProductName, UnitPrice,
rank() over(PARTITION by CategoryID ORDER by UnitPrice DESC) as CategoryRank
FROM Products
ORDER by CategoryID, UnitPrice DESC;

--Query 9:Order Details cədvəlindən sifariş nömrəsini və məhsul miqdarını göstərək.
--SUM() OVER() Window Function istifadə edərək sifarişləri
--OrderID-yə görə sıralayaq və məhsul miqdarının yığılan cəmini (Running Total) hesablayaq.
SELECT OrderID, Quantity,
sum(Quantity) OVER(ORDER by OrderID) as Runningtotal
FROM [Order Details]
ORDER by OrderID;

--Query 10:Orders cədvəlindən işçi nömrəsini, sifariş nömrəsini və daşınma xərclərini (Freight) göstərək.
--SUM() OVER() Window Function və PARTITION BY istifadə edərək hər işçi üçün
--OrderDate-ə görə sıralanmış Freight dəyərlərinin yığılan cəmini (Running Total) hesablayaq.
SELECT EmployeeID, OrderID, OrderDate, Freight, 
sum(Freight) OVER( PARTITION by EmployeeID ORDER by OrderDate) as runningtotalfreight
FROM Orders
ORDER by EmployeeID, OrderDate;