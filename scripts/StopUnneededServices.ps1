<#
    .SYNOPSIS
    個人的に不要なサービスを停止し、無効化します

    .DESCRIPTION
    サービスを停止し、無効化するメリット:

    - セキュリティの向上
    - プライバシーの保護
    - メモリ使用量の削減

    .NOTES
    無効化したくないサービスには、サービス名の先頭に # を付けてください

    このスクリプトの実行には管理者権限が必要です

    Program Compatibility Service を無効にすると古いゲーム等が遊べなくなる可能性があります。 Windows 11 と互換性のないソフトを利用する予定がある場合は無効化しないことをおすすめします

    その他、各サービスの詳細は以下のページをご覧ください

    .LINK
    各サービスの詳細: https://github.com/demerara151/setup-new-pc/wiki/Services

    .LINK
    Reference:
    https://nerdschalk.com/what-windows-11-services-to-disable-safely-and-how/
#>

#Requires -RunAsAdministrator

[string[]]$services = @(
    # Fax
    "Fax"

    # Print Spooler
    "Spooler"

    # IP Helper
    "iphlpsvc"

    # IP 変換構成サービス
    "IpxlatCfgSvc"

    # Network Connectivity Assistant
    "NcaSvc"

    # Geo Location
    "lfsvc"

    # Windows search
    "WSearch"

    # Microsoft Edge Elevation Service
    "MicrosoftEdgeElevationService"

    # Microsoft Edge Update Service
    "edgeupdate"

    # Microsoft Edge Update Service
    "edgeupdatem"

    # Connected User Experiences and Telemetry.
    "DiagTrack"

    # AllJoyn Router Service.
    "AxInstSV"

    # Program Compatibility Assistant Service
    "PcaSvc"

    # デバイス管理ワイヤレス アプリケーション プロトコル (WAP) プッシュ メッセージ ルーティング サービス
	"dmwappushservice"

    # Remote Registry.
    "Remote Registry"

    # Windows Image Acquisition.
    "StiSvc"

    # Xbox Accessory Management Service
    "XboxGipSvc",

    # Xbox Live Auth Manager.
    "XblAuthManager"

    # Xbox Live Game Save Service
    "XblGameSave"

    # Xbox Live Networking Service
    "XboxNetApiSvc"

    # Windows Network Data Usage Monitor
    "DusmSvc"

    # Windows Insider Service.
	#"wisvc"
)

$services.ForEach{ Write-Output "Trying to disable $_"; Get-Service -Name $_ | Set-Service -StartupType Disabled -Status Stopped }
