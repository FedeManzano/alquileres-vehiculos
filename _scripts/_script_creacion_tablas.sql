/**
    * Script de creación de tablas para la base de datos de alquileres de vehículos.
    * Autor: Federico M.
    * Fecha: 2024-01-01
*/

USE db_alquileres_vehiculos


----------------------------- ******* CREACIÓN DE TABLAS ******* ---------------------------------- 
---------------------------------------------------------------------------------------------------

-- CREACION DE LA TABLA TIPO_DOC ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME    = 'Tipo_Doc'   AND
          TABLE_SCHEMA  = 'negocio'
)
BEGIN 
    -- CREACIÓN DE LA TABLA TIPO_DOC
    CREATE TABLE    [db_alquileres_vehiculos].[negocio].[Tipo_Doc] 
    (
    --  NOMBRE        TIPO        RESTRCCIÓN 
        TipoDoc       TINYINT     PRIMARY KEY NONCLUSTERED,
        Descripcion   VARCHAR(3)  NOT NULL,

        -- RESTRICCIÓN CK Pra la descripción del 
        -- TipoDoc
        CONSTRAINT CK_Desc_Tipo_Doc CHECK 
        (
            Descripcion     =    'DNI'  OR
            Descripcion     =    'LC'   OR
            Descripcion     =    'PAS'              
        )
    )

    -- LOTE DE PRUEBA CON LOS TRES VALORES POSIBLES
    INSERT INTO     [db_alquileres_vehiculos].
                    [negocio].
                    [Tipo_Doc] 
                    ( TipoDoc, Descripcion ) VALUES 
                    ( 1,      'DNI'        ),
                    ( 2,      'LC'         ),
                    ( 3,      'PAS'        )                    
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Tipo_Doc] Ya existe en la BD: db_alquileres_vehiculos')



-- CREACION DE LA TABLA TIPO_VEHICULO ------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'Tipo_Vehiculo'
      AND TABLE_SCHEMA = 'negocio'
)
BEGIN
    -- Crear la tabla Tipo_Vehiculo con sus campos y restricciones
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] (
    --  CAMPO             TIPO_DATO     RESTRICCIÓN
        ID_Tipo_Vehiculo  SMALLINT      PRIMARY KEY,
        Nombre            VARCHAR(15)   NOT NULL,
        -- Restricción CHECK
        CONSTRAINT CK_Nombre_Vehiculo CHECK (
            Nombre = 'AUTOMOVIL' OR
            Nombre = 'CAMIONETA'
        )
    );

    INSERT INTO [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] 
        (ID_Tipo_Vehiculo, Nombre) VALUES
        (1, 'AUTOMOVIL'),
        (2, 'CAMIONETA');
END
ELSE
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Tipo_Vehiculo] Ya existe en la BD: db_alquileres_vehiculos')


-- CREACION DE LA TABLA MEDIO_PAGO ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Medio_Pago' AND
            TABLE_SCHEMA    = 'negocio'
)
BEGIN 
    -- Crear la tabla Medio_Pago con sus campos y restricciones
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Medio_Pago] (
    --  NOMBRE              TOPO            RESTRICCIÓN
        ID_Medio_Pago       TINYINT         PRIMARY KEY,
        Descripcion         VARCHAR(30)     NOT NULL,

        CONSTRAINT CK_Descripcion_Medio_Pago CHECK (
            LEN(Descripcion) > 0 AND LEN(Descripcion) <= 30
        )
    );

    INSERT INTO [db_alquileres_vehiculos].[negocio].[Medio_Pago] 
    (   ID_Medio_Pago,     Descripcion             ) VALUES
    (   1,                 'Efectivo'              ),
    (   2,                 'Tarjeta de Crédito'    ),
    (   3,                 'Tarjeta de Débito'     ),
    (   4,                 'Transferencia Bancaria'),
    (   5,                 'Mercado Pago'          )
END ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Medio_Pago] Ya existe en la BD: db_alquileres_vehiculos')

-- CREACION DE LA TABLA GARAJE ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Garaje'       AND 
            TABLE_SCHEMA    = 'negocio'  
)
BEGIN 
    CREATE TABLE  [db_alquileres_vehiculos].[negocio].[Garaje]
    (
    --  NOMBRE         TIPO         RESTRICCIÓN 
        ID_Garaje      SMALLINT     IDENTITY(1,1) PRIMARY KEY,
        Direccion      VARCHAR(100) NOT NULL,
        Capacidad      SMALLINT     NOT NULL,
        Ocupados       SMALLINT     NOT NULL
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Garaje] Ya existe en la BD: db_alquileres_vehiculos')

