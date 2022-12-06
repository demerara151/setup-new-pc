<#
	.SYNOPSIS
	The TAB completion for functions and their arguments

	Version: v6.2.4
	Date: 04.12.2022

	Copyright (c) 2014—2022 farag
	Copyright (c) 2019—2022 farag & Inestic

	Thanks to all https://forum.ru-board.com members involved

	.DESCRIPTION
	Dot source the script first: . .\Function.ps1 (with a dot at the beginning)
	Start typing any characters contained in the function's name or its arguments, and press the TAB button

	.EXAMPLE
	Sophia -Functions <tab>
	Sophia -Functions temp<tab>
	Sophia -Functions "DiagTrackService -Disable", "DiagnosticDataLevel -Minimal", UninstallUWPApps

	.NOTES
	Use commas to separate funtions

	.LINK
	https://github.com/farag2/Sophia-Script-for-Windows
#>

#Requires -RunAsAdministrator
#Requires -Version 7.3

function Sophia
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $false)]
		[string[]]
		$Functions
	)

	foreach ($Function in $Functions)
	{
		Invoke-Expression -Command $Function
	}

	# The "RefreshEnvironment" and "Errors" functions will be executed at the end
	Invoke-Command -ScriptBlock {RefreshEnvironment; Errors}
}

Clear-Host

$Host.UI.RawUI.WindowTitle = "Sophia Script for Windows 11 v6.2.3 | Made with $([char]::ConvertFromUtf32(0x1F497)) of Windows | $([char]0x00A9) farag & Inestic, 2014$([char]0x2013)2022"

Remove-Module -Name Sophia -Force -ErrorAction Ignore
Import-Module -Name $PSScriptRoot\Manifest\Sophia.psd1 -PassThru -Force

try
{
	Import-LocalizedData -BindingVariable Global:Localization -UICulture $PSUICulture -BaseDirectory $PSScriptRoot\Localizations -FileName Sophia -ErrorAction Stop
}
catch
{
	Import-LocalizedData -BindingVariable Global:Localization -UICulture en-US -BaseDirectory $PSScriptRoot\Localizations -FileName Sophia
}

# The mandatory checks. Please, do not comment out this function
Checks

