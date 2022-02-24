# ### PowerShell 7.2 is required ###
$confHjson = "$env:APPDATA/dystroy/broot/config/conf.hjson"
if (($PSVersionTable.PSVersion.Major -lt 6) -and (!(Test-Path $confHjson))) {
    Write-Host "Error! Please use PowerShell 7.2 or higher!" -ForegroundColor DarkRed
    write-host "Warning!! Please run broot at least once!!" -ForegroundColor DarkRed
}
else {
    $CONFIG = "$HOME/.config"

    # bat
    sudo New-Item -ItemType SymbolicLink -Path $env:APPDATA/bat -Target $CONFIG/bat

    # broot
    Remove-Item $confHjson -Force
    sudo New-Item -ItemType symboliclink -Path $confHjson -Target $CONFIG/broot/conf.hjson

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
        New-Item -ItemType Directory -Path $HOME/Documents/PowerShell
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

}
