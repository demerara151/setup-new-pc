<#
    .SYNOPSIS
    ゲーム関連ソフトをインストールします

    .DESCRIPTION
    PC でゲームを遊ぶ上で私が普段使っているソフトやツールをまとめてインストールします

    .NOTES
    2023/12/05 最近は Celeste と麻雀くらいしか遊んでないので、Heroic と Steam は除外しました。legendary も今のとこ必要ありませんが、今後何か興味がそそられる無料配布が来た時用に取っておくことにします
#>

scoop bucket add games

# EpicGamesLauncher alternative
scoop install legendary

# Game manager
scoop install playnite