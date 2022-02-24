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
scoop install aria2 autohotkey bat bottom broot dust fd ffmpeg fzf gitui less lsd mpv neovim nu posh-git ripgrep sd so starship sudo shutup10 vscodium windowsspyblocker yt-dlp zenhan zoxide

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
    "WSearch",
    "edgeupdate",
    "edgeupdatem"
)
foreach ($name in $SearviceName) {
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
