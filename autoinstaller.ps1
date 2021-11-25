# Install scoop
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# Setup scoop
scoop install 7zip mingit aria2
scoop update

# Adding buckets
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add games
scoop bucket add nonportable

# Must-Have tools
scoop isntall autohotokey bat bitwarden bottom broot dust fd ffmpeg fzf gitui less lightbulb lsd monolith mpv neovim posh-git ripgrep sd sharex starship sudo sumatrapdf yt-dlp zenhan zoxide

# Programming（Optional from here. You can put `#` on top of the line to disable install）
scoop install deno github julia rustup-mvsc sqlitebrowser

# Gaming
scoop install legendary playnite

# Media
scoop install foobar2000-portable freetube gallery-dl streamlink streamlink-twitch-gui

# Nerd Fonts
sudo scoop install VictorMono-NF FantasqueSansMono-NF-Mono CascadiaCode-NF

# Install with winget
winget install gsudo
winget install LibreWolf.LibreWolf
winget install Microsoft.Powershell
winget install Python.Python.3
winget install Discord.Discord
winget install Valve.Steam
winget install DuongDieuPhap.ImageGlass
winget install Foundry376.Mailspring
