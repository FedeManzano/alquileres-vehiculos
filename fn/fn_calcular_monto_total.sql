USE db_alquileres_vehiculos


GO
CREATE OR ALTER FUNCTION [negocio].[fn_Calcular_Monto_Total] (@TIPO_DOC TINYINT, @NRO_DOC VARCHAR(8), @F_ALQ DATE) 
RETURNS DECIMAL(10,2)
AS 
BEGIN 
    RETURN 
    (
        SELECT SUM(TI.Precio)
            FROM        [db_alquileres_vehiculos].[negocio].[Alquiler]             ALQ
            INNER JOIN  [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo]        TI 
            ON TI.ID_Tipo_Vehiculo = ALQ.ID_T_Vehiculo 
                WHERE   TipoDoc             =       @TIPO_DOC   AND 
                        NroDoc              =       @NRO_DOC    AND 
                        FAlq                =       @F_ALQ      AND 
                        Estado          NOT IN      (1,3) -- PAGADO | CANCELADO
    )
END


    