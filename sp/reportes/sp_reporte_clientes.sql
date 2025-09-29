USE db_alquileres_vehiculos

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Reporte_Clientes] 
@XML_CLIENTES XML OUTPUT
AS 
BEGIN 
    SET @XML_CLIENTES = 
    (
        SELECT  TIPO_DOC,
                NRO_DOC,
                NOMBRE,
                APELLIDO,
                EMAIL,
                DIRECCION,
                TELEFONO,
                MEDIO_PAGO,
                FECHA_NAC
        FROM [db_alquileres_vehiculos].[negocio].[vw_Clientes_Activos]
        FOR XML PATH('Cliente'), ROOT('Clientes') 
    )
END
