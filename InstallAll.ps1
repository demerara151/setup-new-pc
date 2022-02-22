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
scoop install autohotkey bat bitwarden bottom broot dust everything everything-cli fd ffmpeg fzf gitui less lightbulb lsd monolith mpv neovim posh-git ripgrep sd sharex starship sudo sumatrapdf yt-dlp zenhan zoxide

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
    "gsudo",
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
    winget install $program -s winget
}
