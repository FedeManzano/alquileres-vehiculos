USE db_alquileres_vehiculos


GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Insertar_Cliente] 
    @T_DOC          TINYINT,
    @NRO_DOC        VARCHAR(8),
    @NOMBRE         VARCHAR(30),
    @APELLIDO       VARCHAR(30),
    @DIRECCION      VARCHAR(100),
    @EMAIL          VARCHAR(100),
    @FNAC           DATE,
    @TEL            VARCHAR(50),
    @RES            INT OUTPUT
AS 
BEGIN 
    BEGIN TRANSACTION T_INSERTAR_CLIENTE

    BEGIN TRY 
        SET @RES = -1

        IF NOT EXISTS
        (
            SELECT 1
            FROM [db_alquileres_vehiculos].[negocio].[Tipo_Doc]
            WHERE TipoDoc = @T_DOC
        )
        BEGIN 
            SET @RES = 0
            RAISERROR ( 'El tipo de documento no existe', 11, 1)
        END

        IF NOT EXISTS 
        (
            SELECT 1
            FROM    [db_alquileres_vehiculos].
                    [negocio].
                    [Cliente]
            WHERE   TipoDoc = @T_DOC    AND
                    NroDoc  = @NRO_DOC
        )
        BEGIN 
            SET @RES = 2
            RAISERROR ( 'El nro de documento no existe', 11, 1)
        END

        SET @NOMBRE     = TRIM(@NOMBRE)
        SET @APELLIDO   = TRIM(@APELLIDO)

        IF @NOMBRE LIKE '[^a-zA-Z]'
        BEGIN 
            SET @RES = 3
            RAISERROR ( 'El nombre posee caracteres erroneos', 11, 1)
        END

        IF @APELLIDO LIKE '[^a-zA-Z]'
        BEGIN 
            SET @RES = 4
            RAISERROR ( 'El apellido posee caracteres erroneos', 11, 1)
        END

        IF [db_utils].[library].[fn_Validate_Email](@EMAIL) = 0
        BEGIN 
            SET @RES = 5
            RAISERROR ( 'El email es erroneo', 11, 1)
        END

        EXEC [db_utils].[library].[sp_Format_Tittle] @DIRECCION OUTPUT 

        INSERT INTO 
        [db_alquileres_vehiculos].
        [negocio].
        [Cliente] 
        (   TipoDoc,    NroDoc,     Nombre,     Apellido,   Direccion,      Email,      FNac,   Telefono    ) VALUES
        (   @T_DOC,     @NRO_DOC,   @NOMBRE,    @APELLIDO,  @DIRECCION,     @EMAIL,     @FNAC,  @TEL        )

        COMMIT TRANSACTION
        RETURN 1 -- Lo insertó correctamente    
    END TRY 
    BEGIN CATCH 

        DECLARE @MJE_ERROR  NVARCHAR(100),
                @SEVERIDAD  INT,
                @ESTADO     INT 


        SELECT  @MJE_ERROR = ERROR_MESSAGE(), 
                @SEVERIDAD = ERROR_SEVERITY(),
                @ESTADO    = ERROR_STATE()

        SET @RES = -1
        RAISERROR (@MJE_ERROR, @SEVERIDAD, @ESTADO)
       
        IF @@ROWCOUNT > 1
            ROLLBACK TRANSACTION T_INSERTAR_CLIENTE
    END CATCH
END

