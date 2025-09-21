
USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME    = 'Tipo_Doc'   AND
          TABLE_SCHEMA  = 'negocio'
)
BEGIN 
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Tipo_Doc] 
    (
         TipoDoc TINYINT PRIMARY KEY,
         Descripcion VARCHAR(3) NOT NULL
    );


    INSERT INTO     [db_alquileres_vehiculos].
                    [negocio].
                    [Tipo_Doc] 
                    (
                        TipoDoc, 
                        Descripcion
                    )
                    VALUES 
                    (1, 'DNI'),
                    (2, 'LC'),
                    (3, 'PAS')                    
END
