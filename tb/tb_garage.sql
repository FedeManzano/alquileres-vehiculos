
USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Garage'       AND 
            TABLE_SCHEMA    = 'negocio'  
)
BEGIN 
    CREATE TABLE    [db_alquileres_vehiculos]. 
                    [negocio]. 
                    [Garage]
    (
    --  NOMBRE         TIPO         RESTRICCIÓN 
        ID_Garage      SMALLINT     IDENTITY(1,1) PRIMARY KEY,
        Direccion      VARCHAR(100) NOT NULL,
        Capacidad      SMALLINT     NOT NULL,
        Ocupados       SMALLINT     NOT NULL
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Garage] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE  [db_alquileres_vehiculos].
            [negocio].
            [Garage] */
