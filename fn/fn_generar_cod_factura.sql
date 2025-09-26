USE db_alquileres_vehiculos

GO
CREATE OR ALTER FUNCTION [negocio].[fn_Generar_Cod_Factura](@NRO_DOC VARCHAR(8))
RETURNS CHAR(10)
AS 
BEGIN 
    DECLARE @COD_FAC CHAR(10) = ''
    DECLARE @COD_FAC_AUX CHAR(6) = RIGHT
    ( 
        CAST(CHECKSUM(GETDATE()) AS VARCHAR(15)), 6
    )

    SET @COD_FAC = 'F' + @COD_FAC_AUX + RIGHT(@NRO_DOC, 3)

    WHILE EXISTS 
    (
        SELECT 1 
        FROM [db_alquileres_vehiculos].[negocio].[Factura] 
        WHERE CodFactura = @COD_FAC
    )
    BEGIN 
        SET @COD_FAC_AUX = RIGHT
        ( 
            CAST(CHECKSUM(GETDATE()) AS VARCHAR(15)), 6
        )
        SET @COD_FAC = ''
        SET @COD_FAC = 'F' + @COD_FAC_AUX + RIGHT(@NRO_DOC, 3)
    END

    RETURN @COD_FAC
END