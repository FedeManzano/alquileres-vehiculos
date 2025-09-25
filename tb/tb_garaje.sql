
USE db_alquileres_vehiculos
/*
    Script para crear la tabla Garaje en la base de datos.
    La tabla almacena información sobre los garajes donde se estacionan los vehículos.
    Autor: Federico M. (2024)
*/
IF NOT EXISTS 
(
    SELECT 1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Garaje'       AND 
            TABLE_SCHEMA    = 'negocio'  
)
BEGIN 
    CREATE TABLE    [db_alquileres_vehiculos]. 
                    [negocio]. 
                    [Garaje]
    (
    --  NOMBRE         TIPO         RESTRICCIÓN 
        ID_Garaje      SMALLINT     IDENTITY(1,1) PRIMARY KEY,
        Direccion      VARCHAR(100) NOT NULL,
        Capacidad      SMALLINT     NOT NULL,
        Ocupados       SMALLINT     NOT NULL
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Garaje] Ya existe en la BD: db_alquileres_vehiculos')

/*
DROP TABLE IF EXISTS        [db_alquileres_vehiculos].
                            [negocio].
                            [Garaje] */
