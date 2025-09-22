# Alquileres de vehículos

Se presenta un ejercicio para gestionar los alquileres de vehículos de una determinada empresa.
Para poder utilizar este ejemplo hay que crear las depencencias que se encuentran en la raiz de este repositorio,
el nombre de los archivos están en :green_book: [db_util](/utils).

## Diseño

![Modelado](/db_alquileres_vehiculos/mod/DER.png)

## :green_book: [db_util](/utils)

- :green_book: <b>db_utils</b> (Crear la BD)
    - :open_file_folder: <b>fn</b>
        - :page_facing_up: <i>fn_lados_triangulo.sql</i>
        - :page_facing_up: <i>fn_validate_dni.sql</i>
        - :page_facing_up: <i>fn_validate_email.sql</i>
    - <b>sp</b>
        - :open_file_folder: <b>format</b>
            - :page_facing_up: <i>sp_format_tittle.sql</i> 
        - :open_file_folder: <b>random</b>
            - :page_facing_up: <i>sp_str_letter_random.sql</i> 
            - :page_facing_up: <i>sp_str_number_random.sql</i>
            - :page_facing_up: <i>sp_str_date_random.sql</i>
        - :open_file_folder: <b>validate</b> 
            - :page_facing_up: <i>sp_assert_equals.sql</i>
            - :page_facing_up: <i>sp_exists_element.sql</i>
            - :page_facing_up: <i>sp_validate_cuit.sql</i>

> Todos estos elementos tienen que ser creados para poder utilizar los ejercicios de prueba para aprender SQL.

## Creación de elementos en esta BD

- :green_book: <b>db_alquileres_vehiculos</b> (Crear la BD)
    - :open_file_folder: <b>fn</b>
        - :page_facing_up: <i>fn_validar_cliente.sql</i>
    - <b>sp</b>
        - :page_facing_up: <i>sp_insertar_cliente.sql</i> 
    - <b>tb</b>
        - :page_facing_up: <i>tb_agencia.sql</i> 
        - :page_facing_up: <i>tb_alquiler.sql</i>
        - :page_facing_up: <i>tb_cliente.sql</i>
        - :page_facing_up: <i>tb_entrega.sql</i>
        - :page_facing_up: <i>tb_garage.sql</i>
        - :page_facing_up: <i>tb_tipo_doc.sql</i>
        - :page_facing_up: <i>tb_tipo_vehiculo.sql</i>
        - :page_facing_up: <i>tb_vehiculo.sql</i>


## Autor

[Federico Manzano](https://github.com/FedeManzano)