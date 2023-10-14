--Табличная функция - принимает дату, возвращает таблицу : полная информация о заказе с искомой датой

DROP FUNCTION IF EXISTS func_GetOrderOnDate
GO

CREATE FUNCTION func_GetOrderOnDate (
    @orderDate DATE
)
RETURNS TABLE
AS
RETURN
    SELECT 
		O.orderId AS trackNumber,
		C.customerLAStName + ' ' + C.customerFirstName AS Customer,
		E.employeeLAStName + ' ' + E.employeeFirstName AS Employee,
		Pars.parcelType + ' size:' + Pars.parcelSize + ' weight:' + CONVERT(nvarchar, Pars.parcelWeight) AS Parsel,
		Pay.discountedAmount AS Payment,
		D.deliveryMethod + ' ' + D.deliveryAddress AS Delivery,
		O.orderStatus AS Status
    FROM
		Orders AS O
		INNER JOIN Customers AS C    ON O.customerId = C.customerId
		INNER JOIN Employees AS E    ON O.employeeId = E.employeeId
		INNER JOIN Payment   AS Pay  ON O.paymentId = Pay.paymentId
		INNER JOIN Parcels   AS Pars ON O.parcelId = Pars.parcelId
		INNER JOIN Delivery  AS D    ON O.deliveryId = D.deliveryId
    WHERE
		O.orderDate = @orderDate
GO