-- CREACION DE LA TABLA FACTURA ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT  1
    FROM    INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME      = 'Factura' AND
            TABLE_SCHEMA    = 'negocio'
)   
BEGIN 

    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Factura] (
    --  NOMBRE              TOPO            RESTRICCIÓN
        CodFactura          CHAR(10)        PRIMARY KEY,
        FechaFactura        DATETIME        NOT NULL,
        MontoTotal          DECIMAL(10,2)   NOT NULL,

    
        ------------- ****** RESTRICCIONES CHECK ******* --------------------------------
        -- RESTRICCIONES CHECK El codigo de factura debe tener el formato 'F000000000' 
        -- y ser de longitud 10
        CONSTRAINT CK_CodFactura_Factura CHECK (
            LEN(CodFactura) = 10 AND 
            CodFactura LIKE 'F[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),

        -- RESTRICCIONES CHECK El monto total debe ser mayor o igual a 0
        CONSTRAINT CK_MontoTotal_Factura CHECK (
            MontoTotal >= 0
        ),

        -- RESTRICCIONES CHECK La fecha de la factura no puede ser futura   
        -- Usamos TRY_CONVERT para asegurarnos que la fecha es válida
        CONSTRAINT CK_FechaFactura_Factura CHECK (
            CASE 
                WHEN TRY_CONVERT(DATE, FechaFactura) IS NOT NULL 
                THEN 1 
                ELSE 0
            END = 1 AND
            FechaFactura <= GETDATE() -- La fecha no puede ser futura    
        )
    );
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Factura] Ya existe en la BD: db_alquileres_vehiculos');

-- CREACION DE LA TABLA AGENCIA ------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME    = 'Agencia'  AND
            TABLE_SCHEMA  = 'negocio'  
)
BEGIN
    -- Crear la tabla Agencia con sus campos y restricciones
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Agencia] (
        
    --  NOMBRECAMPO     TIPO            RESTRICCIÓN
        CuitAgencia     VARCHAR(11)     PRIMARY KEY, -- Formato: XX-XXXXXXXX-X
        Correo          VARCHAR(100)    UNIQUE, -- Puede ser NULL
        Nombre          VARCHAR(30)     NOT NULL, -- Nombre de la agencia
        Telefono        VARCHAR(20),    -- Puede ser NULL
        Direccion       VARCHAR(100)    NOT NULL -- Dirección física de la agencia
    );
END
ELSE
    -- Si la tabla ya existe, mostrar un mensaje informativo
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Agencia] Ya existe en la BD: db_alquileres_vehiculos')

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
        Email       VARCHAR(100) UNIQUE,
        FNac        DATE         NOT NULL,
        Telefono    CHAR(14),
        MedioPago   TINYINT      NOT NULL,

        ----------------- ******* RESTRICCIONES ******* -----------------
        CONSTRAINT PK_Cliente 
            PRIMARY KEY NONCLUSTERED (TipoDoc, NroDoc),

        ----------------- ******* RESTRICCIONES ******* -----------------
        CONSTRAINT FK_Tipo_Doc FOREIGN KEY(TipoDoc) REFERENCES  
            [db_alquileres_vehiculos].
            [negocio].
            [Tipo_Doc] (TipoDoc),
        CONSTRAINT FK_Medio_Pago FOREIGN KEY(MedioPago) REFERENCES  
            [db_alquileres_vehiculos].[negocio].[Medio_Pago] (ID_Medio_Pago),
            
        CONSTRAINT CK_Cliente_NroDoc CHECK
        (
            LEN(NroDoc) = 8 AND
            NroDoc LIKE '[1-7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),

        CONSTRAINT CK_Cliente_Fecha_Nac CHECK
        (
            CASE  
                WHEN TRY_CONVERT(DATE, FNac) IS NOT NULL 
                AND FNac < GETDATE() THEN 1
                ELSE 0
            END = 1
        ),
    )
END 
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Cliente] Ya existe en la BD: db_alquileres_vehiculos')

-- CREACION DE LA TABLA EMPLEADO ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Empleado'  AND
            TABLE_SCHEMA  = 'negocio'   
) -- FIN CONDICIÓN
BEGIN -- COMIENZO DEL CUERPO IF 
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Empleado] (
                    
    --  Nombre          Tipo            Restricción
        Legajo          INT             IDENTITY(1,1) PRIMARY KEY,
        Nombre          VARCHAR(30)     NOT NULL,
        Apellido        VARCHAR(30)     NOT NULL,  
        Email           VARCHAR(100)    UNIQUE,
        CuitAgencia     VARCHAR(11)     NOT NULL,

        CONSTRAINT FK_Cuit_Agencia FOREIGN KEY (CuitAgencia) REFERENCES 
            [db_alquileres_vehiculos].
            [negocio].
            [Agencia] (CuitAgencia),
        
        CONSTRAINT CK_Empleado_Email CHECK
        (
            Email IS NULL OR
            Email LIKE '%_@__%.__%'
        ),

        CONSTRAINT CK_Empleado_Nombre CHECK
        (
            LEN(Nombre) > 0 AND LEN(Nombre) <= 30
            AND Nombre NOT LIKE '%[^a-zA-Z ]%'
        ),

        CONSTRAINT CK_Empleado_Apellido CHECK
        (
            LEN(Apellido) > 0 AND LEN(Apellido) <= 30
            AND Apellido NOT LIKE '%[^a-zA-Z ]%'
        ),
    )
