$Services = @(
    "Fax",
    "iphlpsvc", # IP Helper
    "IpxlatCfgSvc", # IP 変換構成サービス
    "lfsvc", # Geo location
    "Spooler", # Print Spooler
    "XboxGipSvc",
    "WSearch", # Windows search
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)
foreach ($name in $Services) {
    sudo Set-Service -Name $name -StartupType Disabled -Status Stopped
}
