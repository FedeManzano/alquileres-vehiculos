# Script para solucionar el error de la extensión SQL Server
# Ejecuta este script desde PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Solución para error mssql.addObjectExplorer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si VS Code está cerrado
$vscodeProcess = Get-Process -Name "Code" -ErrorAction SilentlyContinue
if ($vscodeProcess) {
    Write-Host "⚠️  VS Code está abierto. Por favor ciérralo antes de continuar." -ForegroundColor Yellow
    Write-Host "Presiona cualquier tecla después de cerrar VS Code..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Limpiar extensiones mssql
Write-Host "🧹 Limpiando extensiones mssql antiguas..." -ForegroundColor Yellow
$extensionsPath = "$env:USERPROFILE\.vscode\extensions"
$mssqlExtensions = Get-ChildItem -Path $extensionsPath -Filter "ms-mssql.mssql-*" -ErrorAction SilentlyContinue

if ($mssqlExtensions) {
    foreach ($ext in $mssqlExtensions) {
        Write-Host "   Eliminando: $($ext.Name)" -ForegroundColor Gray
        Remove-Item -Recurse -Force $ext.FullName -ErrorAction SilentlyContinue
    }
    Write-Host "✅ Extensiones mssql eliminadas" -ForegroundColor Green
} else {
    Write-Host "ℹ️  No se encontraron extensiones mssql para eliminar" -ForegroundColor Blue
}

# Verificar Node.js
Write-Host ""
Write-Host "🔍 Verificando Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host "✅ Node.js instalado: $nodeVersion" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Node.js no encontrado. La extensión mssql lo requiere." -ForegroundColor Yellow
        Write-Host "   Descarga Node.js desde: https://nodejs.org/" -ForegroundColor Gray
    }
} catch {
    Write-Host "⚠️  Node.js no encontrado. La extensión mssql lo requiere." -ForegroundColor Yellow
    Write-Host "   Descarga Node.js desde: https://nodejs.org/" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ Limpieza completada" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Próximos pasos:" -ForegroundColor Yellow
Write-Host "1. Abre VS Code" -ForegroundColor White
Write-Host "2. Ve a Extensiones (Ctrl+Shift+X)" -ForegroundColor White
Write-Host "3. Busca 'SQL Server (mssql)' e instálalo" -ForegroundColor White
Write-Host "4. O mejor aún, instala 'SQLTools' + 'SQLTools Driver for SQL Server'" -ForegroundColor White
Write-Host "5. Reinicia VS Code" -ForegroundColor White
Write-Host ""
Write-Host "💡 Recomendación: Usa SQLTools en lugar de mssql (más estable)" -ForegroundColor Cyan
Write-Host ""



