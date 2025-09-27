USE db_alquileres_vehiculos


GO
CREATE OR ALTER FUNCTION [negocio].[fn_Calcular_Monto_Total] (@TIPO_DOC TINYINT, @NRO_DOC VARCHAR(8), @F_ALQ DATE) 
RETURNS DECIMAL(10,2)
AS 
BEGIN 

    DECLARE @ADICIONAL_TOTAL DECIMAL(10,2) = [db_alquileres_vehiculos].[negocio].[fn_Calcular_Monto_Adicional]
                                                (@TIPO_DOC, @NRO_DOC)


    DECLARE @MONTO_ALQUILER DECIMAL(10,2) = [db_alquileres_vehiculos].[negocio].[fn_Calcular_Monto_Alquiler] 
                                                (@TIPO_DOC, @NRO_DOC, @F_ALQ)

    RETURN @MONTO_ALQUILER + @ADICIONAL_TOTAL
END


    