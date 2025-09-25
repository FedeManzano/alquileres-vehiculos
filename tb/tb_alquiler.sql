USE db_alquileres_vehiculos

/**
    Script para crear la tabla Alquiler en la base de datos.
    La tabla almacena información sobre los alquileres de vehículos realizados por los clientes.
    Autor: Federico M. (2024)
*/

IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Alquiler'  AND
            TABLE_SCHEMA  = 'negocio'   
)
BEGIN 
    -- Crear la tabla Alquiler con sus campos y restricciones
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Alquiler] 
    (
    --  CAMPO           TIPO            RESTRCCIÓN
        C_Alquiler      CHAR(10)        NOT NULL,   -- Formato: AQL-0000001
        TipoDoc         TINYINT         NOT NULL,   -- Referencia a Tipo_Doc
        NroDoc          VARCHAR(8)      NOT NULL,   -- Número de documento del cliente
        ID_T_Vehiculo   SMALLINT        NOT NULL,   -- Referencia a Tipo_Vehiculo
        Estado          TINYINT         NOT NULL,   -- 0: Activo, 1: Finalizado, 2: Cancelado
        FAlq            DATE            NOT NULL,   -- Fecha de alquiler
        CodFactura      CHAR(10),                   -- Referencia a Factura

        -- RESTRCCIÓN PRIMARY KEY
        -- Clave primaria compuesta
        CONSTRAINT PK_Alquiler PRIMARY KEY 
        (
            C_Alquiler,
            TipoDoc,
            NroDoc,
            ID_T_Vehiculo
        ),
        

        -- Restricción check FK (TipoDoc, NroDoc) De Cliente
        CONSTRAINT  FK_Alquiler_Doc 
        FOREIGN KEY (TipoDoc, NroDoc) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Cliente] 
                    (TipoDoc, NroDoc),

        -- Restricción check FK ID_T_Vehiculo De Tipo_Vehiculo  
        CONSTRAINT FK_Alquiler_Tipo_Vehiculo FOREIGN KEY (ID_T_Vehiculo) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Tipo_Vehiculo] 
                    (ID_Tipo_Vehiculo),

        -- Restricción check FK CodFactura De Factura
        CONSTRAINT FK_Alquiler_Factura FOREIGN KEY (CodFactura) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Factura] 
                    (CodFactura),
        
        -- ESTADO_AQL 1 / 2 / 3 Valores posibles
        CONSTRAINT CK_Estado_Alquiler CHECK
        (
            Estado = 0 OR -- Reservado
            Estado = 1 OR -- Pagado
            Estado = 2 OR -- Retirados
            Estado = 4 OR -- Cancelado
            Estado = 5 OR -- Devuelto
            Estado = 6    -- Retrasado
        ),

        -- FECHAAQL CK Validación de fecha
        CONSTRAINT CK_FechaAlq_Alquiler CHECK 
        (
             CASE  
                WHEN TRY_CONVERT(DATE, FAlq) IS NOT NULL THEN 1
                ELSE 0
            END = 1
        ),
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Alquiler] Ya existe en la BD: db_alquileres_vehiculos')

/* DROP TABLE  [db_alquileres_vehiculos].[negocio].[Alquiler] */
-- Índices para optimizar consultas frecuentes
-- CREATE INDEX IX_Fecha_Alquiler ON [db_alquileres_vehiculos].[negocio].[Alquiler](FAlq)

--  Índice para consultas por estado
-- CREATE INDEX IX_Estado_Alquiler ON [db_alquileres_vehiculos].[negocio].[Alquiler](Estado)