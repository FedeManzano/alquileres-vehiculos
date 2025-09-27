USE db_alquileres_vehiculos


--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '68338079', 2, '2025-09-21', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '68338079', 1, '2025-09-21', NULL
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '68338079', 1, '2025-09-23', NULL
-- EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '22527701', 1, '2025-09-21', NULL

-- CREAR EL COD FACT
DECLARE @CF CHAR(10)
EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Codigo_Factura] @CF OUTPUT

EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 1, '68338079', '2025-09-21', @CF,  NULL
EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 'F262918572', NULL

SELECT *
FROM [db_alquileres_vehiculos].[negocio].[Factura] 
/*
SELECT NroAlquiler, TipoDoc, NroDoc, ID_T_Vehiculo, Estado, FAlq, CodFactura,
COUNT(*) OVER (PARTITION BY CodFactura) AS CANT_AUTOS_POR_ALQUILER 
FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 

SELECT CodFactura,TipoDoc,NroDoc, COUNT(*) CANT_TIPOS_ALQUILADOS
FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
GROUP BY CodFactura, NroDoc, TipoDoc
*/

--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
--SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Pagados] 