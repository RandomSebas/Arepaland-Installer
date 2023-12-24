# Comprobar si PowerShell tiene la ejecución de scripts habilitada
if (-NOT (Get-ExecutionPolicy)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force;
}

# Comprobar si Chocolatey está instalado
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    # Instalar Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
} else {
    Write-Output "Chocolatey ya está instalado.";
}

# Pausa por 3 segundos antes de cerrar
Start-Sleep -Seconds 3
