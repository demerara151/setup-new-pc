# Adding buckets
foreach (
    $bucket in @(
        "extras",
        "nerd-fonts",
        "games",
        "nonportable"
    )
) { scoop bucket add $bucket }


# Must-Have tools
scoop install aria2 autohotkey bat bitwarden bottom broot czkawka dust everything everything-cli fd ffmpeg fzf gitui less lightbulb lsd monolith mpv neovim nu posh-git ripgrep sd sharex so starship sudo shutup10 sumatrapdf tldr vscodium windowsspyblocker yt-dlp zenhan zoxide

# Programming（Optional from here. You can put `#` on top of the line to disable install）
scoop install github python rustup-msvc sqlitebrowser

# Gaming
scoop install legendary playnite osulazer

# Media
scoop install foobar2000 foobar2000-encoders freetube gallery-dl

# Nerd Fonts
sudo scoop install VictorMono-NF-Mono FantasqueSansMono-NF-Mono CascadiaCode-NF-Mono

# Display thumbnail
sudo scoop install icaros-np


# Check whether winget command is installed
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install with winget
$programs = @(
    "gerardog.gsudo",

    "Microsoft.PowerShell",
    "LibreWolf.LibreWolf"
    "Foundry376.Mailspring",
    "DuongDieuPhap.ImageGlass",

    "Microsoft.dotnetRuntime.6-x64",
    "Microsoft.VC++2015-2022Redist-x64",
    "Microsoft.VC++2015-2022Redist-x86",
    "Microsoft.VisualStudio.2022.BuildTools",

    "Valve.Steam",
    "Discord.Discord",
    "HeroicGamesLauncher.HeroicGamesLauncher"

)
foreach ($program in $programs) {
    winget install --id $program -s winget
}


# Stop and Disable Services
$ServiceName = @(
    "Fax",
    "Spooler",
    "WSearch",
    "edgeupdate",
    "edgeupdatem"
)
foreach ($name in $ServiceName) {
    sudo Set-Service -Name $name -StartupType Disabled -Status Stopped
}


# Set the .config directory
Move-Item -Path "$HOME/Documents/setup-new-pc/.config/*" -Destination "$HOME/.config"

# Install WPD
mkdir $HOME\PortableApps\WPD | Set-Location
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\PortableApps\WPD\wpd.zip
7z x wpd.zip

# Run WPD
.\WPD.exe
