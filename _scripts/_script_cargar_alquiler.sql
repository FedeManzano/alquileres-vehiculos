USE db_alquileres_vehiculos


--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler]
3, -- Tipo Doc Cliente
'56978063', -- Nro Doc Cliente
1, -- ID Vehiculo
'2024-06-20', -- Fecha Alquiler
NULL -- Resultado (output)

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler]
3, -- Tipo Doc Cliente
'56978063', -- Nro Doc Cliente
2, -- ID Vehiculo
'2024-06-20', -- Fecha Alquiler
NULL -- Resultado (output)


EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 
3,
'56978063',
1,
'2024-06-20',
NULL

--EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 'F576941227', NULL


--SELECT *  FROM [db_alquileres_vehiculos].[negocio].[Alquiler] 
--SELECT * FROM [db_alquileres_vehiculos].[negocio].[Factura] 
SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Pagados] 