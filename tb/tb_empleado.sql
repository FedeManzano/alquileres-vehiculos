USE db_alquileres_vehiculos

/**
    Script para crear la tabla Empleado en la base de datos.
    La tabla almacena información sobre los empleados de las agencias.
    Autor: Federico M. (2024)
*/  
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Empleado'  AND
            TABLE_SCHEMA  = 'negocio'   
) -- FIN CONDICIÓN
BEGIN -- COMIENZO DEL CUERPO IF 
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Empleado] (
                    
    --  Nombre          Tipo            Restricción
        Legajo          INT             IDENTITY(1,1) PRIMARY KEY,
        Nombre          VARCHAR(30)     NOT NULL,
        Apellido        VARCHAR(30)     NOT NULL,  
        Email           VARCHAR(100)    UNIQUE,
        CuitAgencia     VARCHAR(11)     NOT NULL,

        CONSTRAINT FK_Cuit_Agencia FOREIGN KEY (CuitAgencia) REFERENCES 
            [db_alquileres_vehiculos].
            [negocio].
            [Agencia] (CuitAgencia),
        
        CONSTRAINT CK_Empleado_Email CHECK
        (
            Email IS NULL OR
            Email LIKE '%_@__%.__%'
        ),

        CONSTRAINT CK_Empleado_Nombre CHECK
        (
            LEN(Nombre) > 0 AND LEN(Nombre) <= 30
            AND Nombre NOT LIKE '%[^a-zA-Z ]%'
        ),

        CONSTRAINT CK_Empleado_Apellido CHECK
        (
            LEN(Apellido) > 0 AND LEN(Apellido) <= 30
            AND Apellido NOT LIKE '%[^a-zA-Z ]%'
        ),
    )
END 
ELSE
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Empleado] NO existe en la BD: db_alquileres_vehiculos')
/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Empleado] 
*/