USE db_alquileres_vehiculos

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Generar_Factura]
@TIPO_DOC       TINYINT,
@NRO_DOC        VARCHAR(8),
@F_ALQ          DATE,
@RES            INT     OUTPUT
AS 
BEGIN 

    BEGIN TRANSACTION T_GENERAR_FACTURA

    BEGIN TRY

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
            
        DECLARE @MONTO_TOTAL DECIMAL(10,2) = 
        (
            SELECT SUM(TI.Precio)
            FROM        [db_alquileres_vehiculos].[negocio].[Alquiler]             ALQ
            INNER JOIN  [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo]        TI 
            ON TI.ID_Tipo_Vehiculo = ALQ.ID_T_Vehiculo 
                WHERE   TipoDoc             =       @TIPO_DOC   AND 
                        NroDoc              =       @NRO_DOC    AND 
                        FAlq                =       @F_ALQ      AND 
                        Estado              <>      1
        )

        IF @MONTO_TOTAL IS NULL OR @MONTO_TOTAL = 0
        BEGIN 
            SET @RES = 2
            RAISERROR('El monto para la fecha solicitada es erroneo', 16, 1)
        END
            
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