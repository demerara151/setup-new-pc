# ポリシーの変更
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# scoopのインストール
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# 初期化
scoop install 7zip git
scoop update *

# バケットの追加
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add games
scoop bucket add nonportable

# まとめてインストール
scoop install aria2 autohotkey bat bitwarden bottom broot ccleaner curl deepl deno dust everything exifcleaner fd ffmpeg flac foobar2000 freetube fzf gallery-dl gimp github gitui hwinfo imageglass julia less lightbulb losslesscut lsd mailspring mpv neovim nu playnite python ripgrep sd sharex sqlitebrowser starship streamlink streamlink-twitch-gui sudo sumatrapdf tldr touch trilium typora ungoogled-chromium vscodium-portable waterfox-current zenhan zoxide

# 管理者権限が必要なもの
sudo scoop install vcredist2015 vcredist2019 victor-mono icaros-np Meslo-NF FantasqueSansMono-NF-Mono CascadiaCode-NF

# pipによるインストール
python -m pip install flake8 black yt-dlp legendary-gl

# windows-terminalのインストール及び設定
# 本体のインストール
scoop install windows-terminal

# posh-gitのインストール
scoop install posh-git

# posh-gitの設定
Add-PoshGitToProfile
