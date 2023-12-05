<#
    .SYNOPSIS
    私個人が普段使いしているアプリやツールを一括でインストールします。

    .DESCRIPTION
    全てのカテゴリーのアプリやツールを一括でインストールするスクリプトです。
    カテゴリー別でインストールするスクリプトは同じフォルダー内に配置されています。

    インストールが不要なアプリはノートパッド等でこのスクリプトを開いてアプリ名を削除してください。
    また、インストールコマンド（scoop install ~）の先頭に `#` を付けることでコマンドが実行されないようにコメント化できます。

    インストールが終わると自動的に shutup10 が起動するようになってます。
    Actions > Recommended or somewhat recommended settings をクリックしてください。
    PC のプライバシーやセキュリティ関連の設定がまとめて自動で設定できます。

    .NOTES
    それなりに数があるので、インストールが終わるまでそれなりの時間が掛かります。
    事前に aria2 をインストールしておけばダウンロード速度を増加させることができますが、時々不具合でダウンロードが中断されてしまうことがあります。
    その場合は、ダウンロードが中断したアプリを除外してインストールするか、aria2 を無効化して再度インストールしてください。

    .EXAMPLE
    .\InstallAllApps.ps1
#>

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

## Optional for speedup downloading
# scoop install aria2

# Essential for everyone
scoop install brave crystaldiskinfo everything hwinfo imageglass lightbulb mailspring sharex

# Privacy
scoop install privacy.sexy shutup10

# Security
sudo scoop install keepassxc gpg4win

# --- Optional region starts from here. You can prevent installation by prefixing any line with "#". --- #

# Utility (GUI)
scoop install autohotkey czkawka-gui ddu element localsend nvcleanstall synctrayzor

# Utility (CLI)
scoop install bat bottom broot chezmoi czkawka delta dust everything-cli fd fzf less lsd ripgrep sfsu typos zoxide

## Yet another terminal
scoop install hyper

## Shell customization
scoop install starship terminal-icons

# Dev
scoop install deno love lua lua-language-server marksman omnisharp osv-scanner poetry python rustup sqlitestudio taplo

## Text editor
scoop install helix neovim notable vscode zenhan

# Gaming
scoop install legendary playnite

# Media
scoop install ffmpeg foobar2000 foobar2000-encoders freetube gallery-dl mpv yt-dlp

# Media Tools
scoop install exifcleaner inkscape losslesscut
sudo scoop install icaros-np

# Nerd Fonts
sudo scoop install Delugia-Nerd-Font-Complete IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono JetBrainsMono-NF-Mono Mononoki-NF-Mono --global

# --- Optional region ends here --- #

# Make sure you have winget installed. If not installed, install winget with scoop.
if (!(Get-Command winget -ErrorAction Continue)) { scoop install winget }

# Install some software with winget that cannot be installed with scoop.
$programs = @(
    # Browser
    "LibreWolf.LibreWolf"

    # for Rust development
    "Microsoft.VisualStudio.2022.BuildTools"
)
foreach ($program in $programs) {
    winget install --id $program --source winget
}

# Run shutup10
Start-Process -FilePath "$(scoop prefix shutup10)\OOSU10.exe"
