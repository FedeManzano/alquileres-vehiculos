/**
    _sp_Insertar_Agencia.sql
    Procedimiento almacenado para insertar una nueva agencia en la base de datos.   
    Realiza validaciones y formatea los datos antes de la inserción.
    Parámetros:
        @CUITARGENTINA  VARCHAR(11) - CUIT de la agencia (debe ser único y válido)
        @CORREO         VARCHAR(100)- Correo electrónico de la agencia (opcional, debe ser único si se proporciona)
        @NOMBRE         VARCHAR(30) - Nombre de la agencia (no puede contener caracteres especiales)
        @TELEFONO       VARCHAR(20) - Teléfono de la agencia (opcional)
        @DIRECCION      VARCHAR(100)- Dirección de la agencia
*/
USE db_alquileres_vehiculos;

GO 
CREATE OR ALTER PROCEDURE [negocio].[sp_Insertar_Agencia]
    @CUITARGENTINA VARCHAR(11),
    @CORREO             VARCHAR(100) = NULL,
    @NOMBRE             VARCHAR(30),
    @TELEFONO           VARCHAR(20) = NULL,
    @DIRECCION          VARCHAR(100) 
AS
BEGIN
    DECLARE @RESPUESTACUIT INT;
    EXEC @RESPUESTACUIT = [db_utils].[library].[sp_Validate_Cuit] @CUITARGENTINA 

    IF @RESPUESTACUIT = 0
       RETURN 0 -- CUIT inválido

    IF EXISTS (
        SELECT 1 
        FROM [db_alquileres_vehiculos].[negocio].[Agencia] 
        WHERE CuitAgencia = @CUITARGENTINA
    )
        RETURN 2 -- La agencia ya existe

    IF @CORREO IS NOT NULL AND EXISTS (
        SELECT 1 
        FROM [db_alquileres_vehiculos].[negocio].[Agencia] 
        WHERE Correo = @CORREO
    )
        RETURN 3 -- El correo ya está en uso
    IF @NOMBRE LIKE '%[^a-zA-Z0-9 .]%'
        RETURN 4 -- El nombre contiene caracteres no permitidos
    
    EXEC [db_utils].[library].[sp_Format_Title] @NOMBRE OUTPUT
    EXEC [db_utils].[library].[sp_Format_Title] @DIRECCION OUTPUT

    INSERT INTO [db_alquileres_vehiculos].[negocio].[Agencia] 
    (   CuitAgencia,       Correo,     Nombre,        Telefono,       Direccion   ) VALUES 
    (   @CUITARGENTINA,    @CORREO,    @NOMBRE,       @TELEFONO,      @DIRECCION  )
END
