# Orden y documentación de los elementos

En este apartado se muestra la estructura del proyecto, junto con el orden de creación de los elementos de todos los elementos de la base de datos y la explicación de las funcionalidades que conforman el proyecto.

## Estructura

-  _scripts
    - CreacionDDL
        - _script_creacion_tablas.sql
    - creacionDML
        - _script_cargar_agencias.sql
        - _script_cargar_clientes_ran.sql
        - _script_cargar_empleados.sql
        - _script_cargar_tipos_doc.sql
    - eliminar
        - _script_eliminar_todo.sql
- fn
    - montos
        - fn_calcular_monto_adicionales.sql
        - fn_calcular_monto_alquiler.sql
        - fn_calcular_monto_total.sql
    - ver
        - fn_validar_clientes.sql
- mod
    - der_alquileres.drawio
    - DER.png
    - diagrama-clases.drawio
    - diagrama-clases.png
- portada
    - portada.png
- req
    - requrimientos.doc
- sp
    - facturacion
        - sp_generar_codigo_factura.sql
        - sp_generar_factura.sql
        - sp_registrar_pago.sql
    - insercion
        - sp_insertar_agencia.sql
        - sp_insertar_alquiler.sql
        - sp_insertar_cliente.sql
- tb
    - tb_adicional.sql
    - tb_agencia.sql
    - tb_alquiler.sql
    - tb_cliente.sql
    - tb_empleado.sql
    - tb_entrega.sql
    - tb_factura.sql
    - tb_garage.sql
    - tb_medio_pago.sql
    - tb_tipo_doc.sql
    - tb_tipo_vehiculo.sql
    - tb_vehiculo.sql
- tg
    - tg_dar_de_baja_cliente.sql
- tipología CAPA DE RED
- vw
    - creacion opcional (SIN DEPENDENCIA)

## Orden de creación de elementos

Después de crear la base de datos desde el archivo **main** hay que crear los elementos dispuestos en la base de datos.

### Procedimientos

| Orden   | Path                | Procedimiento              |
|:-------:|------               |---------------             |
| 1       |/sp/insercion        |sp_Insertar_Agencia         |
| 2       |/sp/insercion        |sp_Insertar_Alquiler        |
| 3       |/sp/insercion        |sp_Insertar_Cliente         |
| 4       |/sp/facturacion      |sp_Generar_Codigo_Factura   |
| 5       |/sp/facturacion      |sp_Generar_Factura          |
| 6       |/sp/facturacion      |sp_Registrar_Pago           |

### Funciones

| Orden   | Path                | Funciones                  |
|:-------:|------               |---------------             |
| 1       |/fn/                 |fn_Validar_Cliente          |
| 2       |/fn/montos           |fn_Calcular_Monto_Adicional |
| 3       |/fn/montos           |fn_Calcular_Monto_Alquiler  |
| 4       |/fn/montos           |fn_Calcular_Monto_Total     |

### Script

| Orden   | Path                | Funciones                  |
|:-------:|------               |---------------             |
| 1       |/_scripts/CreacionDDL|_script_creacion_tablas.sql |
| 2       |/_scripts/CreacionDML|_script_cargar_agencia.sql  |
| 3       |/_scripts/CreacionDML|_script_cargar_empleado.sql |
| 4       |/_scripts/CreacionDML|_script_cargar_cliente.sql  |


## Aplicación

En este apartado se describe como utilizar las funcionalidades mencionadas en los partados anteriores.

### sp_Insertar_Agencia

Permite ingresar una agencia a la base de datos.

#### Ejemplo

```SQL 
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Agencia] 
'20325958309', -- CUIT
'agencia1@agencia.com', -- CORREO
'Agencia SRL',-- Nombre o Razón Social
'5401146554444' -- Teléfono
'Siempre Viva 4400' -- Dirección
```

### sp_Insertar_Alquiler

