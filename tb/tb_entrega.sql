

USE db_alquileres_vehiculos


IF NOT EXISTS 
(
    SELECT  1
    FROM   INFORMATION_SCHEMA.TABLES  
    WHERE  TABLE_NAME      = 'Entrega'  AND
           TABLE_SCHEMA    = 'negocio'
)
BEGIN
    CREATE TABLE    [db_alquileres_vehiculos].
                    [negocio].
                    [Entrega]
    (
    --  NOMBRE              TIPO        RESTRCCIÓN
        NroEntrega          SMALLINT    IDENTITY(1,1) NOT NULL,
        NroAlquiler         INT         NOT NULL,
        TipoDocCliente      TINYINT     NOT NULL,
        NroDocCliente       VARCHAR(8)  NOT NULL,  
        LegajoEmpleado      INT         NOT NULL,
        FEntrega            DATETIME    NOT NULL,
        FDevolucion         DATETIME,
        ID_Tipo_Vehiculo    SMALLINT    NOT NULL,
        PatenteVehiculo     CHAR(7)     NOT NULL,

        -- RESTRCCIÓN PRIMARY KEY
        CONSTRAINT PK_Entrega PRIMARY KEY 
        (NroEntrega, NroAlquiler, TipoDocCliente, NroDocCliente, ID_Tipo_Vehiculo, PatenteVehiculo, LegajoEmpleado, FEntrega),

        -- RESTRCCIÓN FOREIGN KEY (NroAlquiler, TipoDocCliente, NroDocCliente, ID_Tipo_Vehiculo) De Alquiler
        CONSTRAINT FK_Entrega_Alquiler FOREIGN KEY (NroAlquiler, TipoDocCliente, NroDocCliente, ID_Tipo_Vehiculo) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Alquiler] 
                    (NroAlquiler, TipoDoc, NroDoc, ID_T_Vehiculo),
        -- RESTRCCIÓN FOREIGN KEY LegajoEmpleado De Empleado
        CONSTRAINT FK_Entrega_Empleado FOREIGN KEY (LegajoEmpleado) REFERENCES
                [db_alquileres_vehiculos].[negocio].
                [Empleado] (Legajo) ON DELETE CASCADE
    );
END

