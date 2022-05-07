$services = @(
    "Fax",
    #    "iphlpsvc", # IP Helper
    #    "IpxlatCfgSvc", # IP 変換構成サービス
    "lfsvc", # Geo location
    "Spooler", # Print Spooler
    "XboxGipSvc",
    "WSearch", # Windows search
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
