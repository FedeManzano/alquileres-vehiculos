USE db_alquileres_vehiculos

/**
    Procedimiento almacenado para insertar un nuevo alquiler en la tabla Alquiler.
    Realiza validaciones para asegurar la integridad de los datos.
    Autor: Federico M. (2024)
*/

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Insertar_Alquiler]
@TIPO_DOC       TINYINT,
@NRO_DOC        VARCHAR(8),
@ID_T_V         SMALLINT,
@ESTADO         TINYINT,
@F_ALQ          DATE,
@RES            INT = -1     OUTPUT
AS 
BEGIN
    -- Declaración de la transacción
    BEGIN TRANSACTION T_INSERTAR_ALQ
    BEGIN TRY --  Inicio del bloque TRY
        SET @RES = -1 -- Valor por defecto para indicar éxito

        IF NOT EXISTS -- Validación del tipo de documento
        (
            SELECT 1 
            FROM    [db_alquileres_vehiculos].[negocio].[Tipo_Doc]
            WHERE TipoDoc = @TIPO_DOC
        )
        BEGIN 
            SET @RES = 0
            RAISERROR('Tipo de documento inválido',16,1)
        END

        IF NOT EXISTS -- Validación del cliente
        (
            SELECT 1 
            FROM    [db_alquileres_vehiculos].[negocio].[Cliente]
            WHERE NroDoc = @NRO_DOC
        )
        BEGIN
            SET @RES = 2
            RAISERROR('Cliente inexistente',16,1)
        END

        IF NOT EXISTS -- Validación del tipo de vehículo
        (
            SELECT 1 
            FROM    [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo]
            WHERE ID_Tipo_Vehiculo = @ID_T_V
        )
        BEGIN 
            SET @RES = 3
            RAISERROR('Tipo de vehículo inválido',16,1)
        END

        SET @ESTADO = 1 -- Estado inicial del alquiler (1 = Activo)

        DECLARE @VF INT =  -- Validación de la fecha de alquiler
        (
            SELECT
                CASE
                    WHEN TRY_CONVERT(DATE,@F_ALQ) IS NULL THEN 0
                    ELSE 1
                END
        )

        IF @VF = 0
        BEGIN 
            SET @RES = 4
            RAISERROR('Fecha de alquiler inválida',16,1)
        END

        -- Generación del número de alquiler
        DECLARE @NRO_ALQ INT = 
        (
            SELECT  COUNT(*)
            FROM    [db_alquileres_vehiculos].[negocio].[Alquiler]
            WHERE   TipoDoc         =     @TIPO_DOC     AND 
                    NroDoc          =     @NRO_DOC      AND 
                    ID_T_Vehiculo   =     @ID_T_V
        ) + 1

        --- Inserción del nuevo alquiler
        INSERT INTO [db_alquileres_vehiculos].[negocio].[Alquiler] 
        (   NroAlquiler,   TipoDoc,     NroDoc,     ID_T_Vehiculo,      Estado,     FAlq    ) VALUES 
        (   @NRO_ALQ,      @TIPO_DOC,   @NRO_DOC,   @ID_T_V,            @ESTADO,    @F_ALQ  )

        COMMIT TRANSACTION T_INSERTAR_ALQ
    END TRY 
    BEGIN CATCH 
        DECLARE @MJE_ERROR  NVARCHAR(300),
                @EST        INT,
                @SEVERIDAD  INT 
        
        SELECT @MJE_ERROR = ERROR_MESSAGE(),
               @EST        = ERROR_STATE(),
               @SEVERIDAD  = ERROR_SEVERITY()
        
        RAISERROR(@MJE_ERROR,  -- Mensaje de error
                  @SEVERIDAD,  -- Severidad del error
                  @EST)        -- Estado del error

        ROLLBACK TRANSACTION T_INSERTAR_ALQ
    END CATCH
END


