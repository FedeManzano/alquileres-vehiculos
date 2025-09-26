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
                FAC.MontoTotal      MONTO_TOTAL 
        FROM        [db_alquileres_vehiculos].[negocio].[Factura]   AS FAC INNER JOIN 
                    [db_alquileres_vehiculos].[negocio].[Alquiler]  AS ALQ ON ALQ.CodFactura = FAC.CodFactura 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Cliente]   AS CLI ON CLI.TipoDoc = ALQ.TipoDoc AND 
                                                                              CLI.NroDoc  = ALQ.NroDoc 
        INNER JOIN  [db_alquileres_vehiculos].[negocio].[Tipo_Doc] TD ON TD.TipoDoc = ALQ.TipoDoc 
        INNER JOIN [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] TV ON TV.ID_Tipo_Vehiculo = ALQ.ID_T_Vehiculo 
        WHERE ALQ.Estado = 1
    )