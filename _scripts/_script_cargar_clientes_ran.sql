
USE db_alquileres_vehiculos


/**
    Script para cargar datos de clientes de manera aleatoria en la base de datos.
    Utiliza procedimientos almacenados y funciones para generar datos válidos.
    Autor: Federico M. (2024)
*/


-- Variables para almacenar datos generados
DECLARE @T_DOC          TINYINT,
        @NRO_DOC        VARCHAR(8),
        @NOMBRE         VARCHAR(30),
        @APELLIDO       VARCHAR(30),
        @DIRECCION      VARCHAR(100),
        @EMAIL          VARCHAR(100),
        @FNAC           DATE,
        @TEL            VARCHAR(50),
        @MEDIO_PAGO     TINYINT,
        @ESTADO         TINYINT

-- Contador para la cantidad de clientes a generar
DECLARE @CANTIDAD_CLIENTES INT = 0

-- Tabla temporal para almacenar tipos de documentos existentes
DECLARE @TIPO_DOC_TABLA TABLE (TipoDoc TINYINT)

-- Cargar tipos de documentos existentes en la tabla temporal
INSERT INTO @TIPO_DOC_TABLA (TipoDoc)
SELECT TipoDoc
FROM [db_alquileres_vehiculos].[negocio].[Tipo_Doc]

-- Bucle para generar e insertar clientes hasta alcanzar la cantidad deseada
DECLARE @RAND_T_DOC INT = 0

--  Generar 1000 clientes aleatorios
WHILE  @CANTIDAD_CLIENTES < 1000
BEGIN 

    -- Seleccionar un tipo de documento aleatorio de los existentes
    EXEC @RAND_T_DOC = [db_utils].[library].[sp_Str_Number_Random] 1, 3, 1, NULL
    
    --  Asegurarse de que el tipo de documento seleccionado existe
    SET @T_DOC = 
    (
        SELECT TipoDoc 
        FROM @TIPO_DOC_TABLA 
        WHERE TipoDoc = @RAND_T_DOC
    )

    -- Generar datos aleatorios para el cliente
    EXEC [db_utils].[library].[sp_Generate_Valid_DNI]                @NRO_DOC OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    1,     @NOMBRE OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    1,     @APELLIDO OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    1,     @DIRECCION OUTPUT

    EXEC @MEDIO_PAGO = [db_utils].[library].[sp_Str_Number_Random]  1, 5, 1, NULL

    --  Variables auxiliares para construir datos compuestos
    DECLARE @NRO_HOGAR CHAR(4) = ''

    --  Generar datos adicionales para completar la información del cliente
    EXEC [db_utils].[library].[sp_Str_Number_Random]    1,    4,    4,    @NRO_HOGAR OUTPUT
    EXEC [db_utils].[library].[sp_Str_Number_Random]    0,    9,   13,    @TEL OUTPUT
    EXEC [db_utils].[library].[sp_Str_letter_Random]    8,    0,          @EMAIL OUTPUT
    EXEC [db_utils].[library].[sp_Date_Random]      '1980-01-01',   4,    @FNAC OUTPUT


    -- Construir datos compuestos
    DECLARE @DIR_ENTERA VARCHAR(150) =      @DIRECCION + ' ' + @NRO_HOGAR
    DECLARE @EMAIL_ENTERO VARCHAR(150) =    @EMAIL      + '@mail.com'  
    
    -- Insertar el cliente generado utilizando el procedimiento almacenado
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Cliente]
        @T_DOC,
        @NRO_DOC,
        @NOMBRE,
        @APELLIDO,
        @DIR_ENTERA,
        @EMAIL_ENTERO,
        @FNAC,
        @TEL,
        @MEDIO_PAGO,
        1,  -- Estado: 1 (Activo)
        NULL

    -- Incrementar el contador de clientes generados
    SET @CANTIDAD_CLIENTES = @CANTIDAD_CLIENTES + 1
END

--DELETE FROM [db_alquileres_vehiculos].[negocio].[Cliente]

-- Verificación de datos cargados
SELECT Descripcion, NroDoc, Nombre, Apellido, Email, FNac, Telefono, Direccion, MedioPago , Estado
FROM [db_alquileres_vehiculos].[negocio].[Cliente] 
INNER JOIN [db_alquileres_vehiculos].[negocio].[Tipo_Doc] 
ON Cliente.TipoDoc = Tipo_Doc.TipoDoc

