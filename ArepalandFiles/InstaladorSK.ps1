# Carpeta donde se guardará el archivo descargado dentro de "FilesInstall"
$carpetaDestino = Join-Path -Path $PSScriptRoot -ChildPath "FilesInstall"

# Verificar si la carpeta de destino "FilesInstall" existe, si no, crearla
if (-not (Test-Path -Path $carpetaDestino)) {
    New-Item -ItemType Directory -Path $carpetaDestino | Out-Null
}

# URL del archivo a descargar
$url = "https://skmedix.pl/bin/_/3.2/x64/SKlauncher-3.2.exe"

# Nombre del archivo a partir de la URL
$nombreArchivo = [System.IO.Path]::GetFileName($url)

# Ruta completa de destino del archivo en la carpeta FilesInstall
$rutaCompletaArchivo = Join-Path -Path $carpetaDestino -ChildPath $nombreArchivo

# Descargar el archivo desde la URL
try {
    Invoke-WebRequest -Uri $url -OutFile $rutaCompletaArchivo
    Write-Host "El archivo se ha descargado exitosamente en: $rutaCompletaArchivo"
} catch {
    Write-Host "Error al descargar el archivo: $_.Exception.Message"
}

# Obtener la ruta de la carpeta del usuario que ejecuta el script
$rutaUsuario = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)

# Mover el archivo descargado a la carpeta del usuario
$rutaUsuarioArchivo = Join-Path -Path $rutaUsuario -ChildPath $nombreArchivo
Move-Item -Path $rutaCompletaArchivo -Destination $rutaUsuarioArchivo -Force

# Esperar 3 segundos antes de cerrar automáticamente el programa
Start-Sleep -Seconds 3
