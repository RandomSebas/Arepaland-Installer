# Mensaje de inicio
Write-Host "Descargando e instalando Git. Por favor, espera..."

# Descargar el instalador de Git
$url = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
$output = "$env:TEMP\GitInstaller.exe"
Invoke-WebRequest -Uri $url -OutFile $output

# Instalar Git
Start-Process -FilePath $output -ArgumentList "/SILENT", "/NORESTART" -Wait

# Mensaje de confirmación
Write-Host "Git se ha instalado correctamente."

# Esperar 2 segundos antes de cerrar el programa
Start-Sleep -Seconds 2
