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
    @RES            INT = -1 OUTPUT
AS 
BEGIN 

    SET NOCOUNT ON
    BEGIN TRANSACTION T_INSERTAR_CLIENTE

    BEGIN TRY 
        SET @RES = -1

        IF [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) = 0
        BEGIN 
            SET @RES = 0
            RAISERROR ( 'El tipo de documento no existe', 11, 1)
        END


        IF [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) = 2
        BEGIN 
            SET @RES = 2
            RAISERROR ( 'Número de documento inválido', 11, 1)
        END

        IF [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) = 3
        BEGIN 
            SET @RES = 3
            RAISERROR ( 'El DNI ta se encontraba registrado', 11, 1)
        END


        IF [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) = 4
        BEGIN 
            SET @RES = 4
            RAISERROR ( 'El nombre es inválido', 11, 1)
        END

        IF [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) = 5
        BEGIN 
            SET @RES = 5
            RAISERROR ( 'El apellido es inválido', 11, 1)
        END

        IF [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) = 6
        BEGIN 
            SET @RES = 6
            RAISERROR ( 'El email es inválido', 11, 1)
        END

        SET @NOMBRE     = TRIM(@NOMBRE)
        SET @APELLIDO   = TRIM(@APELLIDO)


        SET @EMAIL = LOWER(@EMAIL)

        EXEC [db_utils].[library].[sp_Format_Tittle] @DIRECCION OUTPUT 
        EXEC [db_utils].[library].[sp_Format_Tittle] @NOMBRE    OUTPUT
        EXEC [db_utils].[library].[sp_Format_Tittle] @APELLIDO  OUTPUT

        SET @RES = 1         -- Lo insertó correctamente 

        INSERT INTO 
        [db_alquileres_vehiculos].
        [negocio].
        [Cliente] 
        (   TipoDoc,    NroDoc,     Nombre,     Apellido,   Direccion,      Email,      FNac,   Telefono    ) VALUES
        (   @T_DOC,     @NRO_DOC,   @NOMBRE,    @APELLIDO,  @DIRECCION,     @EMAIL,     @FNAC,  @TEL        )
        
        COMMIT TRANSACTION
     
    END TRY 
    BEGIN CATCH 

        DECLARE @MJE_ERROR  NVARCHAR(100),
                @SEVERIDAD  INT,
                @ESTADO     INT 


        SELECT  @MJE_ERROR = ERROR_MESSAGE(), 
                @SEVERIDAD = ERROR_SEVERITY(),
                @ESTADO    = ERROR_STATE()

        RAISERROR (@MJE_ERROR, @SEVERIDAD, @ESTADO)
       
        IF @@ROWCOUNT > 1
            ROLLBACK TRANSACTION T_INSERTAR_CLIENTE
    END CATCH
END

