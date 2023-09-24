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
sudo scoop install windowsdesktop-runtime

# Essential for everyone
scoop install brave crystaldiskinfo everything hwinfo imageglass librewolf lightbulb mailspring sharex

# Privacy
scoop install privacy.sexy shutup10

# Security
sudo scoop install keepassxc gpg4win

# --- Optional region starts from here. You can prevent installation by prefixing any line with "#". --- #

# Utility (GUI)
scoop install autohotkey czkawka-gui ddu element localsend nvcleanstall synctrayzor

# Utility (CLI)
scoop install bat bottom broot chezmoi czkawka delta dust everything-cli fd ffsend fzf less lsd ripgrep sfsu zoxide

## Yet another terminal
scoop install hyper

## Shell customization
scoop install starship terminal-icons

# Dev
scoop install deno marksman osv-scanner poetry python rustup sqlitestudio

## Text editor
scoop install helix neovim notable vscode zenhan

# Gaming
scoop install discord heroic-games-launcher legendary playnite

# Media
scoop install ffmpeg foobar2000 foobar2000-encoders freetube gallery-dl mpv yt-dlp

# Media Tools
scoop install exifcleaner inkscape losslesscut
sudo scoop install icaros-np

# Nerd Fonts
sudo scoop install Delugia-Nerd-Font-Complete IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono JetBrainsMono-NF-Mono Mononoki-NF-Mono --global

# --- Optional region ends here --- #

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
