USE db_alquileres_vehiculos

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
    
    IF @NOMBRE LIKE '%[^a-zA-Z]%'
        RETURN 4
    IF @APELLIDO LIKE '%[^a-zA-Z]%'
        RETURN 5

    IF [db_utils].[library].[fn_Validate_Email](@EMAIL) = 0
        RETURN 6
    RETURN 1
END