USE DeliveryP
GO

/*
	Объявление пользовательских типов данных
*/

CREATE TYPE CostValue
FROM decimal(10,2) NOT NULL
GO

CREATE TYPE Rating
FROM decimal (3,2) NOT NULL
GO

CREATE TYPE FIO
FROM nvarchar(50) NOT NULL
GO

DROP TABLE IF EXISTS Payment 
GO

/*
	Создание таблицы платежей
*/

CREATE TABLE Payment(
	paymentId INT NOT NULL IDENTITY(1,1) Primary Key,
	amount  CostValue CHECK (amount >= 0),
	discount CostValue CHECK (discount >= 0) DEFAULT 0,
	discountedAmount AS amount - discount,
	CONSTRAINT ck_discount_less_amount CHECK (discount <= amount)
)
GO

DROP TABLE IF EXISTS Customers 
GO

/*
	Создание таблицы клиентов
*/

CREATE TABLE Customers(
	customerId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	customerSecondId nchar(8) NOT NULL,
	customerLastName FIO,
	customerFirstName FIO,
	customerBirthDate DATE NOT NULL 
		CHECK (DATEDIFF(year, customerBirthDate, 
				CONVERT (date, SYSDATETIME())) >= 18) DEFAULT '01-01-2000',
	customerPhone char(16) 
		CHECK(customerPhone LIKE '8([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
)
GO

DROP TABLE IF EXISTS Parcels
GO

/*
	Создание таблицы посылок
*/

CREATE TABLE Parcels(
	parcelId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	parcelType nvarchar(20) NOT NULL DEFAULT 'не определено',
	parcelWeight SMALLINT NOT NULL CHECK (parcelWeight > 0 AND parcelWeight <= 10000),
	parcelSize char(8) NOT NULL CHECK (parcelSize LIKE '[0-9][0-9]x[0-9][0-9]x[0-9][0-9]'),
	parcelPrice CostValue CHECK (parcelPrice >= 0)
)
GO

DROP TABLE IF EXISTS Delivery
GO

/*
	Создание таблицы доставок
*/

CREATE TABLE Delivery(
	deliveryId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	deliveryMethod nvarchar(20) NOT NULL DEFAULT 'не определено',
	deliveryAddress nvarchar(50) NOT NULL,
	deliveryPrice CostValue CHECK(deliveryPrice >= 0)
)
GO

DROP TABLE IF EXISTS Employees
GO

/*
	Создание таблицы работников
*/

CREATE TABLE Employees(
	employeeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	employeeSecondId nchar(8) NOT NULL,
	employeeLastName FIO,
	employeeFirstName FIO,
	mail nvarchar(50) NOT NULL DEFAULT 'не определено',
	employeePhone char(16) NOT NULL 
	CHECK(employeePhone LIKE '8([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
	employeeBirthDate DATE NOT NULL 
	CHECK (DATEDIFF(year, employeeBirthDate, CONVERT (date, SYSDATETIME())) >= 18) DEFAULT '01-01-2000',
	rating Rating CHECK(rating <= 5) DEFAULT 5
)
GO

DROP TABLE IF EXISTS Orders
GO

/*
	Создание таблицы заказов
*/

CREATE TABLE Orders(
	orderId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	customerId INT FOREIGN KEY REFERENCES Customers
	ON DELETE SET NULL,
	employeeId INT FOREIGN KEY REFERENCES Employees
	ON DELETE SET NULL,
	paymentId INT UNIQUE FOREIGN KEY REFERENCES Payment,
	parcelId INT FOREIGN KEY REFERENCES Parcels
	ON DELETE SET NULL,
	deliveryId INT FOREIGN KEY REFERENCES Delivery
	ON DELETE SET NULL,
	orderDate DATE CHECK(orderDate <= CONVERT (date, SYSDATETIME())) DEFAULT  CONVERT (date, SYSDATETIME()),
	orderStatus nvarchar(30) NOT NULL DEFAULT 'не определено',
	orderReceipt nvarchar(3) NOT NULL DEFAULT 'нет'
)
GO

DROP INDEX IF EXISTS ncix_customer_secondId ON Customers
GO
DROP INDEX IF EXISTS ncix_employee_secondId ON Employees
GO
DROP INDEX IF EXISTS ncix_order_date ON Orders
GO
DROP INDEX IF EXISTS ncix_delivery_address ON Delivery
GO
DROP INDEX IF EXISTS ncix_customer_fi ON Customers
GO

/*
	Создание индексов
*/

CREATE NONCLUSTERED INDEX ncix_customer_secondId
ON Customers(customerSecondId)
GO

CREATE NONCLUSTERED INDEX ncix_employee_secondId
ON Employees(employeeSecondId)
GO

CREATE NONCLUSTERED INDEX ncix_order_date
ON Orders(orderDate)
GO

CREATE NONCLUSTERED INDEX ncix_order_payment
ON Orders(paymentId)
GO

CREATE NONCLUSTERED INDEX ncix_delivery_address
ON Delivery(deliveryAddress)
GO

CREATE NONCLUSTERED INDEX ncix_customer_fi
ON Customers(customerFirstName, customerLastName)
GO