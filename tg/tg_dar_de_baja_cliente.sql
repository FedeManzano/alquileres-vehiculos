
USE db_alquileres_vehiculos

/**
    *  TRIGGER: tg_Dar_De_Baja_Cliente
    *  DESCRIPCION: Este trigger se activa en lugar de una eliminación en la tabla Cliente.
    *  Su objetivo es cambiar el estado del cliente a inactivo (Estado = 0) en lugar de eliminarlo.
*/
GO
CREATE OR ALTER TRIGGER [negocio].[tg_Dar_De_Baja_Cliente] 
ON [db_alquileres_vehiculos].[negocio].[Cliente]
INSTEAD OF DELETE 
AS 
BEGIN 
    BEGIN TRANSACTION DAR_BAJA_CLIENTE

    BEGIN TRY 
        DECLARE @TIPO_DOC   TINYINT,
                @NRO_DOC    VARCHAR(8)

        DECLARE CursorCliente CURSOR FOR 
        SELECT TipoDoc, NroDoc FROM deleted

        OPEN CursorCliente

        FETCH NEXT FROM CursorCliente INTO @TIPO_DOC, @NRO_DOC

        WHILE @@FETCH_STATUS = 0
        BEGIN 
            UPDATE [db_alquileres_vehiculos].[negocio].[Cliente] 
            SET Estado = 0 
            WHERE TipoDoc = @TIPO_DOC AND NroDoc = @NRO_DOC

            FETCH NEXT FROM CursorCliente INTO @TIPO_DOC, @NRO_DOC
        END

        CLOSE CursorCliente
        DEALLOCATE CursorCliente

        COMMIT TRANSACTION DAR_BAJA_CLIENTE
    END TRY
    BEGIN CATCH 
        ROLLBACK TRANSACTION DAR_BAJA_CLIENTE
    END CATCH
END

 -- DROP TRIGGER [negocio].[tg_Dar_De_Baja_Cliente]