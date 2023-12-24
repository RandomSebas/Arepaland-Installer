# Verificar si tiene permisos de administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Reiniciar el script con permisos de administrador
    Start-Process powershell -Verb RunAs -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"")
    Exit
}

# Ruta del archivo JSON en AppData\Roaming\.minecraft
$rutaArchivo = "$env:APPDATA\.minecraft\launcher_profiles.json"

# Leer el archivo JSON y decodificarlo
$json = Get-Content $rutaArchivo | ConvertFrom-Json

# Crear un nuevo perfil de lanzamiento
$newProfile = @{
    name = "ArepalandRE"
    gameDir = "C:\Users\RsebaS\AppData\Roaming\.minecraft\modpacks\ArepalandRE"
    lastUsed = (Get-Date).ToString()
}

# Agregar el nuevo perfil al objeto JSON
if (-not $json.profiles) {
    $json.profiles = @{}
}

$newGuid = [Guid]::NewGuid().ToString("D")
$json.profiles[$newGuid] = $newProfile

# Convertir de nuevo a JSON y escribir de vuelta al archivo
$jsonString = $json | ConvertTo-Json -Depth 10
$jsonString | Set-Content $rutaArchivo
