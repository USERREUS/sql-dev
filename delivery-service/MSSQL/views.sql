/*
	Представление данных для клиента
*/

DROP VIEW IF EXISTS view_customer_order
GO 

CREATE VIEW view_customer_order AS
SELECT
	O.orderId,
	C.customerId,
	C.customerLAStName + ' ' + C.customerFirstName AS customer_FI,
	E.employeeLAStName + ' ' + E.employeeFirstName AS employee_FI,
	'платеж: ' + CONVERT(nvarchar,Pa.amount) + ' скидка: ' + CONVERT(nvarchar,Pa.discount) + ' результирующий платеж: ' + CONVERT(nvarchar,Pa.discountedAmount) AS payment,
	'тип посылки: ' + Pr.parcelType + ' размер: ' + Pr.parcelSize + ' вес: ' + CONVERT(nvarchar,Pr.parcelWeight) AS parcel,
	'тип доставки: ' + D.deliveryMethod + ' в ' + D.deliveryAddress AS delivery,
	O.orderStatus AS status,
	O.orderReceipt AS receipt
FROM Orders AS O
INNER JOIN Customers AS C  ON O.customerId = C.customerId
INNER JOIN Employees AS E  ON O.employeeId = E.employeeId
INNER JOIN Payment   AS Pa ON O.paymentId = Pa.paymentId
INNER JOIN Parcels   AS Pr ON O.parcelId = Pr.parcelId
INNER JOIN Delivery  AS D  ON O.deliveryId = D.deliveryId
GO

/*
	Представление данных для сотрудника
*/

DROP VIEW IF EXISTS view_employee_order
GO 

CREATE VIEW view_employee_order AS
SELECT
	O.orderId,
	E.employeeId,
	C.customerLAStName + ' ' + C.customerFirstName AS customer_FI,
	E.employeeLAStName + ' ' + E.employeeFirstName AS employee_FI,
	'платеж: ' + CONVERT(nvarchar,Pa.amount) + ' скидка: ' + CONVERT(nvarchar,Pa.discount) + ' результирующий платеж: ' + CONVERT(nvarchar,Pa.discountedAmount) AS payment,
	'тип посылки: ' + Pr.parcelType + ' размер: ' + Pr.parcelSize + ' вес: ' + CONVERT(nvarchar,Pr.parcelWeight) AS parcel,
	'тип доставки: ' + D.deliveryMethod + ' в ' + D.deliveryAddress AS delivery,
	O.orderStatus AS status,
	O.orderReceipt AS receipt
FROM Orders AS O
INNER JOIN Customers AS C  ON O.customerId = C.customerId
INNER JOIN Employees AS E  ON O.employeeId = E.employeeId
INNER JOIN Payment   AS Pa ON O.paymentId = Pa.paymentId
INNER JOIN Parcels   AS Pr ON O.parcelId = Pr.parcelId
INNER JOIN Delivery  AS D  ON O.deliveryId = D.deliveryId
GO

/*
	Представление данных для администратора
*/

DROP VIEW IF EXISTS view_admin_info
GO 

CREATE VIEW view_admin_info AS
SELECT 
	orderId, 
	orderDate, 
    orderStatus,
	orderReceipt, 
	O.customerId, 
	C.customerSecondId, 
	O.deliveryId, 
	O.employeeId, 
	E.employeeSecondId, 
	E.rating, 
	O.parcelId, 
	O.paymentId, 
	Pa.discountedAmount 
FROM Orders AS O
INNER JOIN Customers AS C  ON O.customerId = C.customerId
INNER JOIN Employees AS E  ON O.employeeId = E.employeeId
INNER JOIN Payment   AS Pa ON O.paymentId = Pa.paymentId
INNER JOIN Parcels   AS Pr ON O.parcelId = Pr.parcelId
INNER JOIN Delivery  AS D  ON O.deliveryId = D.deliveryId
GO
