USE db_alquileres_vehiculos


DECLARE @NOMBRE     VARCHAR(30) = ''
DECLARE @APELLIDO   VARCHAR(30) = ''
DECLARE @EMAIL_P    VARCHAR(30) = ''
DECLARE @EMAIL_S    VARCHAR(30) = '@gmail.com'
DECLARE @CUIT       VARCHAR(14) = ''
DECLARE @AG_RAND    INT         = 0
DECLARE @CANT       INT         = 0

DECLARE @AGENCIA TABLE 
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CuitAgencia VARCHAR(14) NOT NULL
)

INSERT INTO @AGENCIA (CuitAgencia) 
SELECT CuitAgencia FROM [db_alquileres_vehiculos].[negocio].[Agencia]

WHILE @CANT < 20
BEGIN 

    EXEC [db_utils].[library].[sp_Str_letter_Random] 10,  1,  @NOMBRE     OUTPUT 
    EXEC [db_utils].[library].[sp_Str_letter_Random] 10,  1,  @APELLIDO   OUTPUT 
    EXEC [db_utils].[library].[sp_Str_letter_Random] 10,  0,  @EMAIL_P    OUTPUT 
    EXEC @AG_RAND = [db_utils].[library].[sp_Str_Number_Random]  1,  3,  1, NULL

    SET @CUIT = 
    (
        SELECT  CuitAgencia
        FROM    @AGENCIA
        WHERE   ID = @AG_RAND
    ) 

    SET @EMAIL_P = @EMAIL_P + @EMAIL_S

    INSERT INTO [db_alquileres_vehiculos].[negocio].[Empleado] 
    (   Nombre,   Apellido,     Email,      CuitAgencia  ) VALUES 
    (   @NOMBRE,  @APELLIDO,     @EMAIL_P,   @CUIT        )

    SET @CANT = @CANT + 1
END

SELECT * FROM [db_alquileres_vehiculos].[negocio].[Empleado]