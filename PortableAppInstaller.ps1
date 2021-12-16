$portable = "$HOME\PortableApps"

If (!(Test-Path $portable)) {
    New-Item -ItemType Directory $portable | Set-Location
}
else {
    Set-Location $portable
}

New-Item -Name WPD -ItemType Directory

Invoke-WebRequest -Uri "https://dforest.watch.impress.co.jp/library/c/clibor/10713/clibor.zip" -OutFile $portable\clibor.zip

Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $portable\wpd\latest.zip

7z x clibor.zip

Set-Location wpd | 7z e latest.zip

Set-Location .. | Get-ChildItem -Include *.zip -Recurse | Remove-Item
