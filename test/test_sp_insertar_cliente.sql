USE db_alquileres_vehiculos
SET NOCOUNT ON

/***
    TEST 1
    INGRESO NORMAL, TODOS LOS DATOS CORRECTOS
    EL REGISTRO SE DEBE INSETAR CORRECTAMENTE

    ESP= 1 <=> OBT = 1 
*/
DECLARE @ESPERADO INT = 1
DECLARE @OBTENIDO INT = -1

EXEC 
[db_alquileres_vehiculos].[negocio].[sp_Insertar_Cliente] 1, 
'32595830', 
'Federico', 
'Manzano', 
'B. Frione 4680 Ciudadela', 
'federico@gmail.com',  
'1987-01-03',
'5401146547521',
@OBTENIDO OUTPUT

EXEC [db_utils].[library].[sp_Assert_Equals] 1,'Normal, Ingreso Correcto',@ESPERADO, @OBTENIDO, NULL

-----------------------------------------------------------------------------------------------------------------------


/***
    TEST 2
    INGRESO NORMAL, NORMALIZACIÓN DE DATOS
    EL REGISTRO SE DEBE INSETAR CORRECTAMENTE

    ESP= 1 <=> OBT = 1 
*/

SET @ESPERADO = 1
SET @OBTENIDO = 1

EXEC
[db_alquileres_vehiculos].[negocio].[sp_Insertar_Cliente] 
    1, 
    '25111333', 
    'marcos', 
    'alfonso', 
    'rivadavia 5000, primera junta', 
    'marcos@gmail.com',  
    '1987-05-03',
    '5401146547552',
    @ESPERADO OUTPUT

EXEC [db_utils].[library].[sp_Assert_Equals] 2,'Normal, Normalización de datos',@ESPERADO, @OBTENIDO, NULL
--------------------------------------------------------------------------------------------------------------------
/***
    TEST 3
    INGRESO FALLIDO, CARACTER ESPECIAL EN EL APELLIDO
    EL REGISTRO NO SE DEBE INSETAR

    ESP = -1 <=> OBT = -1
*/

SET @ESPERADO = -1
SET @OBTENIDO = -1

EXEC 
[db_alquileres_vehiculos].[negocio].[sp_Insertar_Cliente] 1, 
'23111222', 
'marcos', 
'alfo*nso', 
'rivadavia 5000, primera junta', 
'alberto@gmail.com',  
'1987-05-03',
'5401146547552',
@OBTENIDO OUTPUT

EXEC [db_utils].[library].[sp_Assert_Equals] 3,'Fallido, Caracter especial en el apellido',@ESPERADO, @OBTENIDO, NULL

---------------------------------------------------------------------------------------------------------------------

/***
    TEST 4
    INGRESO FALLIDO, CARACTER ESPECIAL EN EL NOMBRE
    EL REGISTRO NO SE DEBE INSETAR

    ESP = -1 <=> OBT = -1
*/

SET @ESPERADO = -1
SET @OBTENIDO = -1

EXEC 
[db_alquileres_vehiculos].[negocio].[sp_Insertar_Cliente] 1, 
'23111222', 
'marc+os', 
'alfonso', 
'rivadavia 5000, primera junta', 
'alberto@gmail.com',  
'1987-05-03',
'5401146547552',
@OBTENIDO OUTPUT

EXEC [db_utils].[library].[sp_Assert_Equals] 4,'Fallido, Caracter especial en el NOMBRE',@ESPERADO, @OBTENIDO, NULL



SELECT * FROM [db_alquileres_vehiculos].[negocio].[Cliente]
DELETE FROM [db_alquileres_vehiculos].[negocio].[Cliente]