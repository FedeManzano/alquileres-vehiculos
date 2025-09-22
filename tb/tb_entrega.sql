

USE db_alquileres_vehiculos


IF NOT EXISTS 
(
    SELECT  1
    FROM   INFORMATION_SCHEMA.TABLES  
    WHERE  TABLE_NAME      = 'Entrega'  AND
           TABLE_SCHEMA    = 'negocio'
)
BEGIN
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Entrega]
    (
    --  NOMBRE          TIPO        RESTRCCIÓN
        NroEntrega      SMALLINT    IDENTITY(1,1) NOT NULL,
        C_Alquiler      CHAR(10)    NOT NULL,
        TipoDoc         TINYINT     NOT NULL,
        NroDoc          VARCHAR(8)  NOT NULL,
        ID_T_Vehiculo   TINYINT     NOT NULL,
           

    );

END

