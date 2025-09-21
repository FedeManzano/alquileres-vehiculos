USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Alquiler'  AND
            TABLE_SCHEMA  = 'negocio'   
)
BEGIN 

    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Alquiler] 
    (
    --  CAMPO           TIPO            RESTRCCIÓN
        C_Alquiler      CHAR(10)        NOT NULL,
        TipoDoc         TINYINT         NOT NULL,
        NroDoc          VARCHAR(8)      NOT NULL,
        ID_T_Vehiculo   TINYINT         NOT NULL,
        Estado          TINYINT         NOT NULL,
        FAlq            DATE            NOT NULL,
        Monto_Total     DECIMAL(10,2)   NOT NULL,

        -- RESTRCCIÓN PRIMARY KEY
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
        
        -- ESTADO_AQL 1 / 2 / 3 Valores posibles
        CONSTRAINT CK_Estado_Alquiler CHECK
        (
            Estado = 0 OR
            Estado = 1 OR
            Estado = 2  
        ),

        -- FECHAAQL CK Validación de fecha
        CONSTRAINT CK_FechaAlq_Alquiler CHECK 
        (
             CASE  
                WHEN TRY_CONVERT(DATE, FAlq) IS NOT NULL THEN 1
                ELSE 0
            END = 1
        ),

        -- MONTO_TOTAL >= 0
        CONSTRAINT CK_Monto_Aqlquiler CHECK 
        (
            Monto_Total >= 0
        )
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Alquiler] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Alquiler] */
