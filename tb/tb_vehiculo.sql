
USE db_alquileres_vehiculos


IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Vehiculo' AND
            TABLE_SCHEMA    = 'negocio'
)
BEGIN 

    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Vehiculo]
    (
    --  NOMBRE              TOPO            RESTRICCIÓN    
        Patente             CHAR(7)         PRIMARY KEY,
        ID_Tipo_Vehiculo    SMALLINT        NOT NULL,
        Cuit_Agencia        VARCHAR(11)     NOT NULL,
        ID_Garage           SMALLINT        NOT NULL,
        Marca               VARCHAR(30)     NOT NULL,
        Modelo              VARCHAR(30)     NOT NULL,
        Año                 INT             NOT NULL,
        KmRealizados        INT             NOT NULL,
        PrecioAlq           DECIMAL(10,2)   NOT NULL,
        

        ------------- ****** RESTRICCIONES FORANEAS ******* --------------------------------
        CONSTRAINT FK_ID_Tipo_Vehiculo_Vehiculo FOREIGN KEY (ID_Tipo_Vehiculo)
            REFERENCES  [db_alquileres_vehiculos].
                        [negocio].
                        [Tipo_Vehiculo] (ID_Tipo_Vehiculo),

        CONSTRAINT FK_Cuit_Agencia_Vehiculo FOREIGN KEY(Cuit_Agencia) 
            REFERENCES  [db_alquileres_vehiculos].
                        [negocio].
                        [Agencia] (CuitAgencia),
        
        CONSTRAINT FK_ID_Garage_Vehiculo FOREIGN KEY(ID_Garage)
            REFERENCES [db_alquileres_vehiculos].
                        [negocio].
                        [Garage] (ID_Garage),

        ------------- ****** FIN RESTRICCIONES FORANEAS ******* --------------------------------

        ------------- ****** RESTRICCIONES CHECK ******* --------------------------------

        CONSTRAINT CK_Patente_Vehiculo CHECK 
        (
            LEN(Patente) = 7 AND 
            Patente LIKE '[0-9][0-9][0-9] [A-Z][A-Z][A-Z]'
        ),

        CONSTRAINT CK_Ano_Vehiculo CHECK 
        (
            -- EVITA VALORES MUY ALTOS EN EL CAMPO AÑO
            Año >= 1900 AND año < 3000
        ),

        CONSTRAINT CK_KM_Vehiculo CHECK 
        (
            KmRealizados >= 0
        ), 

        CONSTRAINT CK_PrecioAlq_Vehiculo CHECK 
        (
            PrecioAlq >= 0
        )

        ------------- ****** FIN RESTRICCIONES CHECK ******* --------------------------------
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Vehiculo] Ya existe en la BD: db_alquileres_vehiculos')

