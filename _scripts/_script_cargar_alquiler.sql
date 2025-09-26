USE db_alquileres_vehiculos


SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler]
1, -- Tipo Doc Cliente
'47727317', -- Nro Doc Cliente
1, -- ID Vehiculo
'2024-06-20', -- Fecha Alquiler
NULL -- Resultado (output)

EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler]
1, -- Tipo Doc Cliente
'47727317', -- Nro Doc Cliente
1, -- ID Vehiculo
'2024-06-20', -- Fecha Alquiler
NULL -- Resultado (output)


SELECT * FROM [db_alquileres_vehiculos].[negocio].[Alquiler]