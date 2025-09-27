USE db_alquileres_vehiculos


/**
    Script para crear la tabla Cliente en la base de datos.
    La tabla almacena información sobre los clientes que alquilan vehículos.
    Autor: Federico M. (2024)
*/

IF NOT EXISTS 
(
    SELECT 1 -- Columnas

    FROM    INFORMATION_SCHEMA.TABLES -- Nombre Tabla
    
    -- Condiciones / Filtros
    WHERE   TABLE_SCHEMA = 'negocio' AND 
            TABLE_NAME   = 'Cliente' 
) -- FIN CONDICIÓN

BEGIN -- COMIENZO DEL CUERPO IF
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Cliente] 
    (
    --  Nombre      Tipo         Restricción
        TipoDoc     TINYINT      NOT NULL,
        NroDoc      VARCHAR(8)   NOT NULL,
        Nombre      VARCHAR(30)  NOT NULL,
        Apellido    VARCHAR(30)  NOT NULL,
        Direccion   VARCHAR(100) NOT NULL,
        Email       VARCHAR(100) UNIQUE,
        FNac        DATE         NOT NULL,
        Telefono    CHAR(14),
        MedioPago   TINYINT      NOT NULL,
        Estado      TINYINT      NOT NULL, -- 1: Activo, 2: Deuda Vencida, 3: Inactivo

        ----------------- ******* RESTRICCIONES ******* -----------------
        CONSTRAINT PK_Cliente 
            PRIMARY KEY NONCLUSTERED (TipoDoc, NroDoc),

        ----------------- ******* RESTRICCIONES ******* -----------------
        CONSTRAINT FK_Tipo_Doc FOREIGN KEY(TipoDoc) REFERENCES  
            [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Doc] (TipoDoc),
        CONSTRAINT FK_Medio_Pago FOREIGN KEY(MedioPago) REFERENCES  
            [db_alquileres_vehiculos].[negocio].[Medio_Pago] (ID_Medio_Pago),
            
        CONSTRAINT CK_Cliente_NroDoc CHECK
        (
            LEN(NroDoc) = 8 AND
            NroDoc LIKE '[1-7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),

        CONSTRAINT CK_Cliente_Fecha_Nac CHECK
        (
            CASE  
                WHEN TRY_CONVERT(DATE, FNac) IS NOT NULL 
                AND FNac < GETDATE() THEN 1
                ELSE 0
            END = 1
        ),

        CONSTRAINT CK_Cliente_Estado CHECK
        (
            Estado = 1 OR -- Activo
            Estado = 2 OR -- Deuda Vencida
            Estado = 3    -- Inactivo
        )
    )

    IF NOT EXISTS 
    (
        SELECT 1
        FROM sys.indexes 
        WHERE name = 'IX_Estado_Cliente'
    )
        CREATE INDEX IX_Estado_Cliente 
        ON [db_alquileres_vehiculos].[negocio].[Cliente](Estado)


    IF NOT EXISTS 
    (
        SELECT 1
        FROM sys.indexes 
        WHERE name = 'IX_MPago_Cliente'
    )
        CREATE INDEX IX_MPago_Cliente 
        ON [db_alquileres_vehiculos].[negocio].[Cliente](MedioPago)
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Cliente] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Cliente] */