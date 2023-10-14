/*
	Создание базы данных в комплекте основного файла, лог файла и файловой группы с 2 дополнительными файлами
*/

CREATE DATABASE DeliveryP
ON PRIMARY
  ( NAME='DeliveryP_Primary',
    FILENAME=
       'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DeliveryP_Prm.mdf',
    SIZE=5MB,
    MAXSIZE=20MB,
    FILEGROWTH=10%),
FILEGROUP DeliveryP_FG1
  ( NAME = 'DeliveryP_FG1_Dat1',
    FILENAME =
       'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DeliveryP_FG1_1.ndf',
    SIZE = 1MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB),
  ( NAME = 'DeliveryP_FG1_Dat2',
    FILENAME =
       'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DeliveryP_FG1_2.ndf',
    SIZE = 1MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB)
LOG ON
  ( NAME='DeliveryP_log',
    FILENAME =
       'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DeliveryP.ldf',
    SIZE= 2MB,
    MAXSIZE= 10MB,
    FILEGROWTH= 2MB);
GO