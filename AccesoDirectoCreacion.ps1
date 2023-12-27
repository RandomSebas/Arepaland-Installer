# Ruta del directorio donde se encuentra el script
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Rutas y nombres de archivo
$shortcutName = "ArepalandRE Launcher"
$shortcutPath = "$env:USERPROFILE\Desktop\$shortcutName.lnk"
$iconPath = Join-Path -Path $scriptDirectory -ChildPath "IconLauncher\icono.ico"
$userScriptPath = Join-Path -Path $env:USERPROFILE -ChildPath "ActualizadorGit.ps1"

# Crear acceso directo en el escritorio
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = 'powershell.exe'
$Shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$userScriptPath`""
$Shortcut.IconLocation = $iconPath
$Shortcut.Save()

# Contenido del script ActualizadorGit.ps1
@"
# Carpeta del usuario que corre el script
\$userFolder = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)

# Nueva ruta de la carpeta Arepaland RE dentro de la carpeta del usuario
\$localFolderPath = Join-Path -Path \$userFolder -ChildPath 'Arepaland RE'

# URL del repositorio
\$repoURL = 'https://github.com/RandomSebas/Arepaland-RE'

# Verificar cambios en el repositorio
Set-Location \$localFolderPath
\$gitStatus = git status

if (\$gitStatus -match 'nothing to commit, working tree clean') {
    Write-Host 'No hay cambios pendientes en el repositorio.'
} else {
    Write-Host 'Se encontraron cambios en el repositorio. Actualizando...'
    git pull \$repoURL
    
    # Comprobar si hay archivos no rastreados en el repositorio local
    \$untrackedFiles = git ls-files --others --exclude-standard
    
    if (\$untrackedFiles) {
        foreach (\$file in \$untrackedFiles) {
            Remove-Item \$file -Force
            Write-Host "Eliminando archivo no rastreado: \$file"
        }
    }

    # Actualizar archivos modificados o eliminados
    git checkout .
    Write-Host 'Se han aplicado los cambios del repositorio local a la carpeta.'
}

# Abre SKlauncher con argumentos específicos
\$launcherPath = Join-Path -Path \$userFolder -ChildPath 'SKlauncher-3.2.exe'
if (Test-Path \$launcherPath) {
    \$skLauncherArgs = "--workDir 'C:\Users\\\$($env:USERNAME)\Arepaland RE'"  # Argumentos para SKlauncher
    Start-Process \$launcherPath -ArgumentList \$skLauncherArgs
} else {
    Write-Host 'No se pudo encontrar el archivo \$launcherPath.'
}
"@ | Set-Content -Path $userScriptPath -Encoding UTF8
