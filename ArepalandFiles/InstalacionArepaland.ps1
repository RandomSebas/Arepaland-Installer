# Comprobar permisos de administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Por favor, ejecuta este script como administrador."
    Start-Sleep -Seconds 5
    exit
}

# Array con los nombres de los scripts a ejecutar en orden
$scripts = @("InstaladorJava.ps1", "InstaladorSK.ps1", "InstaladorGithub.ps1", "ClonarRepo.ps1", "MoverCarpetaArepaland.ps1", "AccesoDirectoCreacion.ps1") # Agrega aquí los nombres de tus scripts

foreach ($script in $scripts) {
    try {
        # Iniciar el script actual
        Start-Process powershell -ArgumentList "-File `"$script`"" -Wait

        # Esperar 5 segundos para comprobar que el script se cerró correctamente
        Start-Sleep -Seconds 5
    } catch {
        Write-Host "Error al ejecutar el script: $script"
        Write-Host $_.Exception.Message
        Write-Host "Deteniendo la instalación..."
        # Realizar acciones de limpieza o manejo de errores si es necesario
        exit
    }
}

# Mensaje de finalización
Write-Host "Todos los scripts se ejecutaron correctamente."

# Esperar 5 segundos antes de cerrar
Start-Sleep -Seconds 5
