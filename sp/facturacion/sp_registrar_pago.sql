USE db_alquileres_vehiculos

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Registar_Pago]
@COD_FACTURA    CHAR(10),
@RES            INT     OUTPUT
AS 
BEGIN 
    BEGIN TRANSACTION T_REG_PAGO
    BEGIN TRY 
        UPDATE  [db_alquileres_vehiculos].[negocio].[Alquiler]
        SET     Estado = 1 -- Pagado
        WHERE   CodFactura = @COD_FACTURA AND 
        TipoDoc IN 
        (
            SELECT TipoDoc 
            FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
            WHERE CodFactura = @COD_FACTURA AND Estado = 0 
        ) AND 
        NroDoc  IN 
        (
            SELECT NroDoc 
            FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
            WHERE CodFactura = @COD_FACTURA AND Estado = 0
        ) 
        COMMIT TRANSACTION T_REG_PAGO
    END TRY
    BEGIN CATCH 
        ROLLBACK TRANSACTION T_REG_PAGO
    END CATCH
END