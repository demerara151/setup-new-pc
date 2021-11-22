# ポリシーの変更
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# scoopのインストール
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# 初期化
scoop install 7zip mingit
scoop update *

# バケットの追加
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add games
scoop bucket add nonportable

# まとめてインストール
scoop install aria2 autohotkey bat bitwarden bottom broot ccleaner curl deno dust everything exifcleaner fd ffmpeg flac foobar2000 freetube fzf gallery-dl gimp github gitui hwinfo imageglass julia legendary less lightbulb losslesscut lsd mailspring monolith mpv neovim nu playnite powertoys posh-git python pwsh ripgrep sd sharex sqlitebrowser starship streamlink streamlink-twitch-gui sudo sumatrapdf tldr touch trilium typora ungoogled-chromium vscodium-portable waterfox-current yt-dlp zenhan zoxide

# 管理者権限が必要なもの
sudo scoop install icaros-np VictorMono-NF FantasqueSansMono-NF-Mono CascadiaCode-NF

# wingetによるインストール
sudo winget install Discord.Discord
sudo winget install Valve.Steam
sudo winget install LibreWolf.LibreWolf

# posh-gitの設定
Add-PoshGitToProfile
