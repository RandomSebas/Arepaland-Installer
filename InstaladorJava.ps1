# Obtener la ruta completa al archivo MSI en la carpeta "FilesInstall"
$rutaMSI = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath "FilesInstall") -ChildPath "java17.msi"

# Verificar si el archivo MSI existe
if (-not (Test-Path -Path $rutaMSI)) {
    Write-Host "El archivo 'java17.msi' no se encuentra en la carpeta 'FilesInstall'. Verifica la ubicacion del archivo."
    Exit
}

# Comando de instalacion
$comandoInstalacion = "msiexec /i `"$rutaMSI`" ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome INSTALLDIR=`"C:\Program Files\Temurin`" /quiet"

try {
    # Ejecutar instalacion silenciosa
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c", $comandoInstalacion -Wait

    # Mensaje de confirmacion
    Write-Host "La instalacion ha finalizado."

    # Contador antes de cerrar el script
    $contador = 3
    while ($contador -gt 0) {
        Write-Host "Cerrando en $contador segundos..."
        Start-Sleep -Seconds 1
        $contador--
    }
}
catch {
    # Mostrar mensaje en caso de error
    Write-Host "Ha ocurrido un error durante la instalacion:`n$_"
}
