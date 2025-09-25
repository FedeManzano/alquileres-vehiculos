USE db_alquileres_vehiculos
/**
    Script para crear la tabla Medio_Pago en la base de datos.
    La tabla almacena información sobre los medios de pago disponibles para los alquileres.
    Autor: Federico M. (2024)
*/
IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Medio_Pago' AND
            TABLE_SCHEMA    = 'negocio'
)
BEGIN 
    -- Crear la tabla Medio_Pago con sus campos y restricciones
    PRINT('Creando la tabla [db_alquileres_vehiculos].[negocio].[Medio_Pago] en la BD: db_alquileres_vehiculos')
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Medio_Pago] (
    --  NOMBRE              TOPO            RESTRICCIÓN
        ID_Medio_Pago       TINYINT         PRIMARY KEY,
        Descripcion         VARCHAR(30)     NOT NULL,
        CONSTRAINT CK_Descripcion_Medio_Pago CHECK (
            LEN(Descripcion) > 0 AND LEN(Descripcion) <= 30
        )
    );
END ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Medio_Pago] Ya existe en la BD: db_alquileres_vehiculos')

-- DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Medio_Pago]
