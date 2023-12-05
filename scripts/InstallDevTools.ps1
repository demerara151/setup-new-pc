<#
    .SYNOPSIS
    開発者向けのツールをまとめてインストールします。

    .DESCRIPTION
    Python と Rust の開発環境に必要なソフトやツールをまとめてインストールします。
    エディターやフォントには私個人の好みが強く反映されているため、各自必要に応じて書き換えてください。
    例：vscode -> pycharm, neovim -> emacs など。

    .NOTES
    コメント先頭の `#` が 1 つのものは必須、2 つのものは個人の趣味によるところが大きいと思うものです。

    .NOTES
    Rust の開発に必要なビルドツールはウェブサイトから直接ダウンロードしてインストールするか、winget でインストールしてください。
#>

# Utility (CLI)
scoop install bat bottom broot chezmoi czkawka delta dust everything-cli fd fzf less lsd ripgrep sfsu zoxide

## Yet another terminal
scoop install hyper

## Shell customization
scoop install starship terminal-icons

# Programming language
scoop install deno love lua python rustup

# Package manager for Python
scoop install poetry

## LSP
scoop install lua-language-server marksman omnisharp ruff taplo

## Additional tools
scoop install osv-scanner sqlitestudio typos

## Text editor
scoop install helix neovim notable vscode zenhan

## Nerd Fonts
scoop bucket add nerd-fonts
sudo scoop install Delugia-Nerd-Font-Complete IBMPlexSans-JP VictorMono-NF-Mono FantasqueSansMono-NF-Mono JetBrainsMono-NF-Mono Mononoki-NF-Mono --global

# BuildTools for Rust and .NET
winget install --id Microsoft.VisualStudio.2022.BuildTools --source winget