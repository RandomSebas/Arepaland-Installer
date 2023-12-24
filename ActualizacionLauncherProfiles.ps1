# Ruta al archivo launcher_profiles.json
$rutaLauncherProfiles = "$env:APPDATA\.minecraft\launcher_profiles.json"

if (Test-Path $rutaLauncherProfiles) {
    # El archivo existe, cargar su contenido
    $jsonContent = Get-Content -Path $rutaLauncherProfiles | ConvertFrom-Json

    # Verificar si la sección 'profiles' existe
    if ($jsonContent.profiles) {
        # La sección 'profiles' existe, agregar o modificar un perfil
        $newProfile = @{
            "b1052e37f535440ea748d33668fcd949" = @{
                "name" = "ArepalandRE"
                "gameDir" = "C:\Users\$env:USERNAME\AppData\Roaming\.minecraft\modpacks\ArepalandBetaV2"
                "lastVersionId" = "1.19.2-forge-43.3.5"
                "javaArgs" = "-XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"
                "resolution" = @{
                    "width" = 1280
                    "height" = 720
                    "fullscreen" = $false
                }
            }
        }

        $jsonContent.profiles += $newProfile

    } else {
        # La sección 'profiles' no existe, crear un nuevo perfil
        $newProfile = @{
            "b1052e37f535440ea748d33668fcd949" = @{
                "name" = "ArepalandRE"
                "gameDir" = "C:\Users\$env:USERNAME\AppData\Roaming\.minecraft\modpacks\ArepalandBetaV2"
                "lastVersionId" = "1.19.2-forge-43.3.5"
                "javaArgs" = "-XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"
                "resolution" = @{
                    "width" = 1280
                    "height" = 720
                    "fullscreen" = $false
                }
            }
        }

        $jsonContent | Add-Member -MemberType NoteProperty -Name "profiles" -Value $newProfile
    }

    # Convertir a formato JSON y guardar los cambios
    $jsonContent | ConvertTo-Json | Set-Content -Path $rutaLauncherProfiles
} else {
    # El archivo no existe, crearlo con el contenido deseado
    $newProfile = @{
        "profiles" = @{
            "b1052e37f535440ea748d33668fcd949" = @{
                "name" = "ArepalandRE"
                "gameDir" = "C:\Users\$env:USERNAME\AppData\Roaming\.minecraft\modpacks\ArepalandBetaV2"
                "lastVersionId" = "1.19.2-forge-43.3.5"
                "javaArgs" = "-XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"
                "resolution" = @{
                    "width" = 1280
                    "height" = 720
                    "fullscreen" = $false
                }
            }
        },
        "selectedProfile" = "6f849a4cafb74f5297922f2f74abbe01",
        "settings" = @{
            "enableAdvanced" = $false
            "profileSorting" = "byName"
        },
        "version" = 3
    }

    $newProfile | ConvertTo-Json | Set-Content -Path $rutaLauncherProfiles
}
