Import-Module -Name posh-git
Import-Module Terminal-Icons

# starship
Invoke-Expression (&starship init powershell)

# Exact match when use `zi` (zoxide + fzf) command.
$env:_ZO_FZF_OPTS = "--exact"

# zoxide
Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
    })

# CONSTANTS
$LIST = "$HOME\list.txt"
$CONFIG = "$HOME\.config"

# Aliases
Set-Alias -Name br -Value broot
Set-Alias -Name mt -Value marktext
Set-Alias -Name vim -Value nvim
Set-Alias -Name foo -Value foobar2000
Set-Alias -Name mail -Value mailspring
Set-Alias -Name lw -Value "$env:ProgramFiles\LibreWolf\librewolf.exe"

# Manga reader. See https://bitbucket.org/neelabo/neeview/wiki/Home
Set-Alias -Name manga -Value "$HOME\home\apps\NeeView39.5-x64\NeeView.exe"

# Utility
function .. { Set-Location .. }
function home { Set-Location $HOME/home }
function list { nvim $LIST }
function up { sudo scoop update *; sudo scoop update * --global }
function clh { nvim "$env:APPDATA/Microsoft/Windows/Powershell/PSReadLine/ConsoleHost_history.txt" }

# Check disk command
function dismexe () { sudo Dism.exe /Online /Cleanup-Image /RestoreHealth }
function scannow () { sudo sfc /scannow }

# Alias for various command
function ll {
    # lsd with additional information
    lsd --long --almost-all --dereference --group-directories-first --blocks date --blocks size --blocks name --blocks inode --date '+%Y/%m/%d %X' -I desktop.ini $args
}
function fzfp {
    # Preview fzf result using bat
    fzf --preview="bat --color=always --style=numbers --line-range=:500 {}"
}
function psn {
    # Get process name if that has title
    Get-Process | Where-Object { $_.mainWindowTitle } | Format-Table Id, Name, mainWindowtitle -AutoSize
}

function mnv ([string]$uri) {
    mpv --no-video --no-resume-playback $args $uri
    <#
        .SYNOPSIS
        Play music without video.

        .PARAMETER uri
        URL or m3u8 playlist.

        .EXAMPLE
        mnv https://music.youtube.com/playlist?list=OLAK5uy_mwpOUfoLWybXalD2eksUMiwoi-_9a3aDA

        .EXAMPLE
        mnv --shuffle $HOME\home\music\m3u8\LOVEBITES\*.m3u8
    #>
}

function msfl {
    param (
        [string[]]$source = $(fd -t f -e .m3u8 . $HOME\home\music\m3u8),
        [bool]$all = $false
    )
    if ($all) {
        param(
            [string]$playlist = "D:\.cache\YoutubeMusic\_playlist.m3u8"
        )
        Get-Random $source -Count $source.Length > $playlist; mpv --no-video --playlist=$playlist
    }
    else {
        mpv --no-video $($source | Get-Random)
    }
    <#
        .SYNOPSIS
        Shuffle playlist, then play music from the playlist.

        .PARAMETER source
        List of the m3u8 playlist path.
        They are must be Full-Path.

        .PARAMETER all
        If you use `-all` option, it stores playlist in $playlist and plays music from the file.

        .PARAMETER playlist
        The path where to store temporally playlist file to play the music with mpv.
        This param is also must be a Full-Path and can only used with `-all` option.

        .EXAMPLE
        msfl

        This command plays a random album from default path.

        .EXAMPLE
        msfl -all -playlist "D:/tmp/tmp.m3u8"

        Store playlists in "D:/tmp/tmp.m3u8", then mpv plays the music from the file.
    #>
}

function mono {
    param (
        [Parameter(Mandatory)]
        [string]$url,
        [string]$filename = "index"
    )
    monolith --no-js --no-frames --no-metadata --no-fonts --no-video --output "D:/Downloads/$filename.html" $url
    <#
        .SYNOPSIS
        Download HTML file from web site using monolith.

        .PARAMETER url
        URL of web site.

        .PARAMETER filename
        File name for download content.
    #>
}

function sym {
    param (
        [Parameter(Mandatory)]
        [string]$path,
        [string]$target
    )
    sudo New-Item -ItemType SymbolicLink -Path $path -Target $target
    <#
        .SYNOPSIS
        Create symbolic link.

        .PARAMETER path
        File path that you want to create symbolic link.

        .PARAMETER target
        Original file of symbolic link that already exists.

        .EXAMPLE
        sym D:/symlinks/profile.ps1 $PROFILE

        Create sym link of $PROFILE in "D:/symlinks" and file name is "profile.ps1"
    #>
}

function yt {
    param(
        [ValidateSet("hls", "audio", "norm", "yt", "max", "safe")]
        $case = "hls"
    )
    yt-dlp --config-location "$CONFIG/yt-dlp/$case.conf"
    <#
        .SYNOPSIS
        Download media from various web sites using yt-dlp.

        .PARAMETER case
        Set the config profile by use case. Default use case is "hls".

        .EXAMPLE
        yt audio

        This command will start to download audio file listed in the $LIST.
    #>
}

function aria {
    param(
        # Directory where you want to download content.
        [string]$dir = "$HOME/home/videos/temp"
    )
    aria2c --conf-path="$CONFIG/aria2.conf" -d $dir -x6 -j6 -s6 -k1M -i $LIST
}