END 
ELSE
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Empleado] NO existe en la BD: db_alquileres_vehiculos')

-- CREACION DE LA TABLA ALQUILER ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Alquiler'  AND
            TABLE_SCHEMA  = 'negocio'   
)
BEGIN 
    -- Crear la tabla Alquiler con sus campos y restricciones
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Alquiler] 
    (
    --  CAMPO           TIPO            RESTRCCIÓN
        C_Alquiler      CHAR(10)        NOT NULL,   -- Formato: AQL-0000001
        TipoDoc         TINYINT         NOT NULL,   -- Referencia a Tipo_Doc
        NroDoc          VARCHAR(8)      NOT NULL,   -- Número de documento del cliente
        ID_T_Vehiculo   SMALLINT        NOT NULL,   -- Referencia a Tipo_Vehiculo
        Estado          TINYINT         NOT NULL,   -- 0: Activo, 1: Finalizado, 2: Cancelado
        FAlq            DATE            NOT NULL,   -- Fecha de alquiler
        CodFactura      CHAR(10),                   -- Referencia a Factura

        -- RESTRCCIÓN PRIMARY KEY
        -- Clave primaria compuesta
        CONSTRAINT PK_Alquiler PRIMARY KEY 
        (
            C_Alquiler,
            TipoDoc,
            NroDoc,
            ID_T_Vehiculo
        ),
        

        -- Restricción check FK (TipoDoc, NroDoc) De Cliente
        CONSTRAINT  FK_Alquiler_Doc 
        FOREIGN KEY (TipoDoc, NroDoc) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Cliente] 
                    (TipoDoc, NroDoc),

        -- Restricción check FK ID_T_Vehiculo De Tipo_Vehiculo  
        CONSTRAINT FK_Alquiler_Tipo_Vehiculo FOREIGN KEY (ID_T_Vehiculo) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Tipo_Vehiculo] 
                    (ID_Tipo_Vehiculo),

        -- Restricción check FK CodFactura De Factura
        CONSTRAINT FK_Alquiler_Factura FOREIGN KEY (CodFactura) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Factura] 
                    (CodFactura),
        
        -- ESTADO_AQL 1 / 2 / 3 Valores posibles
        CONSTRAINT CK_Estado_Alquiler CHECK
        (
            Estado = 0 OR -- Reservado
            Estado = 1 OR -- Pagado
            Estado = 2 OR -- Retirados
            Estado = 4 OR -- Cancelado
            Estado = 5 OR -- Devuelto
            Estado = 6    -- Retrasado
        ),

        -- FECHAAQL CK Validación de fecha
        CONSTRAINT CK_FechaAlq_Alquiler CHECK 
        (
             CASE  
                WHEN TRY_CONVERT(DATE, FAlq) IS NOT NULL THEN 1
                ELSE 0
            END = 1
        ),
    );

    -- Índices para optimizar consultas frecuentes
    CREATE INDEX IX_Fecha_Alquiler ON [db_alquileres_vehiculos].[negocio].[Alquiler](FAlq)

    --  Índice para consultas por estado
    CREATE INDEX IX_Estado_Alquiler ON [db_alquileres_vehiculos].[negocio].[Alquiler](Estado)
END
ELSE PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Alquiler] Ya existe en la BD: db_alquileres_vehiculos')

--- CREACION DE LA TABLA ADICIONAL ------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_NAME    = 'Adicional'  AND
            TABLE_SCHEMA  = 'negocio'   
)
BEGIN 
    CREATE TABLE [db_alquileres_vehiculos].[negocio].[Adicional] (
    --  CAMPO           TIPO            RESTRICCIÓN
        ID_Adicional    SMALLINT        IDENTITY(1,1) PRIMARY KEY,
        CodFacutura     CHAR(10)        NOT NULL,
        Monto           DECIMAL(10,2)   NOT NULL,
        Descripcion     VARCHAR(100)    NOT NULL,

        -- Restricciones Foraneas
        CONSTRAINT FK_Adicional_Factura FOREIGN KEY (CodFacutura) REFERENCES
            [db_alquileres_vehiculos].[negocio].
            [Factura] (CodFactura),

        -- Restricciones Check
        CONSTRAINT CK_Adicional_Monto CHECK (Monto >= 0)
    )
END
ELSE
    PRINT('La tabla [db_alquileres_vehiculos].[negocio].[Adicional] Ya existe en la BD: db_alquileres_vehiculos')