Inserta un alquiler y en el campo factura lo deja con un valor NULL hasta que se realice la misma.

#### Ejemplo

```SQL 
/**
    Mensajes de error según como finalice el procedimiento.

    SET @RES = 0 
    RAISERROR('Tipo de documento inválido',16,1)

    SET @RES = 2
    RAISERROR('Cliente inexistente',16,1)

    SET @RES = 3
    RAISERROR('Tipo de vehículo inválido',16,1)

    SET @RES = 4
    RAISERROR('Fecha de alquiler inválida',16,1)

    SET @RES = 5
    RAISERROR('El cliente tiene vehículos de la companía en su poder, no puede reservar hasta que los devuelva.',16,1)

    SET @RES = 6
    RAISERROR('Como regla de negocio no se permiten tener más de 3 vehículos activos',16,1)

    SET @RES = 7
    RAISERROR('No se permite tener más de un alquiler activo.',16,1)
*/
DECLARE @RES INT = 0
EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 
    1,  -- Tipo de documento (1: DNI, 2: LC, 3: PAS)
    '25444222', -- Nro de documento
    1, -- Tipo de vehículo
    '2025-03-01', -- Fecha del Alquiler
    @RES OUTPUT -- Toma el valor 1 si todo sale bien.
```

#### Ejemplo de como ingresar un alquiler y generar la factura

Para poder llevar a cabo esto es necesario realizar dos operaciones en la base de datos y asegurarse que la integridad 
de los datos almacenados no corra riesgo de perder la integridad, por esta razón ambas operaciones se ejecutan a través de una
transacción.

```SQL 
USE db_alquileres_vehiculos

DECLARE @CLIENTES TABLE  -- Crea una variable del tipo TABLE para almacenar la clave compuesta de c/ cliente.
(
    -- Se establece un ID AUTOINCREMENTAL para poder seleccionar los reg de manera aleatoria.
    ID INT IDENTITY(1,1)    PRIMARY KEY,
    TipoDoc                 TINYINT NOT NULL,
    NroDoc                  VARCHAR(8) NOT NULL
)

-- Se carga la tabla @CLIENTES
INSERT INTO @CLIENTES(TipoDoc, NroDoc)
SELECT TipoDoc, NroDoc
FROM [db_alquileres_vehiculos].[negocio].[Cliente]
DECLARE @SELECTOR_CLIENTE_RND INT = -1 -- SELECCIONAR CLIENTE RANDOM

--- TEST ALQUILERES DE VEHÍCULOS -------------------------------------------------------------------------------------
-- *******************************************************************************************************************
--------- TEST 1 Cliente hace un alquiler y queda la factura sin pagar -----------------------------------------------

BEGIN TRANSACTION T_TEST_1 -- se crea la transacción
BEGIN TRY     

    -- se obtiene un valor random de 0-999 para seleccionar un registro aleatorio
    EXEC @SELECTOR_CLIENTE_RND = [db_utils].[library].[sp_Str_Number_Random] 1, 9, 3, NULL

    -- TipoDoc aleatorio
    DECLARE @TIPO_DOC_TEST1 TINYINT     = (SELECT TipoDoc FROM @CLIENTES WHERE ID =  @SELECTOR_CLIENTE_RND)
    
    -- NroDoc aleatorio
    DECLARE @NRO_DOC_TEST1  VARCHAR(8)  = (SELECT NroDoc FROM @CLIENTES WHERE ID =  @SELECTOR_CLIENTE_RND)

    -- Tipo de vehículo
    DECLARE @TIPO_VEH_TEST1 TINYINT     = 1 -- AUTOS
    
    -- Fecha utilizada en todos los test
    DECLARE @F_ALQ_TEST1    DATE        = '2025-09-25' -- FECHA ANTERIOR A LA ACTUAL - correcta


    DECLARE @RES_TEST1      INT         = -1        

    /**
        Se ejecuta el procedimiento para insertar el alquiler.
    */
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Insertar_Alquiler] 
    @TIPO_DOC_TEST1, @NRO_DOC_TEST1, @TIPO_VEH_TEST1, @F_ALQ_TEST1, @RES_TEST1 OUTPUT

    -- si el alq no se pudo insertar genera el rollback.
    IF @RES_TEST1 <> 1
        ROLLBACK

    -- para poder llevar a cabo el test es necesario un número de factura aleatorio y único.
    DECLARE @CF_TEST1 CHAR(10)

    -- Se genera el CodFactura
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Codigo_Factura] @CF_TEST1 OUTPUT

    /***
        Con el codfactura se genera la factura correspondiente al alquiler.
        Es importante recalcar que, si el mismo cliente realiza reservas de vehículos
        antes de que el alquiler cambie de estado (0: Reservado, 1:Pagado) NO SE 
        GENERA UN NUEVO CODIGO DE FACTURA, sino que se actualiza la actual.
    */
    EXEC [db_alquileres_vehiculos].[negocio].[sp_Generar_Factura] 
    @TIPO_DOC_TEST1, @NRO_DOC_TEST1, @F_ALQ_TEST1, @CF_TEST1,  @RES_TEST1 OUTPUT


    /***
        Si todo sale bien muestra los mensajes aquí descriptos.
    */
    SELECT 
        CASE @RES_TEST1 
            WHEN 0 THEN 'El alquiler ya dispone de factura'
            WHEN 1 THEN 'OK TERMINO BIEN'
            WHEN 2 THEN 'El monto para la fecha solicitada es erroneo'
        END
    COMMIT TRANSACTION T_TEST1 -- Confirma la transacción

END TRY
BEGIN CATCH
    DECLARE @MJE_ERROR  NVARCHAR(100),
            @ESTADO     INT,
            @SEVERIDAD  INT 

    SELECT  @MJE_ERROR  = ERROR_MESSAGE(),
            @ESTADO     = ERROR_SEVERITY(),
            @SEVERIDAD  = ERROR_STATE()
    -- Muestra el mje error y regresa todo hacia atras.
    RAISERROR(@MJE_ERROR, @SEVERIDAD, @ESTADO)
    ROLLBACK TRANSACTION T_TEST1
END CATCH
```

