# 🔧 Solución de Errores Comunes de SQLTools con SQL Server

Basado en la [documentación oficial de SQLTools](https://vscode-sqltools.mteixeira.dev/en/drivers/mssql#Error)

## Errores Comunes y Soluciones

### 1. Error de Conexión: "Cannot connect to server"

**Causas posibles:**
- SQL Server no está ejecutándose
- Puerto incorrecto (por defecto es 1433)
- Firewall bloqueando la conexión
- Credenciales incorrectas

**Soluciones:**
```json
// En settings.json, verifica:
{
  "server": "localhost",  // o tu IP del servidor
  "port": 1433,           // verifica que sea el puerto correcto
  "username": "sa",       // o tu usuario
  "password": "tu_password"
}
```

**Verificar SQL Server:**
1. Abre SQL Server Configuration Manager
2. Verifica que el servicio "SQL Server (MSSQLSERVER)" esté en ejecución
3. Verifica que TCP/IP esté habilitado en Configuración de Red

### 2. Error: "Login failed for user"

**Solución:**
- Verifica que el usuario y contraseña sean correctos
- Si usas autenticación de Windows, cambia a:
  ```json
  "authenticationType": "Integrated"
  ```

### 3. Error: "Certificate chain was issued by an authority that is not trusted"

**Solución:**
Agrega esta opción en `mssqlOptions`:
```json
"mssqlOptions": {
  "trustServerCertificate": true
}
```

### 4. Error: "Connection timeout"

**Solución:**
Aumenta los timeouts:
```json
{
  "connectionTimeout": 60,
  "requestTimeout": 60,
  "mssqlOptions": {
    "connectTimeout": 60
  }
}
```

### 5. Error: "Driver not found" o "MSSQL driver not installed"

**Solución:**
1. Abre Extensiones (Ctrl+Shift+X)
2. Busca: `SQLTools Driver for SQL Server`
3. Instálalo si no está instalado
4. Reinicia VS Code

### 6. Error: "Cannot read property 'query' of undefined"

**Solución:**
- Verifica que la base de datos existe
- Ejecuta primero `main.sql` para crear la base de datos
- Verifica que tengas permisos en la base de datos

## Configuración Recomendada

Para desarrollo local con SQL Server Express o LocalDB:

```json
{
  "sqltools.connections": [
    {
      "name": "Alquileres Vehiculos",
      "driver": "MSSQL",
      "server": "localhost",
      "port": 1433,
      "database": "db_alquileres_vehiculos",
      "username": "sa",
      "password": "tu_password",
      "connectionTimeout": 30,
      "requestTimeout": 30,
      "mssqlOptions": {
        "trustServerCertificate": true,
        "encrypt": true
      }
    }
  ]
}
```

## Para SQL Server LocalDB

Si usas LocalDB, el servidor puede ser:
- `(localdb)\MSSQLLocalDB`
- `(localdb)\ProjectsV13`
- `localhost\SQLEXPRESS`

```json
{
  "server": "(localdb)\\MSSQLLocalDB",
  "port": null,  // LocalDB no usa puerto
  "database": "db_alquileres_vehiculos"
}
```

## Verificar Conexión

1. Abre el panel de SQLTools (icono de base de datos en la barra lateral)
2. Haz clic derecho en tu conexión → "Test Connection"
3. Si hay errores, revisa la pestaña "Output" → "SQLTools"

## Logs y Debugging

Para ver logs detallados:
1. Ve a: Ver → Salida (View → Output)
2. Selecciona "SQLTools" en el menú desplegable
3. Revisa los mensajes de error

## Comandos Útiles

- `Ctrl+Shift+P` → `SQLTools: Add New Connection` - Agregar conexión
- `Ctrl+Shift+P` → `SQLTools: Refresh Tree` - Refrescar conexión
- `Ctrl+Shift+P` → `SQLTools: Show Output Channel` - Ver logs

## Recursos

- [Documentación oficial SQLTools MSSQL](https://vscode-sqltools.mteixeira.dev/en/drivers/mssql)
- [Repositorio GitHub SQLTools](https://github.com/mtxr/vscode-sqltools)
- [Issues conocidos](https://github.com/mtxr/vscode-sqltools/issues)


