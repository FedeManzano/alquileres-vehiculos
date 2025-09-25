USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Factura' AND
            TABLE_SCHEMA    = 'negocio'
)   
BEGIN 

    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Factura] (
    --  NOMBRE              TOPO            RESTRICCIÓN
        CodFactura          CHAR(10)        PRIMARY KEY,
        FechaFactura        DATETIME        NOT NULL,
        MontoTotal          DECIMAL(10,2)   NOT NULL,

    
        ------------- ****** RESTRICCIONES CHECK ******* --------------------------------
        -- RESTRICCIONES CHECK El codigo de factura debe tener el formato 'F000000000' 
        -- y ser de longitud 10
        CONSTRAINT CK_CodFactura_Factura CHECK (
            LEN(CodFactura) = 10 AND 
            CodFactura LIKE 'F[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),

        -- RESTRICCIONES CHECK El monto total debe ser mayor o igual a 0
        CONSTRAINT CK_MontoTotal_Factura CHECK (
            MontoTotal >= 0
        ),

        -- RESTRICCIONES CHECK La fecha de la factura no puede ser futura   
        -- Usamos TRY_CONVERT para asegurarnos que la fecha es válida
        CONSTRAINT CK_FechaFactura_Factura CHECK (
            CASE 
                WHEN TRY_CONVERT(DATE, FechaFactura) IS NOT NULL 
                THEN 1 
                ELSE 0
            END = 1 AND
            FechaFactura <= GETDATE() -- La fecha no puede ser futura    
        )
    );
END

ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Factura] Ya existe en la BD: db_alquileres_vehiculos');

-- DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Factura]   