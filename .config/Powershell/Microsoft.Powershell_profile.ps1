Import-Module -Name posh-git
Import-Module Terminal-Icons

# starship initialization
Invoke-Expression (&starship init powershell)

Set-Alias -Name vim -Value nvim
Set-Alias -Name br -Value broot
Set-Alias -Name mt -Value marktext

# Global variables
$inputFile = "$HOME/list.txt"
$CONFIG = "$HOME/.config"

# simple back command
function .. () { Set-Location .. }
function home () { Set-Location $HOME/home }

# Program ShortCut
function mail () { Start-Process "$env:LOCALAPPDATA\Mailspring\mailspring.exe" }
function lw () { Start-Process "$env:ProgramFiles\LibreWolf\librewolf.exe" $args }
function fo () { Start-Process "$(scoop prefix foobar2000)\foobar2000.exe" }
function dis (
    [string]$option = "--processStart Discord.exe"
) {
    Start-Process "$env:LOCALAPPDATA\Discord\Update.exe" $option
}
function manga () { Start-Process "$HOME\home\apps\NeeView39.3\NeeView.exe" }

# Update All Programs
function up () { winget upgrade --all; sudo scoop update *; sudo scoop update * --global }

# Launch privacy apps
function privacy () {
    Start-Process "$env:USERPROFILE\home\apps\wpd\WPD.exe";
    Start-Process "$(scoop prefix shutup10)\OOSU10.exe"
}

# Play music without video. uri will be video link or m3u8 playlist.
function mnv ([string]$uri) {
    mpv --no-video $args $uri
}

# Play white noise
function noise () {
    mpv --no-video --no-resume-playback $args "https://youtu.be/mkKZvOG9B1c"
}

# Shuffle playlist, then play music from playlist.
function msfl () {
    $pl = $(fd -t f . $HOME\home\music)
    $file = "D:\.cache\YoutubeMusic\_playlist.m3u8"
    Get-Random $pl -Count $pl.Length > $file; mpv --no-video --playlist=$file
}

# Edit history data
$history = @(
    "$env:LOCALAPPDATA/nushell/history.txt"
    "$env:APPDATA/Microsoft/Windows/Powershell/PSReadLine/ConsoleHost_history.txt"
)
function clh () { nvim $history }

# Update python packages using pip
function ppu () { python -m pip install -U $args }
function ppr () { python -m pip freeze > requirements.txt }

# Run python file using poetry
function prun ([string]$file = "src.main") {
    poetry run python -m $file $args
}

# Alias for lsd
function ll () {
    lsd -lAL --blocks permission --blocks date --blocks size --blocks name --blocks inode --date '+%Y/%m/%d %X' -I desktop.ini $args
}

# Preview fzf result using bat
function fzfp () {
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
}

# monolith
function mono ([string]$name) {
    monolith --no-js --no-frames --no-metadata --no-fonts --no-video --output D:/Downloads/$name.html $args
}

# Create symbolic link
function sym ([string]$path, [string]$target) {
    sudo New-Item -ItemType SymbolicLink -Path $path -Target $target
}

# Downloaders
function yt ([string]$case = "max") {
    yt-dlp --config-location $CONFIG/yt-dlp/$case.conf
}
function gld () {
    gallery-dl --input-file $inputFile --destination D:/Pictures/gallery-dl --no-mtime $args
}
function aria () {
    aria2c --conf-path=$CONFIG/aria2.conf -d "D:/Downloads" -x16 -j16 -s16 -k1M -i $inputFile
}

# Open list.txt to edit URL for various downloaders
function list () { nvim $inputFile }

# Open config file
function Edit-MyConfig ([string]$filename = "ps") {
    $case = @{
        vim = 'nvim\init.vim'
        mpv = 'mpv.conf'
        ps  = 'Powershell\Microsoft.Powershell_profile.ps1'
    }
    nvim $CONFIG\$($case[$filename])
}

# Get process name if that has title
function psn () {
    Get-Process | Where-Object { $_.mainWindowTitle } | Format-Table Id, Name, mainWindowtitle -AutoSize
}

# Check disk commands
function dismexe () { sudo Dism.exe /Online /Cleanup-Image /RestoreHealth }
function scannow () { sudo sfc /scannow }

# zoxide
Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
    })

# winget completion
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
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

# Exclude Save-History settigs
Set-PSReadLineOption -AddToHistoryHandler {
    param ($command)
    switch -regex ($command) {
        "SKIPHISTORY" { return $false }
        "^[a-z]$" { return $false }
        "exit" { return $false }
        "cls" { return $false }
        "ll" { return $false }
        "ren" { return $false }
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
