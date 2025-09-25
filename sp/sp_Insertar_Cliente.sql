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
    @MED_PAGO       TINYINT,
    @RES            INT = -1 OUTPUT
AS 
BEGIN 
    --  Validar y formatear datos antes de la inserción
    SET NOCOUNT ON
    BEGIN TRANSACTION T_INSERTAR_CLIENTE -- Inicia la transacción

    BEGIN TRY -- Intenta ejecutar el bloque de código

        --  Validar los datos utilizando la función fn_Validar_Cliente
        SET @RES = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @MED_PAGO,
            @TEL
        ) 

        -- Manejar los diferentes códigos de error devueltos por la función
        IF @RES = 0
            RAISERROR ( 'El tipo de documento no existe', 11, 1) -- Error de severidad 11 (error del usuario)
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
        IF @RES = 8
            RAISERROR ( 'El medio de pago no existe', 11, 1)

        -- Formatear los datos antes de la inserción
        SET @NOMBRE     = TRIM(@NOMBRE)
        SET @APELLIDO   = TRIM(@APELLIDO)
        SET @EMAIL = LOWER(@EMAIL)

        -- Formatear campos específicos (primera letra en mayúscula)
        EXEC [db_utils].[library].[sp_Format_Tittle] @DIRECCION OUTPUT 
        EXEC [db_utils].[library].[sp_Format_Tittle] @NOMBRE    OUTPUT
        EXEC [db_utils].[library].[sp_Format_Tittle] @APELLIDO  OUTPUT

        SET @RES = 1         -- Lo insertó correctamente 

        INSERT INTO 
        [db_alquileres_vehiculos].
        [negocio].
        [Cliente] 
        (   TipoDoc,    NroDoc,     Nombre,     Apellido,   Direccion,      Email,      FNac,   Telefono, MedioPago    ) VALUES
        (   @T_DOC,     @NRO_DOC,   @NOMBRE,    @APELLIDO,  @DIRECCION,     @EMAIL,     @FNAC,  @TEL,     @MED_PAGO    )

        COMMIT TRANSACTION -- Confirma la transacción si todo salió bien
     
    END TRY 
    BEGIN CATCH 

        DECLARE @MJE_ERROR  NVARCHAR(100),
                @SEVERIDAD  INT,
                @ESTADO     INT 

        -- Captura el mensaje de error y sus detalles
        SELECT  @MJE_ERROR = ERROR_MESSAGE(), 
                @SEVERIDAD = ERROR_SEVERITY(),
                @ESTADO    = ERROR_STATE()

        -- Si ocurrió un error, se revierte la transacción y se maneja el error
        SET @RES = -1
        RAISERROR (@MJE_ERROR, @SEVERIDAD, @ESTADO)

        -- Revertir la transacción en caso de error
        ROLLBACK TRANSACTION T_INSERTAR_CLIENTE
    END CATCH
END


