
USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME    = 'Tipo_Doc'   AND
          TABLE_SCHEMA  = 'negocio'
)
BEGIN 
    -- CREACIÓN DE LA TABLA TIPO_DOC
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Tipo_Doc] 
    (
    --  NOMBRE        TIPO        RESTRCCIÓN 
        TipoDoc       TINYINT     PRIMARY KEY,
        Descripcion   VARCHAR(3)  NOT NULL,

        -- RESTRICCIÓN CK Pra la descripción del 
        -- TipoDoc
        CONSTRAINT CK_Desc_Tipo_Doc CHECK 
        (
            Descripcion     =    'DNI'  OR
            Descripcion     =    'LC'   OR
            Descripcion     =    'PAS'              
        )
    ); -- FIN CREACIÓN

    -- LOTE DE PRUEBA CON LOS TRES VALORES POSIBLES
    INSERT INTO     [db_alquileres_vehiculos].
                    [negocio].
                    [Tipo_Doc] 
                    ( TipoDoc, Descripcion ) VALUES 
                    ( 1,      'DNI'        ),
                    ( 2,      'LC'         ),
                    ( 3,      'PAS'        )                    
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Tipo_Doc] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Doc] */