# Mensaje de inicio
Write-Host "Descargando e instalando Java 17 de Temurin Adoptium. Por favor, espera..."

# Descargar el instalador de Java 17
$url = "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9.1/OpenJDK17U-jre_x64_windows_hotspot_17.0.9_9.msi"
$output = "$env:TEMP\JavaInstaller.msi"
Invoke-WebRequest -Uri $url -OutFile $output

# Instalar Java 17
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $output, "/quiet", "/qn", "/norestart" -Wait

# Mensaje de confirmación
Write-Host "Java 17 de Temurin Adoptium se ha instalado correctamente."

# Esperar 2 segundos antes de cerrar el programa
Start-Sleep -Seconds 2
