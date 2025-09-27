USE db_alquileres_vehiculos


GO
CREATE OR ALTER FUNCTION [negocio].[fn_Calcular_Monto_Adicional] (@TIPO_DOC TINYINT, @NRO_DOC VARCHAR(8))
RETURNS DECIMAL(10,2)
AS 
BEGIN 
    RETURN 
    (
        SELECT ISNULL(SUM(Monto), 0)
        FROM [db_alquileres_vehiculos].[negocio].[Adicional]
        WHERE CodFacutura IN
        (
            SELECT CodFactura
            FROM [db_alquileres_vehiculos].[negocio].[Alquiler]
            WHERE   TipoDoc = @TIPO_DOC AND 
                    NroDoc = @NRO_DOC   AND 
                    Estado = 5
        ) 
    )
END
