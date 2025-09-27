
/**
    Script para eliminar la base de datos y todo su contenido.
    Útil para reiniciar el entorno de pruebas.
    Autor: Federico M. (2024)
*/


USE db_alquileres_peliculas
-- Cambiar al contexto de la base de datos
-- Si la base de datos no existe, se puede omitir este paso
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Adicional];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Entrega];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Alquiler];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Vehiculo];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Empleado];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Cliente];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Agencia];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Tipo_Doc];
DROP TABLE IF EXISTS [db_alquileres_vehiculos].[negocio].[Garaje];
DROP SCHEMA IF EXISTS negocio;
DROP SCHEMA IF EXISTS test;     
DROP DATABASE IF EXISTS db_alquileres_vehiculos; 