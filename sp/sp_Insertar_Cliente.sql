USE db_alquileres_vehiculos

/**
    Procedimiento almacenado para insertar un nuevo cliente en la base de datos.
    Realiza validaciones y formatea los datos antes de la inserción.    
    Parámetros:
        @T_DOC      TINYINT     - Tipo de documento (referencia a la tabla Tipo_Doc)
        @NRO_DOC    VARCHAR(8)  - Número de documento
        @NOMBRE     VARCHAR(30) - Nombre del cliente
        @APELLIDO   VARCHAR(30) - Apellido del cliente
        @DIRECCION  VARCHAR(100)- Dirección del cliente
        @EMAIL      VARCHAR(100)- Email del cliente
        @FNAC       DATE        - Fecha de nacimiento del cliente
        @TEL        VARCHAR(50) - Teléfono del cliente (opcional)
        @RES        INT OUTPUT  - Código de resultado de la operación
            0: Tipo de documento no existe
            1: Inserción exitosa
            2: Número de documento inválido
            3: DNI ya registrado
            4: Nombre inválido
            5: Apellido inválido
            6: Email inválido
            7: Email ya registrado
*/
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
        SET @RES = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @TEL
        ) 
        IF @RES = 0
            RAISERROR ( 'El tipo de documento no existe', 11, 1)
        IF @RES = 2
            RAISERROR ( 'Número de documento inválido', 11, 1)
        IF @RES = 3
            RAISERROR ( 'El DNI ya se encontraba registrado', 11, 1)
        IF @RES = 4
            RAISERROR ( 'El nombre es inválido', 11, 1)
        IF @RES = 5
            RAISERROR ( 'El apellido es inválido', 11, 1)
        IF @RES = 6
            RAISERROR ( 'El email es inválido', 11, 1)
        IF @RES = 7
            RAISERROR ( 'El email ya fue registrado en la BD', 11, 1)
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
        ROLLBACK TRANSACTION T_INSERTAR_CLIENTE
    END CATCH
END


