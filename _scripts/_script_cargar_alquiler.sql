USE db_alquileres_vehiculos


--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]


EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '71820677', 1, '2025-09-21', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 2, '24256941', 2, '2025-09-21', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '71820677', 2, '2025-09-21', NULL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 1, '66758802', 2, '2025-09-21', NULL 

EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 1, '71820677', 1, '2025-09-21', NULL
EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 1, '71820677', 2, '2025-09-21', NULL

EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 1, '66758802', 2, '2025-09-21', NULL
EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 2, '24256941', 2, '2025-09-21', NULL

--EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 'F576085646', NULL


--SELECT *  FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Pagados] 