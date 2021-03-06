# Adding buckets
foreach (
    $bucket in @(
        "extras",
        "nerd-fonts",
        "games",
        "nonportable"
    )
) { scoop bucket add $bucket }

# Install all AIO Repack for latest Microsoft Visual C++ Redistributable Runtimes.
# More info: https://github.com/abbodi1406/vcredist
sudo scoop install vcredist-aio
VisualCppRedist_AIO_x86_x64.exe /y  # use "/ai1" istead of "/y" to update all packages

# Essentials
scoop install aria2 autohotkey bat bitwarden bottom brave broot czkawka dust everything everything-cli fd ffmpeg ffsend fzf hwinfo imageglass less lightbulb lsd mailspring mpv neovim posh-git pwsh ripgrep sd sharex starship shutup10 terminal-icons trilium vscode windowsdesktop-runtime-lts yt-dlp zenhan zoxide

# --- Optional from here. You can disable install by put `#` on top of each line. --- #
# Programming
scoop install gitui monolith poetry python rustup-msvc so sqlitebrowser tldr

# Gaming
scoop install legendary playnite

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
    # Default Browser
    "LibreWolf.LibreWolf",

    # --- Optional from here. You can disable install by put `#` on top of each line. --- #
    # Gaming
    "Valve.Steam",
    "Discord.Discord",
    "HeroicGamesLauncher.HeroicGamesLauncher", # Epic launcher alternative

    # Programming
    "gerardog.gsudo", # Yet another sudo command
    "Microsoft.VisualStudio.2022.BuildTools" # for Rust development

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

    # Make sure you don't use these services. Remove `#` from each line to 'Stop and disable' services.
    #"Spooler", # Printer
    #"iphlpsvc", # IPv6
    #"IpxlatCfgSvc", # IP ????????????????????????

    # Microsoft Edge Update
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)
foreach ($service in $services) {
    sudo Set-Service -Name $service -StartupType Disabled -Status Stopped
}

# Set the .config directory
Move-Item -Path ~/setup-new-pc/.config -Destination ~/ -Force

# Install WPD
New-Item -ItemType Directory -Path ~/setup-new-pc/WPD
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile ~/setup-new-pc/WPD/wpd.zip

# Extract archive
7z x WPD/wpd.zip -oWPD
Remove-Item -Path ~/setup-new-pc/WPD/wpd.zip

# Run WPD and shutup10
Start-Process -FilePath ~/setup-new-pc/WPD/WPD.exe
Start-Process -FilePath "$(scoop prefix shutup10)\OOSU10.exe"

