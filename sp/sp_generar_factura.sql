USE db_alquileres_vehiculos

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Generar_Factura]
@TIPO_DOC       TINYINT,
@NRO_DOC        VARCHAR(8),
@ID_T_V         SMALLINT,
@F_ALQ          DATE,
@RES            INT     OUTPUT
AS 
BEGIN 

    BEGIN TRANSACTION T_GENERAR_FACTURA

    BEGIN TRY
        DECLARE @MONTO_TOTAL DECIMAL(10,2) = 
        (
            SELECT COUNT(*) * 
            (
                SELECT Precio 
                FROM [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] 
                WHERE ID_Tipo_Vehiculo = @ID_T_V
            )
            FROM [db_alquileres_vehiculos].[negocio].[Alquiler]
            WHERE   TipoDoc             = @TIPO_DOC   AND 
                    NroDoc              = @NRO_DOC    AND 
                    ID_T_Vehiculo       = @ID_T_V     AND 
                    FAlq                = @F_ALQ
        )

        IF @MONTO_TOTAL = 0
            RETURN 0

        DECLARE @COD_FAC CHAR(10) = ''
        EXEC [db_utils].[library].[sp_Str_Number_Random] 0, 9, 9, @COD_FAC OUTPUT
        SET @COD_FAC = 'F' + @COD_FAC 

        WHILE EXISTS 
        (
            SELECT 1 
            FROM [db_alquileres_vehiculos].[negocio].[Factura] 
            WHERE CodFactura = @COD_FAC
        )
        BEGIN 
            EXEC [db_utils].[library].[sp_Str_Number_Random] 0, 9, 9, @COD_FAC OUTPUT
            SET @COD_FAC = 'F' + @COD_FAC 
        END

        INSERT INTO [db_alquileres_vehiculos].[negocio].[Factura]
        (   CodFactura,     FechaFactura,   MontoTotal  ) VALUES 
        (   @COD_FAC,       @F_ALQ,         @MONTO_TOTAL)

        UPDATE [db_alquileres_vehiculos].[negocio].[Alquiler]
        SET     CodFactura = @COD_FAC
        WHERE       TipoDoc             = @TIPO_DOC   AND 
                    NroDoc              = @NRO_DOC    AND 
                    ID_T_Vehiculo       = @ID_T_V     AND 
                    FAlq                = @F_ALQ
        COMMIT TRANSACTION T_GENERAR_FACTURA
    END TRY 
    BEGIN CATCH
        ROLLBACK TRANSACTION T_GENERAR_FACTURA
    END CATCH
END