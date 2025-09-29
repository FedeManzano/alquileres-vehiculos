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


