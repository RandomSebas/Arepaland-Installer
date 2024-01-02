# Ruta del directorio del usuario
$userDirectory = [Environment]::GetFolderPath("UserProfile")

# Ruta del archivo que se copiará desde la carpeta del usuario
$sourceFile = Join-Path -Path $userDirectory -ChildPath "ActualizadorGit.ps1"

# Verificar si el archivo existe en la carpeta del usuario
if (-not (Test-Path $sourceFile)) {
    Write-Host "El archivo 'ActualizadorGit.ps1' no existe en la carpeta del usuario." -ForegroundColor Red
    Exit
}

# Ruta del icono
$iconPath = Join-Path -Path $scriptDirectory -ChildPath "IconLauncher\icono.ico"  # Ajusta esta ruta según la ubicación correcta del icono

# Ruta donde se creará el acceso directo en el escritorio
$shortcutLocation = [System.IO.Path]::Combine([Environment]::GetFolderPath('Desktop'), "Arepaland RE Launcher.lnk")

# Crear el objeto para el acceso directo
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutLocation)

# Establecer la ruta del archivo de destino para el acceso directo
$shortcut.TargetPath = "powershell.exe"

# Establecer el argumento para ejecutar el script
$shortcut.Arguments = "-File `"$sourceFile`""

# Establecer la ruta del icono para el acceso directo
$shortcut.IconLocation = $iconPath

# Guardar el acceso directo
$shortcut.Save()
