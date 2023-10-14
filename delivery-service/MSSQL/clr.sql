USE master
GO

DROP ASSEMBLY IF EXISTS CLRFunctions
GO

sp_configure 'show advanced options', 1
GO
RECONFIGURE 
GO

sp_configure 'clr strict security', 0
GO
RECONFIGURE 
GO

sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

CREATE ASSEMBLY CLRFunctions FROM 'your_path'
GO

DROP FUNCTION IF EXISTS fk_get_identifier
GO

-- Внешняя функция генерации случайного пароля из 8 символов 

CREATE FUNCTION fk_get_identifier()
RETURNS nvarchar(8)
WITH EXECUTE AS CALLER
AS
	EXTERNAL NAME CLRFunctions.UserDefinedFunctions.fc_get_identifier
GO

DROP FUNCTION IF EXISTS fc_output
GO

-- Внешняя функция логирования

CREATE FUNCTION fc_output(
	@input nvarchar(2000)
)
RETURNS nvarchar(50)
WITH EXECUTE AS CALLER
AS
	EXTERNAL NAME CLRFunctions.UserDefinedFunctions.fc_output
GO