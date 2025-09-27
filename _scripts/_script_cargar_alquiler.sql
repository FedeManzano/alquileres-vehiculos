USE db_alquileres_vehiculos


--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]



EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '74218441', 2, '2025-09-21', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '74218442', 2, '2025-09-21', NULL
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '74218442', 1, '2025-09-21', NULL
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '74218442', 1, '2025-09-21', NULL

-- CREAR EL COD FACT
DECLARE @CF CHAR(10)
EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Codigo_Factura] @CF OUTPUT


EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 1, '74218442', '2025-09-21', @CF,  NULL



--EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 'F326314175', NULL


--SELECT *  FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
--SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Pagados] 