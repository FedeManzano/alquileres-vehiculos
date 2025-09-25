USE db_alquileres_vehiculos


/**
    Función para validar los datos de un cliente antes de su inserción o actualización.
    Retorna un código de resultado según la validación:
        0: Tipo de documento no existe
        1: Datos válidos
        2: Número de documento inválido
        3: DNI ya registrado
        4: Nombre inválido
        5: Apellido inválido
        6: Email inválido
        7: Email ya registrado
*/
GO
CREATE OR ALTER FUNCTION [negocio].[fn_Validar_Cliente]
(
    @T_DOC          TINYINT,
    @NRO_DOC        VARCHAR(8),
    @NOMBRE         VARCHAR(30),
    @APELLIDO       VARCHAR(30),
    @DIRECCION      VARCHAR(100),
    @EMAIL          VARCHAR(100),
    @FNAC           DATE,
    @MED_PAGO       TINYINT,
    @TEL            VARCHAR(50)
)
RETURNS INT 
AS 
BEGIN
    IF NOT EXISTS
    (
        SELECT 1
        FROM [db_alquileres_vehiculos].[negocio].[Tipo_Doc]
        WHERE TipoDoc = @T_DOC
    )
        RETURN 0

    IF  [db_utils].
        [library].
        [fn_Validate_Dni] (@NRO_DOC) = 0
        RETURN 2

    IF EXISTS 
    (
        SELECT 1
        FROM    [db_alquileres_vehiculos].
                [negocio]. 
                [Cliente]
        WHERE   @NRO_DOC = NroDoc AND
                @T_DOC   = TipoDoc 
    )
        RETURN 3
    
    IF @NOMBRE  LIKE '%[^a-zA-Z]%' OR LEN(@NOMBRE) > 30 OR LEN(@NOMBRE) = 0
        RETURN 4
    IF @APELLIDO LIKE '%[^a-zA-Z]%' OR LEN(@APELLIDO) > 30 OR LEN(@APELLIDO) = 0
        RETURN 5

    IF [db_utils].[library].[fn_Validate_Email](@EMAIL) = 0
        RETURN 6
    
    IF EXISTS 
    (
        SELECT 1
        FROM    [db_alquileres_vehiculos].
                [negocio]. 
                [Cliente]
        WHERE   @EMAIL = Email
    )
        RETURN 7
    IF NOT EXISTS
    (   
        SELECT 1
        FROM    [db_alquileres_vehiculos].
                [negocio]. 
                [Medio_Pago]
        WHERE ID_Medio_Pago = @MED_PAGO
    )
        RETURN 8
    RETURN 1
END