

USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME    = 'Tipo_Vehiculo'   AND
          TABLE_SCHEMA  = 'negocio'
)
BEGIN 
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio]. 
                    [Tipo_Vehiculo]
    (
    --  CAMPO               TIPO_DATO   RESTRICCIÓN    
        ID_Tipo_Vehiculo    SMALLINT    PRIMARY KEY,
        Nombre              VARCHAR(15) NOT NULL,

        -- Restricción CHECK
        CONSTRAINT CK_Nombre_Vehiculo CHECK
        (
            Nombre = 'AUTOMOVIL'    OR
            Nombre = 'CAMIONETA'
        )
    )

    INSERT INTO     [db_alquileres_vehiculos].
                    [negocio]. 
                    [Tipo_Vehiculo] 
                    ( ID_Tipo_Vehiculo, Nombre ) VALUES
                    ( 1,                'AUTOMOVIL' ),
                    ( 2,                'CAMIONETA' )
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Vehiculo] */
