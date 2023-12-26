# Función para comprobar los permisos de administrador y ejecutar de nuevo si es necesario
function CheckAdminPermissions {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ScriptPath
    )

    $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isElevated = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isElevated) {
        Start-Process "powershell.exe" -Verb RunAs -ArgumentList "-File `"$ScriptPath`""
        exit
    }
}

# Ruta del script actual
$scriptPath = $MyInvocation.MyCommand.Path

# Comprobar y solicitar permisos de administrador si es necesario
CheckAdminPermissions -ScriptPath $scriptPath

# Ruta del repositorio git
$gitRepoUrl = "https://github.com/RandomSebas/Arepaland-RE"

# Carpeta donde se instalarán los archivos
$installFolder = Join-Path -Path (Get-Location) -ChildPath "FilesInstall\ArepalandRE"

# Verificar si la carpeta de instalación existe, si no, crearla
if (-not (Test-Path -Path $installFolder)) {
    New-Item -ItemType Directory -Force -Path $installFolder | Out-Null
}

# Clonar el repositorio git en la carpeta de instalación
git clone $gitRepoUrl $installFolder

# Verificar si la carpeta ArepalandRE existe en FilesInstall y tiene archivos
if (Test-Path -Path $installFolder) {
    $arepalandREFolder = Get-ChildItem -Path $installFolder -Directory | Where-Object { $_.Name -eq "ArepalandRE" }
    
    if ($arepalandREFolder -and (Get-ChildItem -Path $arepalandREFolder.FullName)) {
        # Ruta de la carpeta de destino final
        $destinationFolder = "$env:APPDATA\.minecraft\modpacks"
        
        # Verificar si la carpeta de destino final existe, si no, crearla
        if (-not (Test-Path -Path $destinationFolder)) {
            New-Item -ItemType Directory -Force -Path $destinationFolder | Out-Null
        }
        
        # Mover toda la carpeta ArepalandRE a la carpeta de destino final
        Move-Item -Path $arepalandREFolder.FullName -Destination $destinationFolder -Force -ErrorAction SilentlyContinue
    }
}
