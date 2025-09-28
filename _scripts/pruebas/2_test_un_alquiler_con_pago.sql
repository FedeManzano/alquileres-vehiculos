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
--------- TEST 2 Cliente hace un alquiler y queda la factura con el pago -----------------------------------------------

BEGIN TRANSACTION T_TEST2
BEGIN TRY
    EXEC @SELECTOR_CLIENTE_RND = [db_utils].[library].[sp_Str_Number_Random] 1, 9, 3, NULL

    DECLARE @TIPO_DOC_TEST2 TINYINT        = (SELECT TipoDoc FROM @CLIENTES WHERE ID =  @SELECTOR_CLIENTE_RND)
    DECLARE @NRO_DOC_TEST2 VARCHAR(8)      = (SELECT NroDoc FROM @CLIENTES WHERE ID =  @SELECTOR_CLIENTE_RND)

    DECLARE @TIPO_VEH_TEST2 TINYINT     = 2 -- AUTOS
    DECLARE @F_ALQ_TEST2    DATE        = '2025-09-25' -- FECHA ANTERIOR A LA ACTUAL - correcta

    DECLARE @RES_TEST2      INT         = -1          

    -- GENERAR EL ALQUILER
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 
    @TIPO_DOC_TEST2, @NRO_DOC_TEST2, @TIPO_VEH_TEST2, @F_ALQ_TEST2, @RES_TEST2 OUTPUT

    IF @RES_TEST2 <> 1
        ROLLBACK
    -- GENERAR EL CODIGO DE FACTURA
    DECLARE @CF_TEST2 CHAR(10)
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Codigo_Factura] @CF_TEST2 OUTPUT

    -- GENERAR LA FACTURA
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 
    @TIPO_DOC_TEST2, @NRO_DOC_TEST2, @F_ALQ_TEST2, @CF_TEST2,  @RES_TEST2 OUTPUT

    -- PAGAR LA FACTURA
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 
    @CF_TEST2, @RES_TEST2 OUTPUT

    SELECT 
        CASE @RES_TEST2 
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    COMMIT TRANSACTION T_TEST2 
END TRY 
BEGIN CATCH
SELECT 
        CASE @RES_TEST2
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    ROLLBACK TRANSACTION T_TEST2
END CATCH


-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Alquiler]
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Pagados]