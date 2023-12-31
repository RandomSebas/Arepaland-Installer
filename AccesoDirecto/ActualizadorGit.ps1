﻿# Carpeta del usuario actual
$userFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)

# Nombre de usuario actual
$userName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$userName = $userName.Split("\")[1]  # Obtiene el nombre de usuario sin dominio

# Ruta de la carpeta .minecraft\modpacks\ArepalandRE dentro de la carpeta AppData
$localFolderPath = Join-Path -Path $userFolder -ChildPath 'AppData\Roaming\.minecraft\modpacks\ArepalandRE'

# URL del repositorio
$repoURL = 'https://github.com/RandomSebas/Arepaland-RE'

# Verificar cambios en el repositorio
Set-Location $localFolderPath
$gitStatus = git status

if ($gitStatus -match 'nothing to commit, working tree clean') {
    Write-Host 'No hay cambios pendientes en el repositorio.'
} else {
    Write-Host 'Se encontraron cambios en el repositorio. Actualizando...'
    git pull $repoURL
    
    # Comprobar si hay archivos no rastreados en el repositorio local
    $untrackedFiles = git ls-files --others --exclude-standard
    
    if ($untrackedFiles) {
        foreach ($file in $untrackedFiles) {
            Remove-Item $file -Force
            Write-Host "Eliminando archivo no rastreado: $file"
        }
    }

    # Actualizar archivos modificados o eliminados
    git checkout .
    Write-Host 'Se han aplicado los cambios del repositorio local a la carpeta.'
}

# Ruta de la carpeta del usuario actual para SKlauncher
$sklauncherWorkDir = Join-Path -Path $userFolder -ChildPath 'Arepaland RE'

# Abre SKlauncher
$launcherPath = Join-Path -Path $userFolder -ChildPath 'SKlauncher-3.2.exe'
if (Test-Path $launcherPath) {
    Start-Process $launcherPath "--workDir `"$sklauncherWorkDir`""
} else {
    Write-Host 'No se pudo encontrar el archivo $launcherPath.'
}
