
USE db_alquileres_vehiculos

GO 
CREATE OR ALTER PROCEDURE [negocio].[sp_Insertar_Tipo_Doc]
@DESCRIPCION    VARCHAR(3),
@RES        INT = -1    OUTPUT
AS 
BEGIN 
    IF EXISTS 
    (
        SELECT 1
        FROM [db_alquileres_vehiculos].[negocio].[Tipo_Doc]
        WHERE @DESCRIPCION = Descripcion
    )
    BEGIN 
        SET @RES = 2 -- Descripción Existe
        RETURN 2
    END

    IF @DESCRIPCION NOT IN ('DNI', 'LC', 'PAS')
    BEGIN 
        SET @RES = 0 -- Descripción Erronea
        RETURN 0
    END

    DECLARE @TIPO_DOC TINYINT = 
    (
         SELECT COUNT(*)
         FROM [db_alquileres_vehiculos].[negocio].[Tipo_Doc]
    ) + 1

    IF @TIPO_DOC > 3
    BEGIN 
        SET @RES = 3 -- Solo pueden ser 3 tipos de documento
        RETURN 3
    END
    
    SET @DESCRIPCION = UPPER(@DESCRIPCION)

    INSERT INTO [db_alquileres_vehiculos].[negocio].[Tipo_Doc] 
    ( TipoDoc,      Descripcion  ) VALUES 
    ( @TIPO_DOC,    @DESCRIPCION )
END