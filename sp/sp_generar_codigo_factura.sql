USE db_alquileres_vehiculos


GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Generar_Codigo_Factura]
@COD_FAC    CHAR(10)    OUTPUT 
AS 
BEGIN 
    DECLARE @COD_FAC_AUX CHAR(9) = ''
    EXEC [db_utils].[library].[sp_Str_Number_Random] 0,  9,  9,  @COD_FAC_AUX OUTPUT
    SET @COD_FAC = 'F' + @COD_FAC_AUX

    WHILE EXISTS 
    (
        SELECT 1
        FROM [db_alquileres_vehiculos].[negocio].[Factura]
        WHERE CodFactura = @COD_FAC
    )
    BEGIN 
        SET @COD_FAC = ''
        EXEC [db_utils].[library].[sp_Str_Number_Random] 0,  9,  9,  @COD_FAC_AUX OUTPUT
        SET @COD_FAC = 'F' + @COD_FAC_AUX   
    END
END