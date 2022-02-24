# Adding buckets
foreach (
    $bucket in @(
        "extras",
        "nerd-fonts"
    )
) { scoop bucket add $bucket }


# Must-Have tools
sudo scoop install aria2 autohotkey bat bottom broot dust fd ffmpeg fzf gitui less lsd mpv neovim nu posh-git ripgrep so starship sudo shutup10 vscodium windowsspyblocker yt-dlp zenhan zoxide FantasqueSansMono-NF-Mono CascadiaCode-NF-Mono VictorMono-NF-Mono

# Check whether winget command is installed
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install with winget
$programs = @(
    "gerardog.gsudo",

    "Microsoft.PowerShell",
    "LibreWolf.LibreWolf"

    "Microsoft.VC++2015-2022Redist-x64"
)
foreach ($program in $programs) {
    winget install --id $program -s winget
}


# Stop and Disable Services
$SearviceName = @(
    "Fax",
    "Spooler",
    "iphlpsvc",
    "WSearch",
    "edgeupdate",
    "edgeupdatem"
)
foreach ($name in $SearviceName) {
    sudo Set-Service -Name $name -StartupType Disabled -Status Stopped
}


# Set the .config directory
Move-Item -Path "$HOME/setup-new-pc/.config/*" -Destination "$HOME/.config" -Force

# Install WPD
mkdir WPD | Set-Location
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\WPD\wpd.zip
7z x wpd.zip

# Run WPD
.\WPD.exe
