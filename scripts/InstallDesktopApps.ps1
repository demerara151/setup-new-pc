<#
    .SYNOPSIS
    利便性の高いデスクトップアプリをまとめてインストールします。

    .NOTES
    czkawka の GUI は、czkawka 本体がないと動かないため一緒にインストールします。

    .NOTES
    Nvidia のグラボを使ってない方は、ddu と nvcleanstall は不要です。
#>

# Utilities
scoop install autohotkey czkawka czkawka-gui

# Tools to install clean Nvidia Graphics driver
scoop install ddu nvcleanstall

# Chat
scoop install element

# File sharing
scoop install localsend synctrayzor