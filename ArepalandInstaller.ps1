# Definir la URL del archivo zip del repositorio y la ruta de la carpeta de destino
$repoUrl = "https://github.com/RandomSebas/Arepaland-Installer/archive/main.zip"
$destinationFolder = "ALInstaller"

# Crear la carpeta de destino si no existe
if (-not (Test-Path -Path $destinationFolder -PathType Container)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Definir la ruta del archivo zip descargado
$zipFile = Join-Path -Path (Get-Location) -ChildPath "Arepaland-Installer.zip"

# Descargar el archivo zip del repositorio
Invoke-WebRequest -Uri $repoUrl -OutFile $zipFile

# Descomprimir el archivo zip en la carpeta de destino
Expand-Archive -Path $zipFile -DestinationPath $destinationFolder -Force

# Eliminar el archivo zip después de la extracción
Remove-Item $zipFile

# Obtener la ruta completa del archivo InstalacionArepaland.ps1
$ps1FilePath = Join-Path -Path $destinationFolder -ChildPath "Arepaland-Installer-main\InstalacionArepaland.ps1"

# Verificar si el archivo ps1 existe antes de intentar ejecutarlo
if (Test-Path -Path $ps1FilePath -PathType Leaf) {
    # Ejecutar el archivo ps1
    Invoke-Expression -Command "& '$ps1FilePath'"
} else {
    Write-Host "El archivo InstalacionArepaland.ps1 no se encontró en el repositorio descargado."
}
