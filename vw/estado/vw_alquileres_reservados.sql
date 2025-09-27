USE db_alquileres_vehiculos

GO
CREATE OR ALTER VIEW [negocio].[vw_Alquileres_Reservados] 
AS 
    (
        SELECT  FAC.CodFactura      CODIGO_FACTURA, 
                FAC.FechaFactura    FECHA_FACTURA, 
                TD.Descripcion      TIPO_DOCUMENTO, 
                CLI.NroDoc          NRO_DOCUMENTO, 
                CLI.Nombre          NOMBRE_CLIENTE, 
                CLI.Apellido        APELLIDO_CLIENTE,
                TV.Nombre           TIPO_VEHICULO, 
                MD.Descripcion      MEDIO_PAGO,
                FAC.MontoTotal      MONTO_TOTAL,
                CASE ALQ.Estado 
                    WHEN 0 THEN 'RESERVADO'
                    WHEN 1 THEN 'PAGADO'
                    WHEN 2 THEN 'RETIRADO'
                    WHEN 3 THEN 'CANCELADO'
                    WHEN 4 THEN 'DEVUELTO'
                    WHEN 5 THEN 'RETRASADO'
                END AS ESTADO_ALQUILER
        FROM        [db_alquileres_vehiculos].[negocio].[Factura]   AS FAC 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Alquiler]  AS ALQ ON ALQ.CodFactura = FAC.CodFactura 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Cliente]   AS CLI ON CLI.TipoDoc = ALQ.TipoDoc AND 
                                                                              CLI.NroDoc  = ALQ.NroDoc 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Tipo_Doc] TD      ON TD.TipoDoc = ALQ.TipoDoc 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] TV ON TV.ID_Tipo_Vehiculo = ALQ.ID_T_Vehiculo 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Medio_Pago] MD    ON MD.ID_Medio_Pago = CLI.MedioPago
        WHERE ALQ.Estado = 0
    )

     --GO
    --SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Reservados]