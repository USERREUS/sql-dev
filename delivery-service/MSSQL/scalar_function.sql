--Скалярная функция восстановления идентификатора клиента по хешу

DROP FUNCTION IF EXISTS fk_get_customer_for_id
GO

CREATE FUNCTION fk_get_customer_for_id(
	@secondId nchar(8)
)
RETURNS INT
AS 
	BEGIN
		DECLARE @result INT
		SELECT @result = Customers.customerId FROM Customers WHERE Customers.customerSecondId = @secondId
		IF @result IS NULL 
			RETURN 0;
		RETURN @result
	END 
GO