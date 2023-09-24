<#
    .SYNOPSIS
    動画や音楽を楽しむために必要なソフトやツールをインストールします。

    .DESCRIPTION
    私が普段使っているメディアプレイヤーや編集ソフトをまとめてインストールします。

    .NOTES
    icaros-np があると、Windows では表示されない拡張子（webp や webm 等）のメディアのサムネイルも表示できるようになります。
#>

# Essential media player
scoop install mpv

# Music player
scoop install foobar2000 foobar2000-encoders

# Yet another YouTube client
scoop install freetube

# Media tool
scoop install ffmpeg

## Additional tools
scoop install exifcleaner gallery-dl inkscape losslesscut yt-dlp

## Thumbnails
scoop bucket add nonportable
sudo scoop install icaros-np