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
scoop install brave everything hwinfo imageglass librewolf lightbulb mailspring sharex

# Privacy
scoop install privacy.sexy shutup10

# <# --- Optional from here. You can disable install by put `#` on top of each line or uncomment out both this line and end line. --- #

# Utility (GUI)
scoop install autohotkey czkawka-gui ddu nvcleanstall synctrayzor

# Shell
scoop install starship terminal-icons zoxide

# Terminal
scoop install hyper

# Utility (CLI)
scoop install aria2 bat bottom broot chezmoi czkawka delta dust everything-cli fd ffsend fzf less lsd ripgrep sfsu sd

# Dev
scoop install brotli deno gitui marksman osv-scanner poetry python ruff rustup sqlitestudio

# Editor
scoop install helix neovim notable vscode zenhan

# Security
sudo scoop install keepassxc gpg4win

# Network
scoop install goodbyedpi localsend

# IM
scoop install element

# Gaming # Steam have to install manually.
scoop install discord heroic-games-launcher legendary playnite

# Media
scoop install ffmpeg foobar2000 foobar2000-encoders freetube gallery-dl mpv-git yt-dlp

# Media Tool
scoop install exifcleaner inkscape losslesscut openshot waifu2x-ncnn-vulkan

# Nerd Fonts
sudo scoop install Delugia-Nerd-Font-Complete IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono JetBrainsMono-NF-Mono Mononoki-NF-Mono --global

# Display various thumbnails
sudo scoop install icaros-np --global

# --- Optional region ends here --- #>

<#

    .NOTES
    Commented out this function since winget source is broken.
    Besides that winget stops working when privacy.sexy strict rules applied.
    winget has a lot of problem in my recent use case. I'm gonna ditch this function in the future.

    .NOTES
    2023/07/08: winget has been doing well lately, so I made some comments and tweaked the programs to install.

    .LINK
    https://github.com/microsoft/winget-cli/issues/2666

# Make sure you have winget installed. If not installed, install winget with scoop.
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install some software with winget that cannot be installed with scoop.
$programs = @(
    # Gaming
    "Valve.Steam",

    # for Rust development
    "Microsoft.VisualStudio.2022.BuildTools"
)
foreach ($program in $programs) {
    winget install --id $program --source winget
}

#>

# Run shutup10
Start-Process -FilePath "$(scoop prefix shutup10)\OOSU10.exe"
