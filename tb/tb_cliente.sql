USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND 
            TABLE_NAME   = 'Cliente' 

)
BEGIN 
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Cliente] 
    (
        TipoDoc TINYINT NOT NULL,
        NroDoc  VARCHAR(8) NOT NULL,

        CONSTRAINT PK_Cliente PRIMARY KEY(TipoDoc, NroDoc),
        CONSTRAINT FK_Tipo_Doc FOREIGN KEY(TipoDoc) 
        REFERENCES [db_alquileres_vehiculos].[negocio].[Tipo_Doc](TipoDoc)
    );
END
