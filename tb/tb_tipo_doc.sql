
USE db_alquileres_vehiculos
/**
    Script para crear la tabla Tipo_Doc en la base de datos.
    La tabla almacena información sobre los tipos de documentos de los clientes.
    Autor: Federico M. (2024)
*/
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME    = 'Tipo_Doc'   AND
          TABLE_SCHEMA  = 'negocio'
)
BEGIN 
    -- CREACIÓN DE LA TABLA TIPO_DOC
    PRINT('Creando la tabla [db_alquileres_vehiculos].[negocio].[Tipo_Doc] en la BD: db_alquileres_vehiculos')
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Tipo_Doc] 
    (
    --  NOMBRE        TIPO        RESTRCCIÓN 
        TipoDoc       TINYINT     PRIMARY KEY NONCLUSTERED,
        Descripcion   VARCHAR(3)  NOT NULL,

        -- RESTRICCIÓN CK Pra la descripción del 
        -- TipoDoc
        CONSTRAINT CK_Desc_Tipo_Doc CHECK 
        (
            Descripcion     =    'DNI'  OR
            Descripcion     =    'LC'   OR
            Descripcion     =    'PAS'              
        )
    )                  
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Tipo_Doc] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Doc] */