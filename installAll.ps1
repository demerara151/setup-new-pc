# Adding buckets
foreach (
    $bucket in @(
        "extras",
        "games",
        "nerd-fonts",
        "nonportable"
    )
) { scoop bucket add $bucket }

<#
    .DESCRIPTION
    Install all AIO Repack for latest Microsoft Visual C++ Redistributable Runtimes.

    .LINK
    https://github.com/abbodi1406/vcredist
#>
sudo scoop install vcredist-aio
Start-Process -FilePath "$(scoop prefix vcredist-aio)\VisualCppRedist_AIO_x86_x64.exe" /y

# Microsoft Windows Desktop Runtime
sudo scoop install windowsdesktop-runtime-lts

# Essentials
scoop install aria2 autohotkey2 bat bitwarden bottom brave broot czkawka dust everything everything-cli fd ffmpeg ffsend fzf hwinfo imageglass less librewolf lightbulb lsd mailspring mpv neovim pwsh ripgrep sd sharex starship shutup10 terminal-icons wpd zenhan zoxide

# --- Optional from here. You can disable install by put `#` on top of each line. --- #
# Programming
scoop install gitui monolith poetry python rustup-msvc so sqlitebrowser tldr vscode

# Gaming # Steam have to install manually.
scoop install discord legendary playnite heroic-games-launcher

# Media
scoop install exifcleaner foobar2000 foobar2000-encoders freetube gallery-dl losslesscut yt-dlp

# Nerd Fonts
sudo scoop install IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono CascadiaCode-NF-Mono JetBrainsMono-NF-Mono Mononoki-NF-Mono --global

# Display various thumbnails
sudo scoop install icaros-np --global

# --- Optional region ends here --- #

<#

    .NOTES
    winget source is broken rn. so comment out this function for now.
    also winget stops working when privacy.sexy strict rules applied.
    winget has a lot of problem in my recent use case. so I will ditch this in the future.

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
