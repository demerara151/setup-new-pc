<#
    .SYNOPSIS
    ゲーム関連ソフトをインストールします。

    .DESCRIPTION
    PC でゲームを遊ぶ上で私が普段使っているソフトやツールをまとめてインストールします。

    .NOTES
    Steam は公式サイトから直接ダウンロードしてインストールするか、winget でインストールしてください。
#>

scoop bucket add games

# Chat
scoop install discord

# EpicGamesLauncher alternative
scoop install heroic-games-launcher legendary

# Game manager
scoop install playnite

# Steam client
# winget install --id Valve.Steam --source winget