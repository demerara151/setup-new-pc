# Add buckets
foreach (
    $bucket in @(
        "extras",
        "games",
        "nerd-fonts",
        "nonportable"
    )
) { scoop bucket add $bucket }

<#
    .SYNOPSIS
    Install all AIO Repack for latest Microsoft Visual C++ Redistributable Runtimes.

    .LINK
    https://github.com/abbodi1406/vcredist
#>
sudo scoop install vcredist-aio
Start-Process -FilePath "$(scoop prefix vcredist-aio)\VisualCppRedist_AIO_x86_x64.exe" /y

# Microsoft Windows Desktop Runtime
sudo scoop install windowsdesktop-runtime-lts

# Essential for everyone
scoop install bitwarden brave everything hwinfo imageglass librewolf lightbulb mailspring sharex

# Privacy
scoop install privacy.sexy shutup10 wpd

# <# --- Optional from here. You can disable install by put `#` on top of each line or uncomment out both this line and end line. --- #

# Utility (GUI)
scoop install autohotkey2 czkawka-gui ddu nvcleanstall synctrayzor

# Shell
scoop install starship terminal-icons zoxide

# Terminal
scoop install hyper

# Utility (CLI)
scoop install aria2 bat bottom broot chezmoi czkawka dust everything-cli fd ffsend fzf less lsd ripgrep sfsu sd

# Dev
scoop install brotli deno gitui poetry python rustup-msvc so sqlitebrowser tldr

# Editor
scoop install helix neovim vscode zenhan

# Security
scoop install keepassxc gpg4win

# Network
scoop install goodbyedpi

# Gaming # Steam have to install manually.
scoop install discord heroic-games-launcher legendary playnite

# Media
scoop install ffmpeg foobar2000 foobar2000-encoders freetube gallery-dl mpv yt-dlp

# Media Tool
scoop install exifcleaner inkscape losslesscut openshot waifu2x-ncnn-vulkan 

# Nerd Fonts
sudo scoop install Delugia-Nerd-Font-Complete IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono CascadiaCode-NF-Mono JetBrainsMono-NF-Mono Mononoki-NF-Mono --global

# Display various thumbnails
sudo scoop install icaros-np --global

# --- Optional region ends here --- #>

<#

    .NOTES
    Commented out this function since winget source is broken.
    Besides that winget stops working when privacy.sexy strict rules applied.
    winget has a lot of problem in my recent use case. I'm gonna ditch this function in the future.

    .LINK
    https://github.com/microsoft/winget-cli/issues/2666

# Make sure winget is installed. If not exists install winget via scoop.
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install some requirements and softwares that you want to set system default with winget
$programs = @(
    # Default Browser
    "LibreWolf.LibreWolf",

    # --- Optional from here. You can disable install by put `#` on top of each line. --- #
    # Gaming
    "Valve.Steam",
    "Discord.Discord",

    # Programming
    "gerardog.gsudo", # Yet another sudo command
    "Microsoft.VisualStudio.2022.BuildTools" # for Rust development

    # --- Optional region ends here --- #
)
foreach ($program in $programs) {
    winget install --id $program --source winget
}

#>

# Run WPD and shutup10
Start-Process -FilePath "$(scoop prefix wpd)\WPD.exe"
Start-Process -FilePath "$(scoop prefix shutup10)\OOSU10.exe"
