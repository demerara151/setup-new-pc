# Check whether winget command is installed
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install with winget
$programs = @(
    "gerardog.gsudo",

    "Microsoft.PowerShell",
    "LibreWolf.LibreWolf"

    "Microsoft.VC++2015-2022Redist-x64",
    "Microsoft.dotnetRuntime.6-x64"
)
foreach ($program in $programs) {
    winget install --id $program -s winget
}

# Adding buckets
foreach (
    $bucket in @(
        "extras",
        "nerd-fonts"
    )
) { scoop bucket add $bucket }

# Must-Have tools
sudo scoop install aria2 autohotkey bat bottom broot dust fd ffmpeg fzf gitui less lsd mpv neovim posh-git ripgrep starship shutup10 vscodium windowsspyblocker yt-dlp zenhan zoxide FantasqueSansMono-NF-Mono CascadiaCode-NF-Mono VictorMono-NF-Mono

# Stop and Disable Services
$Services = @(
    "Fax",
    "iphlpsvc", # IP Helper
    "IpxlatCfgSvc", # IP 変換構成サービス
    "lfsvc", # Geo location
    "Spooler", # Print Spooler
    "XboxGipSvc",
    "WSearch", # Windows search
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)
foreach ($name in $Services) {
    sudo Set-Service -Name $name -StartupType Disabled -Status Stopped
}

# Set the .config directory
Move-Item -Path "$HOME/setup-new-pc/.config/*" -Destination "$HOME/.config" -Force

# Install WPD
mkdir WPD | Set-Location
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\setup-new-pc\WPD\wpd.zip
7z x wpd.zip

# Run WPD
.\WPD.exe
