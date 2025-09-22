USE master 

IF NOT EXISTS 
(
    SELECT 1 
    FROM sys.databases 
    WHERE name = 'db_alquileres_vehiculos' 
) 
BEGIN 
    CREATE DATABASE db_alquileres_vehiculos
    COLLATE sql_latin1_general_cp1_ci_as
END

USE db_alquileres_vehiculos

-- ALTER DATABASE db_alquileres_vehiculos ADD FILEGROUP G_MEM CONTAINS MEMORY_OPTIMIZED_DATA;

IF NOT EXISTS 
(
    SELECT 1
    FROM sys.schemas 
    WHERE name = 'negocio'
)
BEGIN 
    EXEC('CREATE SCHEMA negocio')
END 

IF NOT EXISTS 
(
    SELECT 1
    FROM sys.schemas 
    WHERE name = 'test'
)
BEGIN 
    EXEC('CREATE SCHEMA test')
END 
