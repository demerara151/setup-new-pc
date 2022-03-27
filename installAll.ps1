# Adding buckets
foreach (
    $bucket in @(
        "extras",
        "nerd-fonts",
        "games",
        "nonportable"
    )
) { scoop bucket add $bucket }

# Essentials
scoop install aria2 autohotkey bat bitwarden bottom broot curl czkawka dust everything everything-cli fd ffmpeg ffsend fzf hwinfo less lightbulb lsd mailspring mpv neovim nu posh-git ripgrep sd sharex starship shutup10 sumatrapdf terminal-icons trilium ungoogled-chromium vscodium windowsspyblocker yt-dlp zenhan zoxide

# --- Optional from here. You can disable install by put `#` on top of each line. --- #
# Programming
scoop install github gitui monolith python rustup-msvc so sqlitebrowser tldr

# Gaming
scoop install legendary osulazer playnite

# Media
scoop install exifcleaner foobar2000 foobar2000-encoders freetube gallery-dl losslesscut

# Nerd Fonts
sudo scoop install IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono CascadiaCode-NF-Mono FiraCode-NF-Mono Mononoki-NF-Mono --global

# Display various thumbnails
sudo scoop install icaros-np --global

# --- Optional region ends here --- #

# Check whether winget command is installed
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install some requirements and softwares that you want to set system default with winget
$programs = @(
    "Microsoft.PowerShell", # PowerShell 7
    "LibreWolf.LibreWolf", # Default browser
    "DuongDieuPhap.ImageGlass", # Image viewer

    # Requirements for some apps
    "Microsoft.dotnetRuntime.6-x64",
    "Microsoft.VC++2015-2022Redist-x64",
    "Microsoft.VC++2015-2022Redist-x86",

    # --- Optional from here. You can disable install by put `#` on top of each line. --- #
    # Gaming
    "Valve.Steam",
    "Discord.Discord",
    "HeroicGamesLauncher.HeroicGamesLauncher",

    # Programming
    "gerardog.gsudo", # Yet another sudo command
    "Microsoft.VisualStudio.2022.BuildTools"

    # --- Optional region ends here --- #
)
foreach ($program in $programs) {
    winget install --id $program --source winget
}

# Stop and Disable Services
$services = @(
    "Fax", # Who use fax in 2022?

    "lfsvc", # Geo location
    "WSearch", # Windows search
    "XboxGipSvc",

    # Make sure you don't use these services, remove `#` from each line.
    #"Spooler", # Printer
    #"iphlpsvc", # IPv6
    #"IpxlatCfgSvc", # IP 変換構成サービス

    # Microsoft Edge Update
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)
foreach ($service in $services) {
    sudo Set-Service -Name $service -StartupType Disabled -Status Stopped
}

# Set the .config directory
Move-Item -Path "$HOME/setup-new-pc/.config/*" -Destination "$HOME/.config" -Force

# Install WPD
mkdir WPD | Set-Location
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\setup-new-pc\WPD\wpd.zip
7z x wpd.zip

# Run WPD
.\WPD.exe
