USE db_alquileres_vehiculos
SET NOCOUNT ON
/****
    VALIDACIONES DEL CLIENTE
    1 - VALIDACIÓN DEL TIPO DE DOCIMENTO (INT) (1,2,3) VALORES POSIBLES
    2 - VALIDACIÓN DEL NRO_DOC (VARCHAR(8))
    TEST: 4, 1,2,3, 0 DOS ACEPTADOS Y DOS ERRONEOS
*/

PRINT('TEST TIPO_DOC ------------------------------------------------------------------------------------')

---- TEST 1 ---------------------------------------------------------------------------------------
DECLARE @ESPERADO INT = 0 -- SE ESPERA UN CERO
DECLARE @OBTENIDO INT = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    4, 
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 1,'Tipo Documento erroneo ( 4 ) no existe',@ESPERADO, @OBTENIDO, NULL

---------------------------------------------------------------------------------------------------------------------

---- TEST 2 ---------------------------------------------------------------------------------------
SET @ESPERADO =  1 -- SE ESPERA UN UNO
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1, -- valor correcto 
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 2,'Tipo Documento ( 1 ) existe',@ESPERADO, @OBTENIDO, NULL

---------------------------------------------------------------------------------------------------------------------

---- TEST 3 ---------------------------------------------------------------------------------------
SET @ESPERADO =  1 -- SE ESPERA UN UNO
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    2, -- valor correcto 
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 3,'Tipo Documento ( 2 ) existe',@ESPERADO, @OBTENIDO, NULL

---------------------------------------------------------------------------------------------------------------------


---- TEST 4 ---------------------------------------------------------------------------------------
SET @ESPERADO =  1 -- SE ESPERA UN UNO
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    3, -- valor correcto 
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 4,'Tipo Documento ( 3 ) existe',@ESPERADO, @OBTENIDO, NULL

---------------------------------------------------------------------------------------------------------------------


---- TEST 5 ---------------------------------------------------------------------------------------
SET @ESPERADO =  0 -- SE ESPERA UN 0
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    0, -- valor correcto 
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 5,'Tipo Documento ( 0 ) existe',@ESPERADO, @OBTENIDO, NULL

---------------------------------------------------------------------------------------------------------------------
PRINT('TEST TIPO_DOC TERMINADO ------------------------------------------------------------------------------------')

PRINT('TEST NRO_DOC ------------------------------------------------------------------------------------')


---- TEST 5 ---------------------------------------------------------------------------------------
SET @ESPERADO =  1 -- SE ESPERA UN 1
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 5,'Nro Documento válido',@ESPERADO, @OBTENIDO, NULL

-------------------------------------------------------------------------------------------------------

---- TEST 6 ---------------------------------------------------------------------------------------
SET @ESPERADO =  2 -- SE ESPERA UN 2
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11111.111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 6,'Nro Documento caracter especial medio',@ESPERADO, @OBTENIDO, NULL


---- TEST 7 ---------------------------------------------------------------------------------------
SET @ESPERADO =  2 -- SE ESPERA UN 2
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '.11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 7,'Nro Documento caracter especial inicio',@ESPERADO, @OBTENIDO, NULL

---- TEST 8 ---------------------------------------------------------------------------------------
SET @ESPERADO =  2 -- SE ESPERA UN 2
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    ' 1111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 8,'Nro Documento espacio inicio',@ESPERADO, @OBTENIDO, NULL


---- TEST 9 ---------------------------------------------------------------------------------------
SET @ESPERADO =  2 -- SE ESPERA UN 2
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11 11111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 9,'Nro Documento espacio medio',@ESPERADO, @OBTENIDO, NULL 


---- TEST 9 ---------------------------------------------------------------------------------------
SET @ESPERADO =  1 -- SE ESPERA UN 1
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11111111', 
    'Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 9,'Nombre válido',@ESPERADO, @OBTENIDO, NULL




---- TEST 10 ---------------------------------------------------------------------------------------
SET @ESPERADO =  4 -- SE ESPERA UN 4
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11111111', 
    'Fede*rico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 10,'Nombre caracter especial medio',@ESPERADO, @OBTENIDO, NULL


---- TEST 11 ---------------------------------------------------------------------------------------
SET @ESPERADO =  4 -- SE ESPERA UN 4
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11111111', 
    'Federico*', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 11,'Nombre caracter especial final',@ESPERADO, @OBTENIDO, NULL



---- TEST 12 ---------------------------------------------------------------------------------------
SET @ESPERADO =  4 -- SE ESPERA UN 4
SET @OBTENIDO = -1

SET @OBTENIDO = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
( 
    1,
    '11111111', 
    '+Federico', 
    'Manzano', 
    'B. Frione 4680 Ciudadela', 
    'federico@gmail.com',  
    '1987-01-03',
    '5401146547521'
)

EXEC [db_utils].[library].[sp_Assert_Equals] 12,'Nombre caracter especial inicio',@ESPERADO, @OBTENIDO, NULL