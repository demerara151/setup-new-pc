$CONFIG = "$HOME/.config"

# bat
sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/bat -Target $CONFIG/bat

# broot
$confHjson = "$env:APPDATA/dystroy/broot/config/conf.hjson"
if (!(Test-Path $confHjson)) {
    write-host "Warning!! Please run broot at least once!!" -ForegroundColor DarkRed
    Write-Host "Next, Run the following command: \"Remove-Item $confHjson -Force\""
    Write-Host "Finally, Run this: \"sudo New-Item -ItemType symboliclink -Path $confHjson -Target $CONFIG/broot/conf.hjson\""
}
else {
    Remove-Item $confHjson -Force
    sudo New-Item -ItemType symboliclink -Path $confHjson -Target $CONFIG/broot/conf.hjson
}

# nushell
Remove-Item $env:APPDATA/nushell/nu/config -Recurse -Force
sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/nushell/nu/config -Target $CONFIG/nushell

# nvim
sudo New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA/nvim -Target $CONFIG/nvim

# mpv
sudo New-Item -ItemType SymbolicLink -Path $HOME/scoop/persist/mpv/portable_config/mpv.conf -Target $CONFIG/mpv.conf

# powershell
$dotConfPath = "$CONFIG/PowerShell/Microsoft.Powershell_profile.ps1"
if (!(Test-Path $PROFILE)) {
    sudo New-Item -ItemType SymbolicLink -Path $PROFILE -Target $dotConfPath
}
else {
    Remove-Item $PROFILE -Force
    sudo New-Item -ItemType SymbolicLink -Path $PROFILE -Target $dotConfPath
}

# vscodium
$setting = "$HOME/scoop/persist/vscodium/data/user-data/User"
Remove-Item $setting/settings.json -Force
sudo New-Item -ItemType SymbolicLink -Path $setting/settings.json -Target $CONFIG/codium/settings.json