$Parameters = @{
	CommandName   = "Sophia"
	ParameterName = "Functions"
	ScriptBlock   = {
		param
		(
			$commandName,
			$parameterName,
			$wordToComplete,
			$commandAst,
			$fakeBoundParameters
		)

		# Get functions list with arguments to complete
		$Commands = (Get-Module -Name Sophia).ExportedCommands.Keys
		foreach ($Command in $Commands)
		{
			$ParameterSets = (Get-Command -Name $Command).Parametersets.Parameters | Where-Object -FilterScript {$null -eq $_.Attributes.AliasNames}

			# If a module command is UnpinTaskbarShortcuts
			if ($Command -eq "UnpinTaskbarShortcuts")
			{
				# Get all command arguments, excluding defaults
				foreach ($ParameterSet in $ParameterSets.Name)
				{
					# If an argument is Shortcuts
					if ($ParameterSet -eq "Shortcuts")
					{
						$ValidValues = ((Get-Command -Name UnpinTaskbarShortcuts).Parametersets.Parameters | Where-Object -FilterScript {$null -eq $_.Attributes.AliasNames}).Attributes.ValidValues
						foreach ($ValidValue in $ValidValues)
						{
							# The "UnpinTaskbarShortcuts -Shortcuts <function>" construction
							"UnpinTaskbarShortcuts" + " " + "-" + $ParameterSet + " " + $ValidValue | Where-Object -FilterScript {$_ -like "*$wordToComplete*"} | ForEach-Object -Process {"`"$_`""}
						}

						# The "UnpinTaskbarShortcuts -Shortcuts <functions>" construction
						"UnpinTaskbarShortcuts" + " " + "-" + $ParameterSet + " " + ($ValidValues -join ", ") | Where-Object -FilterScript {$_ -like "*$wordToComplete*"} | ForEach-Object -Process {"`"$_`""}
					}

					continue
				}
			}

			# If a module command is UninstallUWPApps
			if ($Command -eq "UninstallUWPApps")
			{
				(Get-Command -Name $Command).Name | Where-Object -FilterScript {$_ -like "*$wordToComplete*"}

				# Get all command arguments, excluding defaults
				foreach ($ParameterSet in $ParameterSets.Name)
				{
					# If an argument is ForAllUsers
					if ($ParameterSet -eq "ForAllUsers")
					{
						# The "UninstallUWPApps -ForAllUsers" construction
						"UninstallUWPApps" + " " + "-" + $ParameterSet | Where-Object -FilterScript {$_ -like "*$wordToComplete*"} | ForEach-Object -Process {"`"$_`""}
					}

					continue
				}
			}

			# If a module command is DNSoverHTTPS
			if ($Command -eq "DNSoverHTTPS")
			{
				(Get-Command -Name $Command).Name | Where-Object -FilterScript {$_ -like "*$wordToComplete*"}

				# Get the valid IPv4 addresses array
				# ((Get-Command -Name DNSoverHTTPS).Parametersets.Parameters | Where-Object -FilterScript {$null -eq $_.Attributes.AliasNames}).Attributes.ValidValues | Select-Object -Unique
				$ValidValues = @((Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers).PSChildName) | Where-Object {$_ -notmatch ":"}
				foreach ($ValidValue in $ValidValues)
				{
					$ValidValuesDescending = @((Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers).PSChildName) | Where-Object {$_ -notmatch ":"}
					foreach ($ValidValueDescending in $ValidValuesDescending)
					{
						# The "DNSoverHTTPS -Enable -PrimaryDNS x.x.x.x -SecondaryDNS x.x.x.x" construction
						"DNSoverHTTPS -Enable -PrimaryDNS $ValidValue -SecondaryDNS $ValidValueDescending" | Where-Object -FilterScript {$_ -like "*$wordToComplete*"} | ForEach-Object -Process {"`"$_`""}
					}
				}
			}

			foreach ($ParameterSet in $ParameterSets.Name)
			{
				# The "Function -Argument" construction
				$Command + " " + "-" + $ParameterSet | Where-Object -FilterScript {$_ -like "*$wordToComplete*"} | ForEach-Object -Process {"`"$_`""}

				continue
			}

			# Get functions list without arguments to complete
			Get-Command -Name $Command | Where-Object -FilterScript {$null -eq $_.Parametersets.Parameters} | Where-Object -FilterScript {$_.Name -like "*$wordToComplete*"}

			continue
		}
	}
}
Register-ArgumentCompleter @Parameters

Write-Information -MessageData "" -InformationAction Continue
Write-Verbose -Message "Sophia -Functions <tab>" -Verbose
Write-Verbose -Message "Sophia -Functions temp<tab>" -Verbose
Write-Verbose -Message "Sophia -Functions `"DiagTrackService -Disable`", `"DiagnosticDataLevel -Minimal`", UninstallUWPApps" -Verbose
Write-Information -MessageData "" -InformationAction Continue
Write-Verbose -Message "UninstallUWPApps, `"PinToStart -UnpinAll`"" -Verbose
Write-Verbose -Message "`"Set-Association -ProgramPath ```"%ProgramFiles%\Notepad++\notepad++.exe```" -Extension .txt -Icon ```"%ProgramFiles%\Notepad++\notepad++.exe,0```"`"" -Verbose

# SIG # Begin signature block
# MIIblQYJKoZIhvcNAQcCoIIbhjCCG4ICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUQPlQss+5OE6PmQCnIsGDxVVQ
# M6GgghYNMIIDAjCCAeqgAwIBAgIQecfrGhsNi7VEHWuRpLke9jANBgkqhkiG9w0B
# AQsFADAZMRcwFQYDVQQDDA5Tb3BoaWEgUHJvamVjdDAeFw0yMjEyMDQxNTA1NTla
# Fw0yNDEyMDQxNTE1NDlaMBkxFzAVBgNVBAMMDlNvcGhpYSBQcm9qZWN0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5SerjAkErXu1FSNeI7GabOfnQi2j
# FbXeA6F4eGLh3f40oAyoXXNVXOjVd55lymMOAcfYzGUK1Ss6AnkzelIvbqUUU4ig
# mHZg0GuS4u3PyOFTcIctM0atpHgpJqaWMixdPEw2QLv8TtLc65b34vZ1bZUNB/gu
# E6KCejwio8Ivgzzie9oXiDzhiEBeeUwgQtYD5I9PpTvh5JOtMHMR6IHcXqT/QXtw
# uKNPZG3bJSR+X1yaT2zPTZcM/tAHytew9IfDUZoIFahxBkh3pcfKWZFNxAg6WE4v
# /dEVmraLqUOxtKPc1eT8Ynho2BlyohBSCk46P5ZHZ7/LKGL19t6nOeHIrQIDAQAB
# o0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0O
# BBYEFPqjpH3sL+M7WsV2ZrOW/d4a6tbxMA0GCSqGSIb3DQEBCwUAA4IBAQBKpMDN
# 5TVp8XVJOLa0bKNiKiEzko7D77dOMW9XmdcSlZWaGWn2q51I03RX8JhdZVaAV6ff
# p5wBj1j67E1GRTUXESwW2o+2r9OC32O+EPb+Gc1myifV5fmfGkhBh17+S/7JBzBy
# KqCgvQqaE0aRffSyf/tPa55IslDv63bpGHJu5r+v4rO/NBhObQ2hmzySTpbMBpi9
# VdLJFrNQ99O0HSK7fm5PO9zbU9Rl4ERSEAjGceWJVv3sziS5Sa2cLX1ft01Lsl5v
# Fu8LWgJGU3X1eOvzZn7bH30qBFbZUOLgYHs+VDNCYjK4zVmCZ1s77euZi6BV9rO+
# drbKz3OdYQeGmAhfMIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkq
# hkiG9w0BAQwFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5j
# MRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBB
# c3N1cmVkIElEIFJvb3QgQ0EwHhcNMjIwODAxMDAwMDAwWhcNMzExMTA5MjM1OTU5
# WjBiMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQL
# ExB3d3cuZGlnaWNlcnQuY29tMSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJv
# b3QgRzQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC/5pBzaN675F1K
# PDAiMGkz7MKnJS7JIT3yithZwuEppz1Yq3aaza57G4QNxDAf8xukOBbrVsaXbR2r
# snnyyhHS5F/WBTxSD1Ifxp4VpX6+n6lXFllVcq9ok3DCsrp1mWpzMpTREEQQLt+C
# 8weE5nQ7bXHiLQwb7iDVySAdYyktzuxeTsiT+CFhmzTrBcZe7FsavOvJz82sNEBf
# sXpm7nfISKhmV1efVFiODCu3T6cw2Vbuyntd463JT17lNecxy9qTXtyOj4DatpGY
# QJB5w3jHtrHEtWoYOAMQjdjUN6QuBX2I9YI+EJFwq1WCQTLX2wRzKm6RAXwhTNS8
# rhsDdV14Ztk6MUSaM0C/CNdaSaTC5qmgZ92kJ7yhTzm1EVgX9yRcRo9k98FpiHaY
# dj1ZXUJ2h4mXaXpI8OCiEhtmmnTK3kse5w5jrubU75KSOp493ADkRSWJtppEGSt+
# wJS00mFt6zPZxd9LBADMfRyVw4/3IbKyEbe7f/LVjHAsQWCqsWMYRJUadmJ+9oCw
# ++hkpjPRiQfhvbfmQ6QYuKZ3AeEPlAwhHbJUKSWJbOUOUlFHdL4mrLZBdd56rF+N
# P8m800ERElvlEFDrMcXKchYiCd98THU/Y+whX8QgUWtvsauGi0/C1kVfnSD8oR7F
# wI+isX4KJpn15GkvmB0t9dmpsh3lGwIDAQABo4IBOjCCATYwDwYDVR0TAQH/BAUw
# AwEB/zAdBgNVHQ4EFgQU7NfjgtJxXWRM3y5nP+e6mK4cD08wHwYDVR0jBBgwFoAU
# Reuir/SSy4IxLVGLp6chnfNtyA8wDgYDVR0PAQH/BAQDAgGGMHkGCCsGAQUFBwEB
# BG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsG
# AQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
# cmVkSURSb290Q0EuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRp
# Z2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwEQYDVR0gBAow
# CDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IBAQBwoL9DXFXnOF+go3QbPbYW1/e/
# Vwe9mqyhhyzshV6pGrsi+IcaaVQi7aSId229GhT0E0p6Ly23OO/0/4C5+KH38nLe
# JLxSA8hO0Cre+i1Wz/n096wwepqLsl7Uz9FDRJtDIeuWcqFItJnLnU+nBgMTdydE
# 1Od/6Fmo8L8vC6bp8jQ87PcDx4eo0kxAGTVGamlUsLihVo7spNU96LHc/RzY9Hda
# XFSMb++hUD38dglohJ9vytsgjTVgHAIDyyCwrFigDkBjxZgiwbJZ9VVrzyerbHbO
# byMt9H5xaiNrIv8SuFQtJ37YOtnwtoeW/VvRXKwYw02fc7cBqZ9Xql4o4rmUMIIG
# rjCCBJagAwIBAgIQBzY3tyRUfNhHrP0oZipeWzANBgkqhkiG9w0BAQsFADBiMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJvb3QgRzQw
# HhcNMjIwMzIzMDAwMDAwWhcNMzcwMzIyMjM1OTU5WjBjMQswCQYDVQQGEwJVUzEX
# MBUGA1UEChMORGlnaUNlcnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0
# ZWQgRzQgUlNBNDA5NiBTSEEyNTYgVGltZVN0YW1waW5nIENBMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAxoY1BkmzwT1ySVFVxyUDxPKRN6mXUaHW0oPR
# nkyibaCwzIP5WvYRoUQVQl+kiPNo+n3znIkLf50fng8zH1ATCyZzlm34V6gCff1D
# tITaEfFzsbPuK4CEiiIY3+vaPcQXf6sZKz5C3GeO6lE98NZW1OcoLevTsbV15x8G
# ZY2UKdPZ7Gnf2ZCHRgB720RBidx8ald68Dd5n12sy+iEZLRS8nZH92GDGd1ftFQL
# IWhuNyG7QKxfst5Kfc71ORJn7w6lY2zkpsUdzTYNXNXmG6jBZHRAp8ByxbpOH7G1
# WE15/tePc5OsLDnipUjW8LAxE6lXKZYnLvWHpo9OdhVVJnCYJn+gGkcgQ+NDY4B7
# dW4nJZCYOjgRs/b2nuY7W+yB3iIU2YIqx5K/oN7jPqJz+ucfWmyU8lKVEStYdEAo
# q3NDzt9KoRxrOMUp88qqlnNCaJ+2RrOdOqPVA+C/8KI8ykLcGEh/FDTP0kyr75s9
# /g64ZCr6dSgkQe1CvwWcZklSUPRR8zZJTYsg0ixXNXkrqPNFYLwjjVj33GHek/45
# wPmyMKVM1+mYSlg+0wOI/rOP015LdhJRk8mMDDtbiiKowSYI+RQQEgN9XyO7ZONj
# 4KbhPvbCdLI/Hgl27KtdRnXiYKNYCQEoAA6EVO7O6V3IXjASvUaetdN2udIOa5kM
# 0jO0zbECAwEAAaOCAV0wggFZMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYE
# FLoW2W1NhS9zKXaaL3WMaiCPnshvMB8GA1UdIwQYMBaAFOzX44LScV1kTN8uZz/n
# upiuHA9PMA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDCDB3Bggr
# BgEFBQcBAQRrMGkwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNv
# bTBBBggrBgEFBQcwAoY1aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lD
# ZXJ0VHJ1c3RlZFJvb3RHNC5jcnQwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2Ny
# bDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZFJvb3RHNC5jcmwwIAYDVR0g
# BBkwFzAIBgZngQwBBAIwCwYJYIZIAYb9bAcBMA0GCSqGSIb3DQEBCwUAA4ICAQB9
# WY7Ak7ZvmKlEIgF+ZtbYIULhsBguEE0TzzBTzr8Y+8dQXeJLKftwig2qKWn8acHP
# HQfpPmDI2AvlXFvXbYf6hCAlNDFnzbYSlm/EUExiHQwIgqgWvalWzxVzjQEiJc6V
# aT9Hd/tydBTX/6tPiix6q4XNQ1/tYLaqT5Fmniye4Iqs5f2MvGQmh2ySvZ180HAK
# fO+ovHVPulr3qRCyXen/KFSJ8NWKcXZl2szwcqMj+sAngkSumScbqyQeJsG33irr
# 9p6xeZmBo1aGqwpFyd/EjaDnmPv7pp1yr8THwcFqcdnGE4AJxLafzYeHJLtPo0m5
# d2aR8XKc6UsCUqc3fpNTrDsdCEkPlM05et3/JWOZJyw9P2un8WbDQc1PtkCbISFA
# 0LcTJM3cHXg65J6t5TRxktcma+Q4c6umAU+9Pzt4rUyt+8SVe+0KXzM5h0F4ejjp
# nOHdI/0dKNPH+ejxmF/7K9h+8kaddSweJywm228Vex4Ziza4k9Tm8heZWcpw8De/
# mADfIBZPJ/tgZxahZrrdVcA6KYawmKAr7ZVBtzrVFZgxtGIJDwq9gdkT/r+k0fNX
# 2bwE+oLeMt8EifAAzV3C+dAjfwAL5HYCJtnwZXZCpimHCUcr5n8apIUP/JiW9lVU
# Kx+A+sDyDivl1vupL0QVSucTDh3bNzgaoSv27dZ8/DCCBsAwggSooAMCAQICEAxN
# aXJLlPo8Kko9KQeAPVowDQYJKoZIhvcNAQELBQAwYzELMAkGA1UEBhMCVVMxFzAV
# BgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVk
# IEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQTAeFw0yMjA5MjEwMDAw
# MDBaFw0zMzExMjEyMzU5NTlaMEYxCzAJBgNVBAYTAlVTMREwDwYDVQQKEwhEaWdp
# Q2VydDEkMCIGA1UEAxMbRGlnaUNlcnQgVGltZXN0YW1wIDIwMjIgLSAyMIICIjAN
# BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAz+ylJjrGqfJru43BDZrboegUhXQz
# Gias0BxVHh42bbySVQxh9J0Jdz0Vlggva2Sk/QaDFteRkjgcMQKW+3KxlzpVrzPs
# YYrppijbkGNcvYlT4DotjIdCriak5Lt4eLl6FuFWxsC6ZFO7KhbnUEi7iGkMiMbx
# vuAvfTuxylONQIMe58tySSgeTIAehVbnhe3yYbyqOgd99qtu5Wbd4lz1L+2N1E2V
# hGjjgMtqedHSEJFGKes+JvK0jM1MuWbIu6pQOA3ljJRdGVq/9XtAbm8WqJqclUeG
# hXk+DF5mjBoKJL6cqtKctvdPbnjEKD+jHA9QBje6CNk1prUe2nhYHTno+EyREJZ+
# TeHdwq2lfvgtGx/sK0YYoxn2Off1wU9xLokDEaJLu5i/+k/kezbvBkTkVf826uV8
# MefzwlLE5hZ7Wn6lJXPbwGqZIS1j5Vn1TS+QHye30qsU5Thmh1EIa/tTQznQZPpW
# z+D0CuYUbWR4u5j9lMNzIfMvwi4g14Gs0/EH1OG92V1LbjGUKYvmQaRllMBY5eUu
# KZCmt2Fk+tkgbBhRYLqmgQ8JJVPxvzvpqwcOagc5YhnJ1oV/E9mNec9ixezhe7nM
# ZxMHmsF47caIyLBuMnnHC1mDjcbu9Sx8e47LZInxscS451NeX1XSfRkpWQNO+l3q
# RXMchH7XzuLUOncCAwEAAaOCAYswggGHMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMB
# Af8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMCAGA1UdIAQZMBcwCAYGZ4EM
# AQQCMAsGCWCGSAGG/WwHATAfBgNVHSMEGDAWgBS6FtltTYUvcyl2mi91jGogj57I
# bzAdBgNVHQ4EFgQUYore0GH8jzEU7ZcLzT0qlBTfUpwwWgYDVR0fBFMwUTBPoE2g
# S4ZJaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0UlNB
# NDA5NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNybDCBkAYIKwYBBQUHAQEEgYMwgYAw
# JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBYBggrBgEFBQcw
# AoZMaHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0
# UlNBNDA5NlNIQTI1NlRpbWVTdGFtcGluZ0NBLmNydDANBgkqhkiG9w0BAQsFAAOC
# AgEAVaoqGvNG83hXNzD8deNP1oUj8fz5lTmbJeb3coqYw3fUZPwV+zbCSVEseIhj
# VQlGOQD8adTKmyn7oz/AyQCbEx2wmIncePLNfIXNU52vYuJhZqMUKkWHSphCK1D8
# G7WeCDAJ+uQt1wmJefkJ5ojOfRu4aqKbwVNgCeijuJ3XrR8cuOyYQfD2DoD75P/f
# nRCn6wC6X0qPGjpStOq/CUkVNTZZmg9U0rIbf35eCa12VIp0bcrSBWcrduv/mLIm
# lTgZiEQU5QpZomvnIj5EIdI/HMCb7XxIstiSDJFPPGaUr10CU+ue4p7k0x+GAWSc
# AMLpWnR1DT3heYi/HAGXyRkjgNc2Wl+WFrFjDMZGQDvOXTXUWT5Dmhiuw8nLw/ub
# E19qtcfg8wXDWd8nYiveQclTuf80EGf2JjKYe/5cQpSBlIKdrAqLxksVStOYkEVg
# M4DgI974A6T2RUflzrgDQkfoQTZxd639ouiXdE4u2h4djFrIHprVwvDGIqhPm73Y
# HJpRxC+a9l+nJ5e6li6FV8Bg53hWf2rvwpWaSxECyIKcyRoFfLpxtU56mWz06J7U
# WpjIn7+NuxhcQ/XQKujiYu54BNu90ftbCqhwfvCXhHjjCANdRyxjqCU4lwHSPzra
# 5eX25pvcfizM/xdMTQCi2NYBDriL7ubgclWJLCcZYfZ3AYwxggTyMIIE7gIBATAt
# MBkxFzAVBgNVBAMMDlNvcGhpYSBQcm9qZWN0AhB5x+saGw2LtUQda5GkuR72MAkG
# BSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJ
# AzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMG
# CSqGSIb3DQEJBDEWBBQq1hIwPJbuGovNQu675adSTcCNdDANBgkqhkiG9w0BAQEF
# AASCAQBIYxyyy6XWMeK1+PqV21Wp2E24b9nt+w1us63LtigGFwKEOqxIXxSXwXNy
# WluRUqEnRlpO7Qe2wnb9fgA9z/Nzg+k4fYTRYT3EnLmjNBoq97TwBicPPEqNduSw
# Fk+qLLIC0BCDLhVgn6ApdkMfsjyaYg888Vbpreb7pPRL3vXZu1F/77/T2W9zYM2x
# BKwK5Bu0ZvbGTupdp0Qfow8Kql9xQ7E0LZPKVkaQvXrWZYVAkmvfuX2fk5Mzk3yp
# k88qT3N3IBfqGN3FoDF5x+Xi3tzWObUoYJV216z/W+MVj1ScqyllcwHoGBXlyW1y
# bn/ahBzBYAYx7sQJiR1e4F4Cvqm8oYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJ
# AgEBMHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTsw
# OQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVT
# dGFtcGluZyBDQQIQDE1pckuU+jwqSj0pB4A9WjANBglghkgBZQMEAgEFAKBpMBgG
# CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMTIwNDE1
# MTYwNFowLwYJKoZIhvcNAQkEMSIEIGYCXLESul2zNVvMXXag2+wr2AcSZUHspWCg
# 5I7IksfrMA0GCSqGSIb3DQEBAQUABIICAGrvG1eE2UlIOK81ioZ+UCocKWaPhuV8
# HEHoDByc3h4/1/X9TTnkKd24qASSiKENQ4iSjhTdJox+zlbu/WhiAQs5O2krMsUI
# 61gJECX6Tqb2Y1BsCnv9+HrMfcslLm6IPI0rVoSGIhc1jR6vBuyAF+5vE+vaFeuo
# OO2MRU0qMSxsNoUv9nhUGMlXXMFJ/4fYZ7lzzQLRYlxdc2E5GIvf++Wjj8FOsG9D
# AGaxelsT/7gxAQmFUTadE7jZgS5wvhXmo/gv2NzpABWPkoy+VgErCx39afKIDRdS
# QTn6E+HFbJ1GsuhQyxXPXm0wO6YHiucV95Q0ivNXcil362VFvCldi72nLg4f02uN
# f0+mTUYDy3ilgXhy5m+zhTHbKJGaN9ic1ImJYilnlhys3/CmOfujNpUs7t1baJmx
# mnTphv2Rtu5hdtP8pInnZBZUhOSN0/kq2QZstmoOaZE1AdvvvPvLamkWw2u/pPcG
# bFi6r0y1wPadYzCib+56ow/Hm/idzKASZyf7gzvaFSHwX35+EVX98dvvr3H86+0n
# ZYoy+HhqApQvSQAkEZVtj92kY4iRS+/1ZbFZH2WMzN1fO7u3WwTrbQPSdNxFdMCI
# 3VV9Lp50eBlzkgQVAKvzzWo8JbKc4wffYEt5tDeeAch9XgHxolCv0tYH+UTXImmf
# k5Wkz1jQs2Rt
# SIG # End signature block
