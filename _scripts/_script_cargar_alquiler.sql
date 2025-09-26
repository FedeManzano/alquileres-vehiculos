USE db_alquileres_vehiculos


--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]


EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '46475850', 1, '2025-09-22', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '46475850', 2, '2025-09-21', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '46475850', 1, '2025-09-21', NULL

EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 1, '46475850', '2025-09-21', NULL



--EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 'F576085646', NULL


--SELECT *  FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Reservados] 