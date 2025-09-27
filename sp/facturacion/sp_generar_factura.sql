USE db_alquileres_vehiculos

/***
    Procedimiento para generar la factura para un alquiler:
    Un alquiler puede estár compuesto por hasta (3) tuplas 
    de la tabla alquiler,para todas ellas va a existir un 
    único codigo de factura.
    PARAMETROS: 
        @TIPO_DOC -- Tipo de documento.
        @NRO_DOC  -- Nro de documento.
        @F_ALQ    -- Fecha en la que se realizó el alquiler.
        @COD_FAC  -- Código de factura unívoco para el alquiler.
*/
GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Generar_Factura]
@TIPO_DOC       TINYINT,
@NRO_DOC        VARCHAR(8),
@F_ALQ          DATE,
@COD_FAC        CHAR(10),
@RES            INT     OUTPUT
AS 
BEGIN 
    BEGIN TRANSACTION T_GENERAR_FACTURA
    BEGIN TRY
        DECLARE @MONTO_TOTAL DECIMAL(10,2)
        IF   
        (
            SELECT COUNT(*)
            FROM [db_alquileres_vehiculos].[negocio].[Alquiler]
            WHERE   TipoDoc             = @TIPO_DOC   AND 
                    NroDoc              = @NRO_DOC    AND 
                    FAlq                = @F_ALQ      AND 
                    CodFactura   IS NULL 
        ) = 0
        BEGIN 
            SET @RES = 0
            RAISERROR('El alquiler ya dispone de factura', 16, 1)
        END

        IF EXISTS
        (
            SELECT 1
            FROM  [db_alquileres_vehiculos].[negocio].[Alquiler]
            WHERE   TipoDoc             = @TIPO_DOC   AND 
                    NroDoc              = @NRO_DOC    AND 
                    FAlq                = @F_ALQ      AND 
                    Estado               IN (0,1,2,5) AND
                    CodFactura  IS  NOT NULL    
        )
        BEGIN 
            
            SET @COD_FAC = 
            (
                SELECT CodFactura
                FROM  [db_alquileres_vehiculos].[negocio].[Alquiler]
                WHERE   TipoDoc             = @TIPO_DOC   AND 
                        NroDoc              = @NRO_DOC    AND 
                        CodFactura   IS NOT NULL          AND
                        Estado              IN (0,1)      
            )
         
            UPDATE [db_alquileres_vehiculos].[negocio].[Alquiler]
            SET     CodFactura = @COD_FAC
            WHERE       TipoDoc             =       @TIPO_DOC   AND 
                        NroDoc              =       @NRO_DOC    AND 
                        FAlq                =       @F_ALQ      AND 
                        Estado              =       0           AND 
                        CodFactura     IS NULL

             SET @MONTO_TOTAL =  [db_alquileres_vehiculos].[negocio].[fn_Calcular_Monto_Total]
                                              (@TIPO_DOC, @NRO_DOC, @F_ALQ)

            IF @MONTO_TOTAL IS NULL OR @MONTO_TOTAL = 0
            BEGIN 
                SET @RES = 2
                RAISERROR('El monto para la fecha solicitada es erroneo', 16, 1)
            END

            UPDATE [db_alquileres_vehiculos].[negocio].[Factura]
            SET MontoTotal = @MONTO_TOTAL
            WHERE CodFactura = @COD_FAC

            SET @RES = 1
            COMMIT TRANSACTION T_GENERAR_FACTURA
            RETURN 1
        END
            
        SET @MONTO_TOTAL =  [db_alquileres_vehiculos].[negocio].[fn_Calcular_Monto_Total]
                                              (@TIPO_DOC, @NRO_DOC, @F_ALQ)

        IF @MONTO_TOTAL IS NULL OR @MONTO_TOTAL = 0
        BEGIN 
            SET @RES = 2
            RAISERROR('El monto para la fecha solicitada es erroneo', 16, 1)
        END

        INSERT INTO [db_alquileres_vehiculos].[negocio].[Factura]
        (   CodFactura,     FechaFactura,   MontoTotal  ) VALUES 
        (   @COD_FAC,       @F_ALQ,         @MONTO_TOTAL)

        UPDATE [db_alquileres_vehiculos].[negocio].[Alquiler]
        SET     CodFactura = @COD_FAC
        WHERE       TipoDoc             =       @TIPO_DOC   AND 
                    NroDoc              =       @NRO_DOC    AND 
                    FAlq                =       @F_ALQ      AND 
                    Estado              =       0           AND 
                    CodFactura  IS      NULL

        SET @RES = 1
        COMMIT TRANSACTION T_GENERAR_FACTURA
    END TRY 
    BEGIN CATCH
        DECLARE @MJE_ERROR  NVARCHAR(100),
                @EST        INT,
                @SEV        INT 

        SELECT  @MJE_ERROR  = ERROR_MESSAGE(),
                @EST        = ERROR_STATE(),
                @SEV        = ERROR_SEVERITY()

        RAISERROR(@MJE_ERROR, @SEV, @EST)        

        ROLLBACK TRANSACTION T_GENERAR_FACTURA
    END CATCH
END