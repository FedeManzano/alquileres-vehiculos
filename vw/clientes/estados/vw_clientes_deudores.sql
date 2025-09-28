USE db_alquileres_vehiculos

GO
CREATE OR ALTER VIEW [negocio].[vw_Clientes_Deudores] 
AS 
    (
        SELECT  TipoDoc         AS TIPO_DOC, 
                NroDoc          AS NRO_DOC, 
                Nombre          AS NOMBRE, 
                Apellido        AS APELLIDO, 
                Email           AS EMAIL, 
                Direccion       AS DIRECCION, 
                Telefono        AS TELEFONO,
                MP.Descripcion  AS MEDIO_PAGO,
                FNac            AS FECHA_NAC
        FROM    [db_alquileres_vehiculos].[negocio].[Cliente]       CLI  INNER JOIN 
                [db_alquileres_vehiculos].[negocio].[Medio_Pago]    MP    
                ON MP.ID_Medio_Pago = CLI.MedioPago
            
        WHERE CLI.Estado = 2
    )

--GO
--SELECT * FROM [negocio].[vw_Clientes_Deudores] 