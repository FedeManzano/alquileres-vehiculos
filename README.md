
# :car: Alquileres de vehículos

## :pushpin: Requisitos previos

- SQL Server 2016 o superior (recomendado)
- Permisos para crear bases de datos y objetos (funciones, procedimientos)
- Cliente SQL compatible (SQL Server Management Studio, Azure Data Studio o extensión SQL para VS Code)
- Conocimientos básicos de T-SQL

Se presenta un ejercicio para gestionar los alquileres de vehículos de una determinada empresa.
Para poder utilizar este ejemplo hay que crear las depencencias que se encuentran en la raiz de este repositorio,
el nombre de los archivos están en :green_book: [db_util](/utils).

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

## :checkered_flag: Problema a resolver

En el presente documento se presentan los requerimientos para el sistema de alquileres de vehículos de la mpresa ```Viajantes```, a grandes rasgos el sistema debe permitirle a los usuarios alquilar varios ```tipos de vehículos``` por un periodo de una semana, cada alquiler tiene que ser registrado y controlado a través de funcionalidades que permitan conocer el estado de cada uno de ellos y realizar los ajustes pertinentes a los datos de manera tal que, la empresa en todo momento conozca el estado de sus vehículos distribuidos por diferentes ```agencias``` que son parte de la compañía. <br>
Se tiene que tener en cuenta la entrega que es días posteriores al alquiler, cuando el ```cliente``` se acerca a la agencia y lo retira personalmente. Los alquileres se realizan por medios informáticos a distancia dejando un espacio de dos días para el retiro. <br>
En la agencia, ```la persona a cargo``` le va a entregar al cliente las llaves de los vehículos alquilados y registrará la entrega de los vehículos y acreditará el monto por el alquiler ejecutado.
Cada cliente tiene la opción de retirar más de un vehículo en un mismo alquiler y después de pasado el plazo predefinido, el mismo debe devolverlo a la agencia perteneciente a la empresa en las condiciones adecuadas, caso contrario deberá abonar un recargo por roturas y atrasos en los plazos de entrega.

## :crossed_flags: Límite

Desde que el cliente realiza el alquiler, hasta que el mismo realiza la devolución de el o los vehículos alquilados. 

## :hammer: Alcance (Primera versión)

- Gestionar clientes
- Registrar alquileres
- Actualizar el estado de los alquileres
- Calcular monto total a pagar por alquiler
- Gestionar personal de las agencias
- Registrar entregas
- Registrar garajes donde se guardan los vehículos
- Calcular capacidad disponible de cada garaje
- Gestionar vehículos
- Calcular cantidad de KM totales del vehículo
- Registrar medios de pago
- Actualizar pagos
- Controlar periódicamente el estado de la devolución

## :pencil2: Diseño de clases estimado

El diagrama es el diseño de la capa de aplicación, el lenguaje programación no fue seleccionado aún, pero el modelos se ajusta a cualquiera de ellos.

![Diagrama de Clases](/db_alquileres_vehiculos/mod/diagrama-clases.png)

Las siguientes clases:
- RegistrarPersona
- ActualizarPersona
- ConsultarPersona
- ConsultarTodos
- RegistrarAlquiler
- CalcularMontoTotal
- CalcularAdicionales

Son servivios, a los cuales van a acceder a través de la aplicación a partir de los métodos de HTTP (GET, PUT, DELETE, POST). 

> Para el ejemplo no se tuvo en cuenta el boorrado, para simplificar el diagrama, esto se debe a que es de aprendizaje, aún así es lo suficientemente escalable para que el lector de este documento lo añada si lo desea.

## :green_book: Requisitos Funcionales (Versión reducida)

1.	El sistema debe permitir el ingreso de clientes por su tipo de documento, número de documento, nombre, apellido, fecha de nacimiento, email, teléfono y medios de pago utilizados.
2.	El sistema debe permitir eliminar uno o varios clientes a partir de su tipo y número de documento.
3.	El sistema de permitir modificar información del cliente como la fecha de nacimiento, email, nombre, apellido y formas de pago.
4.	El sistema debe permitir la consulta de uno o varios clientes a través de consultas interactivas.
5.	El sistema debe permitir el registro de un alquiler con el número de alquiler, tipo y número de documento del cliente, la fecha del alquiler, el o los vehículos asignados y el monto total.
6.	El sistema debe permitir el ingreso de vehículos con su patente, modelo, marca, agencia a la cual pertenece, garaje donde se guarda, km totales y precio unitario por alquiler del mismo.

> Primera parte hace falta una actualización, proximamente se incorporarán a la lista los que restan.


## :pencil2: Diseño (Tablas en la base de datos)

El motor seleccionado MSSQL SERVER, como se describe en los requisitos de este docmuento.
> El diseño de la base de datos está libre a modificaciones, a grandes rasgos el diagrama quedaría representado de la siguiente manera.

![Modelado](/db_alquileres_vehiculos/mod/DER.png)

## :scroll: Creación de elementos en esta BD

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