
USE db_alquileres_vehiculos

DECLARE @T_DOC          TINYINT,
        @NRO_DOC        VARCHAR(8),
        @NOMBRE         VARCHAR(30),
        @APELLIDO       VARCHAR(30),
        @DIRECCION      VARCHAR(100),
        @EMAIL          VARCHAR(100),
        @FNAC           DATE,
        @TEL            VARCHAR(50)

DECLARE @CANTIDAD_CLIENTES INT = 0


DECLARE @TIPO_DOC_TABLA TABLE (TipoDoc TINYINT)

INSERT INTO @TIPO_DOC_TABLA (TipoDoc)
SELECT TipoDoc
FROM [db_alquileres_vehiculos].[negocio].[Tipo_Doc]



DECLARE @RAND_T_DOC INT = 0


WHILE  @CANTIDAD_CLIENTES < 1000
BEGIN 
    EXEC @RAND_T_DOC = [db_utils].[library].[sp_Str_Number_Random] 1, 3, 1, NULL
    SET @T_DOC = 
    (
        SELECT TipoDoc 
        FROM @TIPO_DOC_TABLA 
        WHERE TipoDoc = @RAND_T_DOC
    )

    EXEC [db_utils].[library].[sp_Generate_Valid_DNI]                @NRO_DOC OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    1,     @NOMBRE OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    1,     @APELLIDO OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    1,     @DIRECCION OUTPUT

    DECLARE @NRO_HOGAR CHAR(4) = ''

    EXEC [db_utils].[library].[sp_Str_Number_Random]    1,    4,    4,    @NRO_HOGAR OUTPUT
    EXEC [db_utils].[library].[sp_Str_Number_Random]    0,    9,   13,    @TEL OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    0,          @EMAIL OUTPUT
    EXEC [db_utils].[library].[sp_Date_Random]      '1980-01-01',   3,    @FNAC OUTPUT


    DECLARE @DIR_ENTERA VARCHAR(150) = @DIRECCION + ' ' + @NRO_HOGAR


    INSERT INTO [db_alquileres_vehiculos].[negocio].[Cliente]

    (   TipoDoc,    NroDoc,     Nombre,     Apellido,   Direccion,       Email,      FNac,   Telefono     ) VALUES
    (   @T_DOC,     @NRO_DOC,   @NOMBRE,    @APELLIDO,  @DIR_ENTERA,     @EMAIL,     @FNAC,  @TEL         )


    SET @CANTIDAD_CLIENTES = @CANTIDAD_CLIENTES + 1
END

SELECT Descripcion, NroDoc, Nombre, Apellido, Email, FNac, Telefono, Direccion 
FROM [db_alquileres_vehiculos].[negocio].[Cliente] 
INNER JOIN [db_alquileres_vehiculos].[negocio].[Tipo_Doc] 
ON Cliente.TipoDoc = Tipo_Doc.TipoDoc


