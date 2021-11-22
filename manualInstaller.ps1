$portable = "$HOME\PortableApps"

If (!(Test-Path $portable)) {
    New-Item -ItemType Directory $portable | Set-Location
}
else {
    Set-Location $portable
}

('ES', 'WPD').ForEach{ New-Item -Name $_ -ItemType Directory}

Invoke-WebRequest -Uri "https://dforest.watch.impress.co.jp/library/c/clibor/10713/clibor.zip" -OutFile $portable\clibor.zip

Invoke-WebRequest -Uri "https://www.voidtools.com/ES-1.1.0.20.zip" -OutFile $portable\ES\ES-1.1.0.20.zip

Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $portable\wpd\latest.zip

Write-Output `n'$env:Path+=";$HOME\PortableApps\ES"' >> $Profile
'$env:Path+=";$HOME\PortableApps\wpd"' >> $Profile

7z x clibor.zip

Set-Location ES | 7z e ES-1.1.0.20.zip

Set-Location ../wpd | 7z e latest.zip

Set-Location .. | Get-ChildItem -Include *.zip -Recurse | Remove-Item

Write-Output `n"Note: You need to restart Powershell to apply chaneges"
