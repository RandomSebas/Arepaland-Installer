# Define la ruta donde se encuentra el directorio TempFiles
$directorioTemporal = Join-Path -Path $PSScriptRoot -ChildPath "TempFiles"

# Crea el directorio TempFiles si no existe
if (-not (Test-Path -Path $directorioTemporal)) {
    New-Item -Path $directorioTemporal -ItemType Directory | Out-Null
}

# Define la ruta donde se descargará el repositorio
$rutaRepositorio = Join-Path -Path $directorioTemporal -ChildPath "Arepaland RE"

# Clona el repositorio en la ubicación especificada
git clone https://github.com/RandomSebas/Arepaland-RE $rutaRepositorio

# Si quieres eliminar la carpeta .git y mantener solo los archivos
 Remove-Item -Path (Join-Path -Path $rutaRepositorio -ChildPath ".git") -Recurse -Force
