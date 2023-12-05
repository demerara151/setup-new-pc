<#
    .SYNOPSIS
    Windows PC を使う上で必要不可欠なソフトをインストールします。

    .DESCRIPTION
    Windows PC を使う上で、インストールされていないと困る必須ツールをまとめてインストールします。
    ブラウザ、メールクライアント、画像ビューワー、スクショツール、ハードウェアの状態確認ソフト、パスワードマネージャーなど。
    Windows に標準搭載のこれらのアプリは、Sophia Script でアンインストールしてしまうので、これらに取って代わるソフトになってます。

    必要なソフトをインストールし終えたら、自動的に shutup10 が起動するようになってます。
    Actions > Recommended or somewhat recommended settings をクリックしてください。
    PC のプライバシーやセキュリティ関連の設定がまとめて自動で設定できます。

    .NOTES
    gpg4win は一部の技術者向けなので、除外しても構いません。
#>

scoop bucket add extras

<#
    .SYNOPSIS
    Install all AIO Repack for latest Microsoft Visual C++ Redistributable Runtimes.

    .DESCRIPTION
    Microsoft のテレメトリ等を排除して再構築した MVC 再頒布ランタイムのパッケージをまとめてインストールします。
    一部のデスクトップアプリを動かすうえで必須となるアプリケーションです。特に、ブラウザの LibreWolf はこれがないと動きません。
    古いランタイムは主に昔のゲームを動かす時に必要となります。
    このプログラムを実行するとインストール済みのランタイムを一度削除してから、新しいパッケージが自動的にインストールされます。

    .LINK
    https://github.com/abbodi1406/vcredist
#>
sudo scoop install vcredist-aio
Start-Process -FilePath "$(scoop prefix vcredist-aio)\VisualCppRedist_AIO_x86_x64.exe" /y

# Microsoft Windows Desktop Runtime: 主に LightBulb を動かすのに必要
sudo scoop install windowsdesktop-runtime

# Essential for everyone
scoop install brave crystaldiskinfo everything hwinfo imageglass librewolf lightbulb mailspring sharex

# Privacy
scoop install privacy.sexy shutup10

# Security
sudo scoop install keepassxc gpg4win

# Run shutup10
Start-Process -FilePath "$(scoop prefix shutup10)\OOSU10.exe"