function gld {
    gallery-dl --input-file $LIST --destination D:/Pictures/gallery-dl --no-mtime $args
}

function Edit-MyConfig {
    param(
        [ValidateSet("mpv", "vim", "ps")]
        [string]$filename = "ps"
    )
    $case = @{
        mpv = 'mpv.conf'
        vim = 'nvim\init.vim'
        ps  = 'Powershell\Microsoft.Powershell_profile.ps1'
    }
    nvim $CONFIG\$($case[$filename])
    <#
        .SYNOPSIS
        Open specific config file in "~/.config".

        .EXAMPLE
        Edit-MyConfig mpv

        It opens mpv config file (mpv.conf) in "~/.config".
    #>
}

# Using utf-8 encoding to write data with directors: ">" or ">>"
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# Read Line Option
$PSReadLineOptions = @{
    EditMode            = "Vi"
    # Do not store duplicate history
    HistoryNoDuplicates = $true
    # Prediction Intellisense
    PredictionSource    = "History"
    WordDelimiters      = ";:,.[]{}()/\|^&*-=+'`"!?@#$%&_<>「」（）『』『』［］、，。：；／"
}
Set-PSReadLineOption @PSReadLineOptions

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewline "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewline "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Exclude Save-History settings
Set-PSReadLineOption -AddToHistoryHandler {
    param ($command)
    switch -regex ($command) {
        "SKIPHISTORY" { return $false }
        "^[a-z]$" { return $false } # a single word
        "es" { return $false }
        "mv" { return $false }
        "rm" { return $false }
        "del" { return $false }
        "ren" { return $false }
        "mpv" { return $false }
        "ffprobe" { return $false }
    }
    return $true
}

# Brackets auto close
Set-PSReadLineKeyHandler -Key "(", "{", "[" -BriefDescription "InsertPairedBraces" -LongDescription "Insert matching braces or wrap selection by matching braces" -ScriptBlock {
    param($key, $arg)
    $openChar = $key.KeyChar
    $closeChar = switch ($openChar) {
        <#case#> "(" { [char]")"; break }
        <#case#> "{" { [char]"}"; break }
        <#case#> "[" { [char]"]"; break }
    }

    $selectionStart = $null
    $selectionLength = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($selectionStart -ne -1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $openChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
        return
    }
    $nOpen = [regex]::Matches($line, [regex]::Escape($openChar)).Count
    $nClose = [regex]::Matches($line, [regex]::Escape($closeChar)).Count
    if ($nOpen -ne $nClose) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($openChar)
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($openChar + $closeChar)
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
    }
}

Set-PSReadLineKeyHandler -Key ")", "]", "}" -BriefDescription "SmartCloseBraces" -LongDescription "Insert closing brace or skip" -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($line[$cursor] -eq $key.KeyChar) {
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($key.KeyChar)
    }
}

Set-PSReadLineKeyHandler -Key "`"", "'" -BriefDescription "smartQuotation" -LongDescription "Put quotation marks and move the cursor between them or put marks around the selection" -ScriptBlock {
    param($key, $arg)
    $mark = $key.KeyChar

    $selectionStart = $null
    $selectionLength = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($selectionStart -ne -1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $mark + $line.SubString($selectionStart, $selectionLength) + $mark)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
        return
    }

    if ($line[$cursor] -eq $mark) {
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
        return
    }

    $nMark = [regex]::Matches($line, $mark).Count
    if ($nMark % 2 -eq 1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($mark)
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($mark + $mark)
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
    }
}

# Auto insert brackets when cursor is on the word
Set-PSReadLineKeyHandler -Key "alt+w" -BriefDescription "WrapLineByParenthesis" -LongDescription "Wrap the entire line and move the cursor after the closing parenthesis or wrap selected string" -ScriptBlock {
    $selectionStart = $null
    $selectionLength = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    if ($selectionStart -ne -1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, "(" + $line.SubString($selectionStart, $selectionLength) + ")")
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
        [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
    }
}

# Insert closing paren
Remove-PSReadLineKeyHandler "tab"
Set-PSReadLineKeyHandler -Key "tab" -BriefDescription "smartNextCompletion" -LongDescription "insert closing parenthesis in forward completion of method" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($line[($cursor - 1)] -eq "(") {
        if ($line[$cursor] -ne ")") {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert(")")
            [Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
        }
    }
}

Remove-PSReadLineKeyHandler "shift+tab"
Set-PSReadLineKeyHandler -Key "shift+tab" -BriefDescription "smartPreviousCompletion" -LongDescription "insert closing parenthesis in backward completion of method" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::TabCompletePrevious()
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($line[($cursor - 1)] -eq "(") {
        if ($line[$cursor] -ne ")") {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert(")")
            [Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
        }
    }
}

# Add refresh $PROFILE function
Set-PSReadLineKeyHandler -Key "alt+r" -BriefDescription "reloadPROFILE" -LongDescription "reloadPROFILE" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('<#SKIPHISTORY#> . $PROFILE')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# Yank last args as variable
Set-PSReadLineKeyHandler -Key "alt+a" -BriefDescription "yankLastArgAsVariable" -LongDescription "yankLastArgAsVariable" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$")
    [Microsoft.PowerShell.PSConsoleReadLine]::YankLastArg()
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    if ($line -match '\$\$') {
        $newLine = $line -replace '\$\$', "$"
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $newLine)
    }
}
