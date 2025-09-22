USE db_alquileres_peliculas


IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Agencia'      AND 
            TABLE_SCHEMA    = 'negocio'
)
BEGIN 
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio]. 
                    [Agencia]

    (   
    --  NOMBRECAMPO     TIPO            RESTRICCIÓN    
        CuitAgencia     VARCHAR(11)     PRIMARY KEY,
        Correo          VARCHAR(100)    UNIQUE,
        Nombre          VARCHAR(30)     NOT NULL,
        Telefono        VARCHAR(20),
        Direccion       VARCHAR(100)    NOT NULL
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Agencia] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Agencia] */