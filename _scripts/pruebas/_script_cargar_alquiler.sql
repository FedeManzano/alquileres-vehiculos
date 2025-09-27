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

--- TEST ALQUILERES DE VEHÍCULOS ----------------------------------------------------------------------------------

--------- TEST 1 Cliente hace un alquiler y queda la factura sin pagar -----------------------------------------------

BEGIN TRANSACTION T_TEST_1
BEGIN TRY 
    
    DECLARE @TIPO_DOC_TEST1 TINYINT     = 2 
    DECLARE @NRO_DOC_TEST1  VARCHAR(8)  = 
    (
        SELECT TOP(1) NroDoc
        FROM [db_alquileres_vehiculos].[negocio].[Cliente]
        WHERE TipoDoc = @TIPO_DOC_TEST1
    ) 

   -- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente] WHERE TipoDoc = 2 AND NroDoc = @NRO_DOC_TEST1

    DECLARE @TIPO_VEH_TEST1 TINYINT     = 1 -- AUTOS
    DECLARE @F_ALQ_TEST1    DATE        = '2025-09-25' -- FECHA ANTERIOR A LA ACTUAL - correcta

    DECLARE @RES_TEST1      INT         = -1        

    EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 
    @TIPO_DOC_TEST1, @NRO_DOC_TEST1, @TIPO_VEH_TEST1, @F_ALQ_TEST1, @RES_TEST1 OUTPUT

    IF @RES_TEST1 <> 1
        ROLLBACK

    DECLARE @CF_TEST1 CHAR(10)
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Codigo_Factura] @CF_TEST1 OUTPUT

    EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 
    @TIPO_DOC_TEST1, @NRO_DOC_TEST1, @F_ALQ_TEST1, @CF_TEST1,  @RES_TEST1 OUTPUT

    SELECT 
        CASE @RES_TEST1 
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    COMMIT TRANSACTION T_TEST1 

END TRY
BEGIN CATCH
        SELECT CASE @RES_TEST1 
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    ROLLBACK TRANSACTION T_TEST1
END CATCH

-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Alquiler]
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
-- SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Pagados]


-- *************************************************************************************************************
---------------------------- FIN TEST 1 ------------------------------------------------------------------------
-- *************************************************************************************************************