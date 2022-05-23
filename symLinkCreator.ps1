# ### PowerShell 7.2 is required ###
if ($PSVersionTable.PSVersion.Major -lt 6) {
    Write-Host "Error! Please use PowerShell 7.2 or higher!" -ForegroundColor DarkRed
}
else {
    $CONFIG = "$HOME/.config"

    # autohotkey
    sudo New-Item -ItemType SymbolicLink -Path "$($env:APPDATA)/Microsoft/Windows/Start Menu/Programs/Startup/keyswap.ahk" -Target $CONFIG/autohotkey/keyswap.ahk

    # bat
    sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/bat -Target $CONFIG/bat

    # broot
    sudo New-Item -ItemType symboliclink -Path $env:APPDATA/dystroy/broot/config/conf.hjson -Force -Target $CONFIG/broot/conf.hjson

    # nvim
    sudo New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA/nvim -Target $CONFIG/nvim

    # mpv
    sudo New-Item -ItemType SymbolicLink -Path $HOME/scoop/persist/mpv/portable_config/mpv.conf -Target $CONFIG/mpv.conf

    # powershell
    sudo New-Item -ItemType SymbolicLink -Path $PROFILE -Force -Target $CONFIG/PowerShell/Microsoft.Powershell_profile.ps1

    # vscodium
    sudo New-Item -ItemType SymbolicLink -Path $HOME/scoop/persist/vscode/data/user-data/User/settings.json -Force -Target $CONFIG/vscode/settings.json

}
