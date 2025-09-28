
USE db_alquileres_vehiculos


DECLARE @CLIENTES TABLE 
(
    ID INT IDENTITY(1,1)    PRIMARY KEY,
    TipoDoc                 TINYINT NOT NULL,
    NroDoc                  VARCHAR(8) NOT NULL
)

INSERT INTO @CLIENTES(TipoDoc, NroDoc)
SELECT TipoDoc, NroDoc
FROM [db_alquileres_vehiculos].[negocio].[Cliente]
DECLARE @SELECTOR_CLIENTE_RND INT = -1 -- SELECCIONAR CLIENTE RANDOM

-- *******************************************************************************************************************
--------- TEST 3 - Cliente hace un alquiler de 3 vehiculos (MAXIMO POSIBLE) ----------------------------------

BEGIN TRANSACTION T_TEST3
BEGIN TRY

    EXEC @SELECTOR_CLIENTE_RND = [db_utils].[library].[sp_Str_Number_Random] 1, 9, 3, NULL

    DECLARE @TIPO_DOC_TEST3 TINYINT        = (SELECT TipoDoc FROM @CLIENTES WHERE ID =  @SELECTOR_CLIENTE_RND)
    DECLARE @NRO_DOC_TEST3 VARCHAR(8)      = (SELECT NroDoc FROM @CLIENTES WHERE ID =  @SELECTOR_CLIENTE_RND)

    DECLARE @TIPO_VEH_TEST3 TINYINT     = 2 -- AUTOS
    DECLARE @F_ALQ_TEST3    DATE        = '2025-09-25' -- FECHA ANTERIOR A LA ACTUAL - correcta

    DECLARE @RES_TEST3      INT         = -1          
    DECLARE @CANT_ALQ_T3    INT         = 0

    WHILE @CANT_ALQ_T3 < 3
    BEGIN
        PRINT('ENTRA') 
        -- GENERAR EL ALQUILER
        EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 
        @TIPO_DOC_TEST3, @NRO_DOC_TEST3, @TIPO_VEH_TEST3, @F_ALQ_TEST3, @RES_TEST3 OUTPUT

        --IF @RES_TEST2 <> 1
          --  ROLLBACK
        -- GENERAR EL CODIGO DE FACTURA
        DECLARE @CF_TEST3 CHAR(10)
        EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Codigo_Factura] @CF_TEST3 OUTPUT

        -- GENERAR LA FACTURA
        EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 
        @TIPO_DOC_TEST3, @NRO_DOC_TEST3, @F_ALQ_TEST3, @CF_TEST3,  @RES_TEST3 OUTPUT

        SET @CANT_ALQ_T3 = @CANT_ALQ_T3 + 1
    END

    SELECT 
        CASE @RES_TEST3
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    COMMIT TRANSACTION T_TEST3
END TRY 
BEGIN CATCH
SELECT 
        CASE @RES_TEST3
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    ROLLBACK TRANSACTION T_TEST3
END CATCH


-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Alquiler]
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
/* 
SELECT CODIGO_FACTURA, FECHA_FACTURA, TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRE_CLIENTE, APELLIDO_CLIENTE, TIPO_VEHICULO, MEDIO_PAGO, MONTO_TOTAL, ESTADO_ALQUILER,
    COUNT(CODIGO_FACTURA) OVER(PARTITION BY CODIGO_FACTURA) AS CANTIDAD_VEHICULOS
FROM [db_alquileres_vehiculos].[negocio].[vw_Todos_Alquileres] 
ORDER BY CODIGO_FACTURA
*/