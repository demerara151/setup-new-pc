# Install scoop
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
scoop install autohotkey bat bitwarden bottom broot dust fd ffmpeg fzf gitui less lightbulb lsd monolith mpv neovim posh-git ripgrep sd sharex starship sudo sumatrapdf yt-dlp zenhan zoxide

# Nerd Fonts
sudo scoop install FantasqueSansMono-NF-Mono

# Install with winget
winget install gsudo
winget install DuongDieuPhap.ImageGlass
