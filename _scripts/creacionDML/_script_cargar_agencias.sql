USE db_alquileres_vehiculos



    INSERT INTO [db_alquileres_vehiculos].[negocio].[Agencia] (
        CuitAgencia,
        Correo,
        Nombre,
        Telefono,
        Direccion
    ) VALUES (
        '30123456789',
        'info@agenciaejemplo.com',
        'Agencia Ejemplo',
        '01112345678',
        'Av. Siempre Viva 123'
    ),
    (
        '20876543210',
        'info@agenciaejemplo2.com',
        'Agencia Ejemplo 2',
        '01187654321',
        'Av. Siempre Viva 456'
    ),
    (
        '23556677881',
        'info@agenciaejemplo3.com', 
        'Agencia Ejemplo 3',
        '01133445566',
        'Av. Siempre Viva 789'
    )




SELECT * FROM [db_alquileres_vehiculos].[negocio].[Agencia]
