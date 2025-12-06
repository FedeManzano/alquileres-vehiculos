# Configuración del Complemento de SQL Server

Este proyecto incluye la configuración necesaria para usar las extensiones de SQL Server en VS Code.

## ⚠️ Error: "command 'mssql.addObjectExplorer' not found"

Si estás experimentando este error, sigue estos pasos en orden:

### Solución 1: Reinstalar la extensión mssql

1. **Desinstalar la extensión:**
   - Abre VS Code
   - Ve a Extensiones (Ctrl+Shift+X)
   - Busca "SQL Server (mssql)"
   - Haz clic en el engranaje ⚙️ → "Desinstalar"
   - **Cierra completamente VS Code**

2. **Limpiar caché (opcional pero recomendado):**
   - Cierra VS Code completamente
   - Elimina la carpeta de caché de la extensión:
     - Windows: `%USERPROFILE%\.vscode\extensions\ms-mssql.mssql-*`
     - O busca en: `C:\Users\feder\.vscode\extensions\` y elimina carpetas que empiecen con `ms-mssql.mssql`

3. **Reinstalar:**
   - Abre VS Code
   - Ve a Extensiones (Ctrl+Shift+X)
   - Busca "SQL Server (mssql)" de Microsoft
   - Haz clic en "Instalar"
   - **Reinicia VS Code** después de la instalación

### Solución 2: Usar SQLTools (Recomendado - Más Estable)

SQLTools es una alternativa más estable y moderna:

1. **Instalar SQLTools:**
   - Abre Extensiones (Ctrl+Shift+X)
   - Busca e instala: `SQLTools` (mtxr.sqltools)
   - Busca e instala: `SQLTools Driver for SQL Server` (mtxr.sqltools-driver-mssql)

2. **Configurar conexión:**
   - Presiona `Ctrl+Shift+P`
   - Escribe: `SQLTools: Add New Connection`
   - Selecciona `MSSQL`
   - Completa los datos:
     - **Name**: Alquileres Vehiculos
     - **Server**: localhost
     - **Port**: 1433
     - **Database**: db_alquileres_vehiculos
     - **Username**: tu usuario
     - **Password**: tu contraseña

3. **Usar SQLTools:**
   - Abre cualquier archivo `.sql`
   - Selecciona la conexión desde el panel lateral de SQLTools
   - Resalta el código SQL
   - Presiona `Ctrl+Shift+E` o haz clic derecho → "Run Selected Query"

### Solución 3: Verificar dependencias

Si el problema persiste:

1. **Verificar Node.js:**
   - La extensión mssql requiere Node.js
   - Abre terminal en VS Code (Ctrl+`)
   - Ejecuta: `node --version`
   - Si no está instalado, instala Node.js desde [nodejs.org](https://nodejs.org/)

2. **Revisar logs de errores:**
   - Ve a: Ver → Salida (View → Output)
   - Selecciona "SQL Server" o "Log (Extension Host)" en el menú desplegable
   - Busca errores específicos

## Extensiones Recomendadas

1. **SQL Server (mssql)** - Extensión oficial de Microsoft
   - ID: `ms-mssql.mssql`
   - ⚠️ Puede tener problemas de estabilidad
   - Proporciona IntelliSense, ejecución de consultas y conexión a SQL Server

2. **SQLTools** - Herramienta alternativa (⭐ RECOMENDADA)
   - ID: `mtxr.sqltools`
   - Driver: `mtxr.sqltools-driver-mssql`
   - Más estable y moderna

## Instalación

1. Abre VS Code
2. Ve a la pestaña de Extensiones (Ctrl+Shift+X)
3. Instala las extensiones recomendadas (VS Code debería sugerirlas automáticamente)

## Configuración de Conexión

### Para la extensión mssql (Microsoft SQL Server)

1. Abre la paleta de comandos (Ctrl+Shift+P)
2. Escribe: `MS SQL: Add Connection`
3. Completa los datos:
   - **Server**: `localhost` (o la dirección de tu servidor SQL Server)
   - **Database**: `db_alquileres_vehiculos`
   - **Authentication Type**: `SqlLogin` o `Integrated`
   - **User name**: Tu usuario de SQL Server
   - **Password**: Tu contraseña

### Para SQLTools

1. Abre la paleta de comandos (Ctrl+Shift+P)
2. Escribe: `SQLTools: Add New Connection`
3. Selecciona `MSSQL` como driver
4. Completa los datos de conexión

## 📚 Documentación de Errores

Si estás usando **SQLTools** y encuentras errores, consulta:
- **`.vscode/SQLTOOLS_ERRORS.md`** - Guía completa de errores comunes de SQLTools
- [Documentación oficial SQLTools MSSQL](https://vscode-sqltools.mteixeira.dev/en/drivers/mssql#Error)

## Solución de Problemas

### El complemento no se conecta

1. **Verifica que SQL Server esté ejecutándose**
   - Abre SQL Server Configuration Manager
   - Asegúrate de que el servicio SQL Server esté en ejecución

2. **Verifica la configuración de red**
   - SQL Server debe estar configurado para aceptar conexiones TCP/IP
   - El puerto por defecto es 1433

3. **Verifica las credenciales**
   - Asegúrate de que el usuario y contraseña sean correctos
   - Si usas autenticación de Windows, usa `Integrated` en lugar de `SqlLogin`

4. **Reinicia VS Code**
   - A veces es necesario reiniciar VS Code después de instalar extensiones

5. **Verifica los permisos**
   - El usuario debe tener permisos para conectarse a la base de datos
   - Ejecuta `main.sql` primero para crear la base de datos

### La extensión no aparece

1. Verifica que esté instalada en la pestaña de Extensiones
2. Reinicia VS Code
3. Si persiste, desinstala y vuelve a instalar la extensión

## Uso

Una vez configurada la conexión:

1. Abre cualquier archivo `.sql`
2. Selecciona la conexión desde el panel de SQL Server
3. Resalta el código SQL que quieres ejecutar
4. Presiona `Ctrl+Shift+E` o haz clic derecho y selecciona "Execute Query"

## Base de Datos

La base de datos configurada es: `db_alquileres_vehiculos`

Asegúrate de ejecutar `main.sql` primero para crear la base de datos y los esquemas necesarios.


