# Comprobar si el script se está ejecutando como administrador
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Si no se está ejecutando como administrador, volver a ejecutar el script con permisos elevados
    Start-Process powershell -Verb RunAs -ArgumentList "-File $($MyInvocation.MyCommand.Path)"
    exit
}

# Ruta de la carpeta origen y destino
$scriptDirectorio = Split-Path -Parent $MyInvocation.MyCommand.Path
$carpetaOrigen = Join-Path -Path $scriptDirectorio -ChildPath "FilesInstall\ArepalandRE"
$carpetaDestino = "$env:AppData\.minecraft\modpacks"

# Comprobar si la carpeta origen existe
if (Test-Path $carpetaOrigen) {
    # Comprobar si la carpeta destino existe, si no, crearla
    if (-not (Test-Path $carpetaDestino)) {
        New-Item -ItemType Directory -Path $carpetaDestino -Force
    }

    # Mover la carpeta a la ubicación destino
    Move-Item -Path $carpetaOrigen -Destination $carpetaDestino -Force
    Write-Host "La carpeta 'ArepalandRE' se ha movido a '$carpetaDestino'"
} else {
    Write-Host "La carpeta 'ArepalandRE' no se encontró en '$carpetaOrigen'"
}
