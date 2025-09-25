USE alquileres_vehiculos;


/**
    Script para crear la tabla Adicional en la base de datos.
    La tabla almacena información sobre los cargos adicionales asociados a las facturas.
    Autor: Federico M. (2024)
*/
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Adicional'  AND
            TABLE_SCHEMA  = 'negocio'   
)
BEGIN 
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Adicional] (
    --  CAMPO           TIPO            RESTRICCIÓN
        ID_Adicional    SMALLINT        IDENTITY(1,1) PRIMARY KEY,
        CodFacutura     CHAR(10)        NOT NULL,
        Monto           DECIMAL(10,2)   NOT NULL,
        Descripcion     VARCHAR(100)    NOT NULL,

        -- Restricciones Foraneas
        CONSTRAINT FK_Adicional_Factura FOREIGN KEY (CodFacutura) REFERENCES
            [db_alquileres_vehiculos].[negocio].
            [Factura] (CodFactura),

        -- Restricciones Check
        CONSTRAINT CK_Adicional_Monto CHECK (Monto >= 0)
    )
END
ELSE
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Adicional] Ya existe en la BD: db_alquileres_vehiculos')


