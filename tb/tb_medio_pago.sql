USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Medio_Pago' AND
            TABLE_SCHEMA    = 'negocio'
)
BEGIN 
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
