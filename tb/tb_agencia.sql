USE db_alquileres_vehiculos
/**
    Script para crear la tabla Agencia en la base de datos.
    La tabla almacena información sobre las agencias de alquiler de vehículos.
    Autor: Federico M. (2024)
*/
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME    = 'Agencia'  AND
            TABLE_SCHEMA  = 'negocio'  
)
BEGIN
    -- Crear la tabla Agencia con sus campos y restricciones
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Agencia] (
        
    --  NOMBRECAMPO     TIPO            RESTRICCIÓN
        CuitAgencia     VARCHAR(14)     PRIMARY KEY, -- Formato: XX-XXXXXXXX-X
        Correo          VARCHAR(100)    UNIQUE, -- Puede ser NULL
        Nombre          VARCHAR(30)     NOT NULL, -- Nombre de la agencia
        Telefono        VARCHAR(20),    -- Puede ser NULL
        Direccion       VARCHAR(100)    NOT NULL -- Dirección física de la agencia
    );

    INSERT INTO [db_alquileres_vehiculos].[negocio].[Agencia] (
        CuitAgencia,
        Correo,
        Nombre,
        Telefono,
        Direccion
    ) VALUES (
        '30123456789',
        'info@agenciaejemplo.com',
        'Agencia Ejemplo',
        '01112345678',
        'Av. Siempre Viva 123'
    ),
    (
        '20876543210',
        'info@agenciaejemplo2.com',
        'Agencia Ejemplo 2',
        '01187654321',
        'Av. Siempre Viva 456'
    ),
    (
        '23556677881',
        'info@agenciaejemplo3.com', 
        'Agencia Ejemplo 3',
        '011-3344-5566',
        'Av. Siempre Viva 789'
    )
END
ELSE
    -- Si la tabla ya existe, mostrar un mensaje informativo
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Agencia] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP IF EXISTS TABLE [db_alquileres_vehiculos].[negocio].[Agencia]
*/