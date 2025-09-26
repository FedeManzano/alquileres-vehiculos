USE db_alquileres_vehiculos


SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler]
1, -- Tipo Doc Cliente
'43570921', -- Nro Doc Cliente
1, -- ID Vehiculo
'2024-06-20', -- Fecha Alquiler
NULL -- Resultado (output)

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler]
1, -- Tipo Doc Cliente
'43570921', -- Nro Doc Cliente
1, -- ID Vehiculo
'2024-06-20', -- Fecha Alquiler
NULL -- Resultado (output)


EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 
1,
'43570921',
1,
'2024-06-20',
NULL

EXEC [db_alquileres_vehiculos].[negocio].[sp_Registar_Pago] 'F723128373', NULL


SELECT * FROM [db_alquileres_vehiculos].[negocio].[vw_Alquileres_Reservados] 