### sp_Insertar_Cliente

Perimite insertar un nuevo cliente, para validar los datos de ingreso se utiliza la función ```fn_Validar_Cliente```.
En el siguiente código se muestran los diferentes errores que pueden ocurrir.
```SQL
USE db_alquileres_vehiculos

/**
    Procedimiento almacenado para insertar un nuevo cliente en la base de datos.
    Realiza validaciones y formatea los datos antes de la inserción.    
    Parámetros:
        @T_DOC      TINYINT     - Tipo de documento (referencia a la tabla Tipo_Doc)
        @NRO_DOC    VARCHAR(8)  - Número de documento
        @NOMBRE     VARCHAR(30) - Nombre del cliente
        @APELLIDO   VARCHAR(30) - Apellido del cliente
        @DIRECCION  VARCHAR(100)- Dirección del cliente
        @EMAIL      VARCHAR(100)- Email del cliente
        @FNAC       DATE        - Fecha de nacimiento del cliente
        @TEL        VARCHAR(50) - Teléfono del cliente (opcional)
        @RES        INT OUTPUT  - Código de resultado de la operación
            0: Tipo de documento no existe
            1: Inserción exitosa
            2: Número de documento inválido
            3: DNI ya registrado
            4: Nombre inválido
            5: Apellido inválido
            6: Email inválido
            7: Email ya registrado
*/
GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Insertar_Cliente] 
    @T_DOC          TINYINT,
    @NRO_DOC        VARCHAR(8),
    @NOMBRE         VARCHAR(30),
    @APELLIDO       VARCHAR(30),
    @DIRECCION      VARCHAR(100),
    @EMAIL          VARCHAR(100),
    @FNAC           DATE,
    @TEL            VARCHAR(50),
    @MED_PAGO       TINYINT,
    @ESTADO_CLI     TINYINT,
    @RES            INT = -1 OUTPUT
AS 
BEGIN 
    --  Validar y formatear datos antes de la inserción
    SET NOCOUNT ON
    BEGIN TRANSACTION T_INSERTAR_CLIENTE -- Inicia la transacción

    BEGIN TRY -- Intenta ejecutar el bloque de código

        --  Validar los datos utilizando la función fn_Validar_Cliente
        SET @RES = [db_alquileres_vehiculos].[negocio].[fn_Validar_Cliente]
        (
            @T_DOC,
            @NRO_DOC,
            @NOMBRE,
            @APELLIDO,
            @DIRECCION,
            @EMAIL,
            @FNAC, 
            @MED_PAGO,
            @TEL,
            @ESTADO_CLI
        ) 

        -- Manejar los diferentes códigos de error devueltos por la función
        IF @RES = 0
            RAISERROR ( 'El tipo de documento no existe', 11, 1) -- Error de severidad 11 (error del usuario)
        IF @RES = 2
            RAISERROR ( 'Número de documento inválido', 11, 1)
        IF @RES = 3
            RAISERROR ( 'El DNI ya se encontraba registrado', 11, 1)
        IF @RES = 4
            RAISERROR ( 'El nombre es inválido', 11, 1)
        IF @RES = 5
            RAISERROR ( 'El apellido es inválido', 11, 1)
        IF @RES = 6
            RAISERROR ( 'El email es inválido', 11, 1)
        IF @RES = 7
            RAISERROR ( 'El email ya fue registrado en la BD', 11, 1)
        IF @RES = 8
            RAISERROR ( 'El medio de pago no existe', 11, 1)

        -- Formatear los datos antes de la inserción
        SET @NOMBRE     = TRIM(@NOMBRE)
        SET @APELLIDO   = TRIM(@APELLIDO)
        SET @EMAIL = LOWER(@EMAIL)

        -- Formatear campos específicos (primera letra en mayúscula)
        EXEC [db_utils].[library].[sp_Format_Tittle] @DIRECCION OUTPUT 
        EXEC [db_utils].[library].[sp_Format_Tittle] @NOMBRE    OUTPUT
        EXEC [db_utils].[library].[sp_Format_Tittle] @APELLIDO  OUTPUT

        SET @RES = 1         -- Lo insertó correctamente 

        INSERT INTO 
        [db_alquileres_vehiculos].
        [negocio].
        [Cliente] 
        (   TipoDoc,    NroDoc,     Nombre,     Apellido,   Direccion,      Email,      FNac,   Telefono, MedioPago, Estado    ) VALUES
        (   @T_DOC,     @NRO_DOC,   @NOMBRE,    @APELLIDO,  @DIRECCION,     @EMAIL,     @FNAC,  @TEL,     @MED_PAGO, @ESTADO_CLI )

        COMMIT TRANSACTION -- Confirma la transacción si todo salió bien
     
    END TRY 
    BEGIN CATCH 

        DECLARE @MJE_ERROR  NVARCHAR(100),
                @SEVERIDAD  INT,
                @ESTADO     INT 

        -- Captura el mensaje de error y sus detalles
        SELECT  @MJE_ERROR = ERROR_MESSAGE(), 
                @SEVERIDAD = ERROR_SEVERITY(),
                @ESTADO    = ERROR_STATE()

        -- Si ocurrió un error, se revierte la transacción y se maneja el error
        SET @RES = -1
        RAISERROR (@MJE_ERROR, @SEVERIDAD, @ESTADO)

        -- Revertir la transacción en caso de error
        ROLLBACK TRANSACTION T_INSERTAR_CLIENTE
    END CATCH
END

```