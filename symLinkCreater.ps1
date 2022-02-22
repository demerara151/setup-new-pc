$CONFIG = "$HOME/.config"

# bat
Remove-Item $env:APPDATA/bat -Recurse -Force
sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/bat -Target $CONFIG/bat

# broot
Remove-Item $env:APPDATA/dystroy/broot/config/conf.hjson -Force
sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/dystroy/broot/config/conf.hjson -Target $CONFIG/broot/conf.hjson

# nushell
Remove-Item $env:APPDATA/nushell/nu/config -Recurse -Force
sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/nushell/nu/config -Target $CONFIG/nushell

# nvim
Remove-Item $env:LOCALAPPDATA/nvim -Recurse -Force
sudo New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA/nvim -Target $CONFIG/nvim

# powershell
if (!(Test-Path $PROFILE)) {
    sudo New-Item -ItemType SymbolicLink -Path $HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1 -Target $CONFIG/Powershell/Microsoft.PowerShell_profile.ps1
}
else {
    Remove-Item $HOME/Documents/Powerhsell/Microsoft.PowerShell_profile.ps1 -Force
    sudo New-Item -ItemType SymbolicLink -Path $HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1 -Target $CONFIG/Powershell/Microsoft.PowerShell_profile.ps1
}

# vscodium
$setting = "$HOME/scoop/persist/vscodium/data/user-data/User"
Remove-Item $setting/settings.json -Force
sudo New-Item -ItemType SymbolicLink -Path $setting/settings.json -Target $CONFIG/codium/settings.json
