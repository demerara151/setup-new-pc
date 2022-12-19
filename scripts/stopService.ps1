<#
    .SYNOPSIS
    Stop and disable unnecessary services.

    .DESCRIPTION
    個人的に不要だなと思うサービスを停止し、無効化します。

    メリットは、メモリの使用量をわずかに減らす程度なので、気にしなくてもいいレベルのものです。
    使うことのないサービスが常駐してるのが気持ち悪い人向けです。

    .NOTES
    無効化したくないサービスには、行の先頭に # を付けてください。
    サービス名が並んだ最終行の末尾に、カンマがある場合、取り除いてください。

    Sophia Script や WPD, shutup10 等で無効化されないものだけを並べています。ある意味安全です。
#>

#Requires -RunAsAdministrator

$services = @(
    # 外部デバイス
    "Fax", # ファックス
    "Spooler", # 印刷

    # IPv6
    "iphlpsvc", # IP Helper
    "IpxlatCfgSvc", # IP 変換構成サービス

    # 位置情報
    "lfsvc", # Geo location

    # Xbox関連
    "XboxGipSvc",

    # 標準検索（無効化しても検索はできるし十分速い）
    "WSearch", # Windows search

    # Microsoft Edgeの自動アップデート（常駐型）
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)

if ($PSVersionTable.PSVersion.Major -lt 6) {
    foreach ($name in $services) {
        sudo Set-Service -Name $name -StartupType Disabled -Status Stopped
    }
}
else {
    $services.ForEach{ sudo Set-Service -Name $_ -StartupType Disabled -Status Stopped }
}
