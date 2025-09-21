USE db_alquileres_vehiculos

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

        CONSTRAINT PK_Cliente 
            PRIMARY KEY(TipoDoc, NroDoc),

        CONSTRAINT FK_Tipo_Doc FOREIGN KEY(TipoDoc) REFERENCES  
            [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Doc] (TipoDoc),

        CONSTRAINT CK_Cliente_NroDoc CHECK
        (
            LEN(NroDoc) = 8 AND
            NroDoc LIKE '[1-7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),

        CONSTRAINT CK_Cliente_Fecha_Nac CHECK
        (
            CASE  
                WHEN TRY_CONVERT(DATE, FNac) IS NOT NULL THEN 1
                ELSE 0
            END = 1
        ),
    );
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Cliente] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Cliente] */