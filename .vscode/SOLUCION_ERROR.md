# 🔧 Solución Rápida: Error "mssql.addObjectExplorer not found"

## Pasos Inmediatos

### Opción A: Reinstalar mssql (5 minutos)

```powershell
# 1. Cierra VS Code completamente

# 2. Abre PowerShell y ejecuta:
Remove-Item -Recurse -Force "$env:USERPROFILE\.vscode\extensions\ms-mssql.mssql-*" -ErrorAction SilentlyContinue

# 3. Abre VS Code y reinstala la extensión desde el marketplace
```

### Opción B: Usar SQLTools (Recomendado - 2 minutos)

1. **Desinstala** la extensión `ms-mssql.mssql` si está instalada
2. **Instala** estas dos extensiones:
   - `SQLTools` (mtxr.sqltools)
   - `SQLTools Driver for SQL Server` (mtxr.sqltools-driver-mssql)
3. Presiona `Ctrl+Shift+P` → `SQLTools: Add New Connection`
4. Configura tu conexión a SQL Server

## ¿Por qué ocurre este error?

- La extensión `ms-mssql.mssql` no se cargó correctamente
- Hay un conflicto con otras extensiones
- La extensión necesita actualizarse o reinstalarse
- Falta Node.js o alguna dependencia

## Verificación Rápida

Abre la paleta de comandos (`Ctrl+Shift+P`) y escribe:
- Si aparece `MS SQL: Connect` → La extensión está funcionando
- Si NO aparece → Necesitas reinstalar o usar SQLTools

## Alternativa: Azure Data Studio

Si ninguna extensión funciona, considera usar **Azure Data Studio**:
- Descarga desde: https://aka.ms/azuredatastudio
- Es un editor SQL dedicado de Microsoft
- Funciona perfectamente con SQL Server



