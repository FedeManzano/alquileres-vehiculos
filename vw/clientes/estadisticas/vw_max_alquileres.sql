USE db_alquileres_vehiculos

GO
CREATE OR ALTER VIEW [negocio].[vw_Cliente_Max_Reservas_Vehiculos]
AS 
    (       
        SELECT  CLI.TipoDoc                                     AS TIPO_DOC, 
                CLI.NroDoc                                      AS NRO_DOC, 
                CLI.Nombre                                      AS NOMBRE, 
                CLI.Apellido                                    AS APELLIDO, 
                CLI.Direccion                                   AS DIRECCION, 
                CLI.Email                                       AS EMAIL, 
                CLI.Telefono                                    AS TELEFONO, 
                CLI_MINIMOS.CANT_MIN_VEHICULOS_ALQUILADOS       AS CANTIDAD
        FROM [db_alquileres_vehiculos].[negocio].[Cliente] AS CLI INNER JOIN 
        (
            SELECT  ALQ.TipoDoc     AS TIPO_DOC_MIN, 
                    ALQ.NroDoc      AS NRO_DOC_MIN, 
                    COUNT(*)        AS CANT_MIN_VEHICULOS_ALQUILADOS
            FROM  [db_alquileres_vehiculos].[negocio].[Alquiler] AS ALQ
            GROUP BY ALQ.TipoDoc, ALQ.NroDoc
            HAVING COUNT(*) >=
            (
                SELECT MAX(CANT_RES_VEH.CANT_VEHICULOS) AS CANTIDAD_MINIMA_RESERVAS
                FROM 
                (
                    SELECT  ALQ.TipoDoc     AS TIPO_DOC,  
                            ALQ.NroDoc      AS NRO_DOC, 
                            COUNT(*)        AS CANT_VEHICULOS
                    FROM [db_alquileres_vehiculos].[negocio].[Alquiler] AS ALQ
                    GROUP BY ALQ.TipoDoc, ALQ.NroDoc
                ) AS CANT_RES_VEH
            )
        ) AS CLI_MINIMOS ON CLI.TipoDoc = CLI_MINIMOS.TIPO_DOC_MIN AND 
                            CLI.NroDoc = CLI_MINIMOS.NRO_DOC_MIN
    )

        
--GO
--SELECT * FROM [negocio].[vw_Cliente_Max_Reservas_Vehiculos]
        

