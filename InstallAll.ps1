# Stop and Disable Services
sudo Set-Service -Name Spooler -StartupType Disabled -Status Stopped
sudo Set-Service -Name WSearch -StartupType Disabled -Status Stopped
sudo Set-Service -Name edgeupdate -StartupType Disabled -Status Stopped
sudo Set-Service -Name edgeupdatem -StartupType Disabled -Status Stopped
sudo Set-Service -Name MicrosoftEdgeElevationService -StartupType Disabled -Status Stopped


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
scoop install aria2 autohotkey bat bitwarden bottom broot czkawka dust everything everything-cli fd ffmpeg fzf gitui less lightbulb lsd monolith mpv neovim posh-git ripgrep sd sharex starship sudo shutup10 sumatrapdf tldr windowsspyblocker yt-dlp zenhan zoxide

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


# Install WPD
mkdir $HOME\WPD | Set-Location
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\WPD\wpd.zip
7z x wpd.zip
.\WPD.exe
