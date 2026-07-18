-- DevJoint Internship
-- Checkpoint 3
-- Topic:GROUP BY/HAVING ilə aqreqasiya
-- Database: Northwind

-- Query 1:
SELECT Employees.LastName, Employees.FirstName,
count(Orders.OrderID) as totalorders
FROM Employees INNER JOIN Orders on Employees.EmployeeID = Orders.EmployeeID
GROUP by Employees.LastName, Employees.FirstName; 