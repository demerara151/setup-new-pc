$Services = @(
    "Fax",
    "iphlpsvc",
    "IpxlatCfgSvc",
    "lfsvc",
    "Spooler",
    "XboxGipSvc",
    "WSearch",
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)
foreach ($name in $Services) {
    sudo Set-Service -Name $name -StartupType Disabled -Status Stopped
}
