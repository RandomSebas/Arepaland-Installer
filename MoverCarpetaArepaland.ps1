# Ruta de la carpeta origen y destino
$scriptDirectorio = Split-Path -Parent $MyInvocation.MyCommand.Path
$carpetaOrigen = Join-Path -Path $scriptDirectorio -ChildPath "TempFiles\Arepaland RE"
$carpetaDestino = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("UserProfile"), "Arepaland RE")

# Comprobar si la carpeta origen existe
if (Test-Path $carpetaOrigen) {
    try {
        # Intentar mover la carpeta a la ubicación destino
        Move-Item -Path $carpetaOrigen -Destination $carpetaDestino -Force -ErrorAction Stop
        Write-Host "La carpeta 'Arepaland RE' se ha movido a '$carpetaDestino'"
    } catch {
        Write-Host "No se pudo mover la carpeta 'Arepaland RE' a '$carpetaDestino'. Se produjo un error: $_"
        Start-Sleep -Seconds 2
    }
} else {
    Write-Host "La carpeta 'Arepaland RE' no se encontró en '$carpetaOrigen'"
    Start-Sleep -Seconds 2
}
