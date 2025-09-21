USE db_alquileres_vehiculos

IF NOT EXISTS 
(
    SELECT 1 -- Columnas

    FROM    INFORMATION_SCHEMA.TABLES -- Nombre Tabla
    
    -- Condiciones / Filtros
    WHERE   TABLE_SCHEMA = 'negocio' AND 
            TABLE_NAME   = 'Cliente' 
) -- FIN CONDICIÓN

BEGIN -- COMIENZO DEL CUERPO IF
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Cliente] 
    (
    --  Nombre      Tipo         Restricción
        TipoDoc     TINYINT      NOT NULL,
        NroDoc      VARCHAR(8)   NOT NULL,
        Nombre      VARCHAR(30)  NOT NULL,
        Apellido    VARCHAR(30)  NOT NULL,
        Direccion   VARCHAR(100) NOT NULL,
        FNac        DATE         NOT NULL,
        Telefono    CHAR(14)

        CONSTRAINT PK_Cliente 
            PRIMARY KEY(TipoDoc, NroDoc),

        CONSTRAINT FK_Tipo_Doc FOREIGN KEY(TipoDoc) REFERENCES  
            [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Doc] (TipoDoc)
    );
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Cliente] Ya existe en la BD: db_alquileres_vehiculos')


DECLARE @N_BD         NVARCHAR(100) = N'db_alquileres_vehiculos'
DECLARE @N_SCH        NVARCHAR(100) = N'negocio'
DECLARE @N_TABLA      NVARCHAR(100) = N'Tipo_Doc'
DECLARE @N_CAMPO      NVARCHAR(100) = N'TipoDoc'
DECLARE @PARAMETRO    INT           = 1 


DECLARE @SQL_QUERY NVARCHAR(MAX) = 
'SELECT 1 
 FROM ' + QUOTENAME(@N_BD,    '[]')   + '.' + 
          QUOTENAME(@N_SCH,   '[]')   + '.' +
          QUOTENAME(@N_TABLA, '[]')   + ' '  +
'WHERE ' + @N_CAMPO + ' = ' + CAST(@PARAMETRO AS NVARCHAR(10)) 

EXEC(@SQL_QUERY)




SET @N_BD        = N'db_alquileres_vehiculos'
SET @N_BD        = N'db_alquileres_vehiculos'
SET @N_SCH       = N'negocio'
SET @N_TABLA     = N'Cliente'
SET @N_CAMPO     = N'NroDoc'
SET @PARAMETRO   = N'32595830'

SET @SQL_QUERY = 
'SELECT 1 
 FROM ' + QUOTENAME(@N_BD,    '[]')   + '.' + 
          QUOTENAME(@N_SCH,   '[]')   + '.' +
          QUOTENAME(@N_TABLA, '[]')   + ' '  +
'WHERE ' + @N_CAMPO + ' = ' + CAST(@PARAMETRO AS NVARCHAR(10)) 