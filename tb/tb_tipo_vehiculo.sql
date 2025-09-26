
USE db_alquileres_vehiculos
/**
    Script para crear la tabla Tipo_Vehiculo en la base de datos.
    La tabla almacena los tipos de vehículos disponibles para alquiler.
    Autor: Federico M. (2024)   
*/
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'Tipo_Vehiculo'
      AND TABLE_SCHEMA = 'negocio'
)
BEGIN
    -- Crear la tabla Tipo_Vehiculo con sus campos y restricciones
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] (
    --  CAMPO             TIPO_DATO     RESTRICCIÓN
        ID_Tipo_Vehiculo  SMALLINT      PRIMARY KEY,
        Nombre            VARCHAR(15)   NOT NULL,
        Precio            DECIMAL(10,2) NOT NULL
        -- Restricción CHECK
        CONSTRAINT CK_Nombre_Vehiculo CHECK (
            Nombre = 'AUTOMOVIL' OR
            Nombre = 'CAMIONETA'
        )
    );
END
ELSE
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo]
*/