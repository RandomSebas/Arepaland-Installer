# Verificar si Git está instalado a través de Chocolatey
$scriptPath = $MyInvocation.MyCommand.Definition

# Comprobar si se tiene permisos de administrador
$isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
if (-not $isAdmin) {
    Write-Output "Este script requiere permisos de administrador para instalar o actualizar Git."
    Write-Output "Solicitando permisos de administrador..."
    Start-Process powershell -ArgumentList "-File `"$scriptPath`"" -Verb RunAs
    exit
}

# Si se tiene permisos de administrador, continuar con la instalación o actualización de Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    # Instalar Git usando Chocolatey
    Write-Output "Git no está instalado. Instalando Git..."
    choco install git -y
} else {
    # Actualizar Git si ya está instalado
    Write-Output "Git ya está instalado. Actualizando a la última versión..."
    choco upgrade git -y
}

# Verificar la instalación de Git
if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Output "Git se ha instalado o actualizado correctamente."
} else {
    Write-Output "Ha ocurrido un problema durante la instalación o actualización de Git."
}

# Pausa de 3 segundos antes de cerrar la ventana
Start-Sleep -Seconds 3
