<#
	.SYNOPSIS
	The TAB completion for functions and their arguments

	Version: v6.5.6
	Date: 17.09.2023

	Copyright (c) 2014—2023 farag
	Copyright (c) 2019—2023 farag & Inestic

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

	# The "PostActions" and "Errors" functions will be executed at the end
	Invoke-Command -ScriptBlock {PostActions; Errors}
}

Clear-Host

$Host.UI.RawUI.WindowTitle = "Sophia Script for Windows 11 v6.5.6 | Made with $([System.Char]::ConvertFromUtf32(0x1F497)) of Windows | $([System.Char]0x00A9) farag & Inestic, 2014$([System.Char]0x2013)2023"

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
InitialActions

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

			# If a module command is OneDrive
			if ($Command -eq "OneDrive")
			{
				(Get-Command -Name $Command).Name | Where-Object -FilterScript {$_ -like "*$wordToComplete*"}

				# Get all command arguments, excluding defaults
				foreach ($ParameterSet in $ParameterSets.Name)
				{
					# If an argument is AllUsers
					if ($ParameterSet -eq "AllUsers")
					{
						# The "OneDrive -Install -AllUsers" construction
						"OneDrive" + " " + "-Install" + " " + "-" + $ParameterSet | Where-Object -FilterScript {$_ -like "*$wordToComplete*"} | ForEach-Object -Process {"`"$_`""}
					}

					continue
				}
			}

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

			# If a module command is Set-Policy
			if ($Command -eq "Set-Policy")
			{
				continue
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
Write-Verbose -Message "Sophia -Functions `"UninstallUWPApps, `"PinToStart -UnpinAll`" -Verbose"
Write-Verbose -Message "Sophia -Functions `"Set-Association -ProgramPath ```"%ProgramFiles%\Notepad++\notepad++.exe```" -Extension .txt -Icon ```"%ProgramFiles%\Notepad++\notepad++.exe,0```"`"" -Verbose

# SIG # Begin signature block
# MIIblwYJKoZIhvcNAQcCoIIbiDCCG4QCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUdU55SUojLzi0cuxiQdXsKuDe
# 1o+gghYPMIIDAjCCAeqgAwIBAgIQaCN8KfrjD6BOk5DiIPWouTANBgkqhkiG9w0B
# AQsFADAZMRcwFQYDVQQDDA5Tb3BoaWEgUHJvamVjdDAeFw0yMzA5MTcxNzU1Mjha
# Fw0yNTA5MTcxODA0NTdaMBkxFzAVBgNVBAMMDlNvcGhpYSBQcm9qZWN0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyX2JF3ExXjGKMrUp79D6hyQXY+zu
# MQU6qtebkcjxlnOjlQf7PJdXi7PwxxuuCJWiDGTuGB+hUTXPE6DJWzJNWEfXI3aH
# c32Ps7RCPg8Aviy7zdLx+zHGJ328fXXvRMyCSmAqA05cxuRYMmiak7yQ1egVtH+a
# iQj2P4WeuX8QntM3k1v0YGIdUWCW4lPMw3seWXCS0cf+R8Je6l8H+dgrzIkQdJSb
# vfF9n356lfRx8fk/eG21Zm3yINQTz1uC6sHu+Zp1azQu97IPvEbEilXwiVV9w00k
# 3jRej4TFpNYinxnf/MVqe0qgU7eV95OAYpi8a9gn/bqj99uS+W0LR+yrYQIDAQAB
# o0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0O
# BBYEFFTlv/SckttupzhAMIJfxGGz0oVmMA0GCSqGSIb3DQEBCwUAA4IBAQAPuSjM
# EmxBPRqAtZZKBlvpqZ+43+phpn/MXwLjRpdSJg7L9K/vPUuh+N2oPjX4VoRKT3kj
# zL4/kfGX7cS8H1o4GyljrxKcrrbPFRgsZ5tjqqBBEqAh5cGnkJhALy8Tftx2a6Jd
# Yd2ZxwoaFZiRPNZiAQoyIFbUnf607mNxKYQKMyE1rbDF0UIBCt1ZKSSHMW+K7/uu
# TRaaJYzy1fBPkrDMO8jUDcFq5cFGiQH3G+fao2uKUp99oWTGxWi2U+n41rGIRo5i
# kK2LoxucRaIdxMRoh3+Qw/dN2CxEckkboAdfuByigeyhq3kcoiB00WrR3uMzeKTS
# /oPtgG2zf3WMkUttMIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkq
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
# Kx+A+sDyDivl1vupL0QVSucTDh3bNzgaoSv27dZ8/DCCBsIwggSqoAMCAQICEAVE
# r/OUnQg5pr/bP1/lYRYwDQYJKoZIhvcNAQELBQAwYzELMAkGA1UEBhMCVVMxFzAV
# BgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVk
# IEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQTAeFw0yMzA3MTQwMDAw
# MDBaFw0zNDEwMTMyMzU5NTlaMEgxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdp
# Q2VydCwgSW5jLjEgMB4GA1UEAxMXRGlnaUNlcnQgVGltZXN0YW1wIDIwMjMwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCjU0WHHYOOW6w+VLMj4M+f1+XS
# 512hDgncL0ijl3o7Kpxn3GIVWMGpkxGnzaqyat0QKYoeYmNp01icNXG/OpfrlFCP
# HCDqx5o7L5Zm42nnaf5bw9YrIBzBl5S0pVCB8s/LB6YwaMqDQtr8fwkklKSCGtpq
# utg7yl3eGRiF+0XqDWFsnf5xXsQGmjzwxS55DxtmUuPI1j5f2kPThPXQx/ZILV5F
# dZZ1/t0QoRuDwbjmUpW1R9d4KTlr4HhZl+NEK0rVlc7vCBfqgmRN/yPjyobutKQh
# ZHDr1eWg2mOzLukF7qr2JPUdvJscsrdf3/Dudn0xmWVHVZ1KJC+sK5e+n+T9e3M+
# Mu5SNPvUu+vUoCw0m+PebmQZBzcBkQ8ctVHNqkxmg4hoYru8QRt4GW3k2Q/gWEH7
# 2LEs4VGvtK0VBhTqYggT02kefGRNnQ/fztFejKqrUBXJs8q818Q7aESjpTtC/XN9
# 7t0K/3k0EH6mXApYTAA+hWl1x4Nk1nXNjxJ2VqUk+tfEayG66B80mC866msBsPf7
# Kobse1I4qZgJoXGybHGvPrhvltXhEBP+YUcKjP7wtsfVx95sJPC/QoLKoHE9nJKT
# BLRpcCcNT7e1NtHJXwikcKPsCvERLmTgyyIryvEoEyFJUX4GZtM7vvrrkTjYUQfK
# lLfiUKHzOtOKg8tAewIDAQABo4IBizCCAYcwDgYDVR0PAQH/BAQDAgeAMAwGA1Ud
# EwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwIAYDVR0gBBkwFzAIBgZn
# gQwBBAIwCwYJYIZIAYb9bAcBMB8GA1UdIwQYMBaAFLoW2W1NhS9zKXaaL3WMaiCP
# nshvMB0GA1UdDgQWBBSltu8T5+/N0GSh1VapZTGj3tXjSTBaBgNVHR8EUzBRME+g
# TaBLhklodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkRzRS
# U0E0MDk2U0hBMjU2VGltZVN0YW1waW5nQ0EuY3JsMIGQBggrBgEFBQcBAQSBgzCB
# gDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMFgGCCsGAQUF
# BzAChkxodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVk
# RzRSU0E0MDk2U0hBMjU2VGltZVN0YW1waW5nQ0EuY3J0MA0GCSqGSIb3DQEBCwUA
# A4ICAQCBGtbeoKm1mBe8cI1PijxonNgl/8ss5M3qXSKS7IwiAqm4z4Co2efjxe0m
# gopxLxjdTrbebNfhYJwr7e09SI64a7p8Xb3CYTdoSXej65CqEtcnhfOOHpLawkA4
# n13IoC4leCWdKgV6hCmYtld5j9smViuw86e9NwzYmHZPVrlSwradOKmB521BXIxp
# 0bkrxMZ7z5z6eOKTGnaiaXXTUOREEr4gDZ6pRND45Ul3CFohxbTPmJUaVLq5vMFp
# GbrPFvKDNzRusEEm3d5al08zjdSNd311RaGlWCZqA0Xe2VC1UIyvVr1MxeFGxSjT
# redDAHDezJieGYkD6tSRN+9NUvPJYCHEVkft2hFLjDLDiOZY4rbbPvlfsELWj+MX
# kdGqwFXjhr+sJyxB0JozSqg21Llyln6XeThIX8rC3D0y33XWNmdaifj2p8flTzU8
# AL2+nCpseQHc2kTmOt44OwdeOVj0fHMxVaCAEcsUDH6uvP6k63llqmjWIso765qC
# NVcoFstp8jKastLYOrixRoZruhf9xHdsFWyuq69zOuhJRrfVf8y2OMDY7Bz1tqG4
# QyzfTkx9HmhwwHcK1ALgXGC7KP845VJa1qwXIiNO9OzTF/tQa/8Hdx9xl0RBybhG
# 02wyfFgvZ0dl5Rtztpn5aywGRu9BHvDwX+Db2a2QgESvgBBBijGCBPIwggTuAgEB
# MC0wGTEXMBUGA1UEAwwOU29waGlhIFByb2plY3QCEGgjfCn64w+gTpOQ4iD1qLkw
# CQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcN
# AQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUw
# IwYJKoZIhvcNAQkEMRYEFPLxfIe31BOvrqFX4BlYq00hx7ikMA0GCSqGSIb3DQEB
# AQUABIIBACZ9GpOli4fmtBPGFy+IpMvqAoNOvegM8jYlOXnhRvlSr6dX1cvpSfkS
# jirFMSUGrfJLd4WUmI5vM8ai405xTd/QY2Cdv2/OxPXKUxYCGusuS7y76tpjkskS
# HqnJUirp/WG2p4Dx8H1e5y+aGRRRMozevtIiMfkkBGMtrwxmMbQ7F5+u/8F3zFhv
# kjuOqz7lutQOKW6PPnNDol1vOHPI8nw7RjPKXh2qli9NYwWe1AoHnu+57jut2/MX
# 3eB1x1DfecCnGQT81L5iyDo7HG9UTquo5Gt6iPrzHwFVtq0ElxU11A8pdyW6hvqA
# QZoiJDvhEbUMXbsq8HLtpWMryqrZzemhggMgMIIDHAYJKoZIhvcNAQkGMYIDDTCC
# AwkCAQEwdzBjMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4x
# OzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0ZWQgRzQgUlNBNDA5NiBTSEEyNTYgVGlt
# ZVN0YW1waW5nIENBAhAFRK/zlJ0IOaa/2z9f5WEWMA0GCWCGSAFlAwQCAQUAoGkw
# GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwOTE3
# MTgwNTM0WjAvBgkqhkiG9w0BCQQxIgQgUKrEU6jUJGCASeKwLLeWODNl0EmS9xLH
# pZaEZowW3ZwwDQYJKoZIhvcNAQEBBQAEggIASRtZ9wwXA1AP2vsWSTCMxQ01a+dB
# OEmrMMIYhyfS+vVRjqsOLEu6aHs6ISikpBiBnn7dYHkBmsW/A/pX2YSlMAHfogVG
# qJE8DkA0W6cZeu9zSx5mJDibDsuuXOKrP37oK7djrnR2l5hNHwuPrEOKhORDUgHY
# kNCIWPL9iiv7EPa2DAeteJTPOateGOIydx7DIEsN0CfrzwOTRGu6xXgwC5+fRto7
# UGBOSawzKZcjHLrzj5coXMbAaFcpoExnZhyTqOvQtCu+no5BLvOm19pAUy725DLN
# u9GlnfZTYWrDwvtadz2LDpr+kdhLfeZZM7MQoL87Qu8Tgwtsq/Nf0kEghflvMOKg
# 07zcuUB6gJFz9yl5+3nMKfh9dqaPzwgfRePB/ycjaQ1MxM/kYpMDQuwzK0VbPt4v
# MvRT2FHrxAAsjPGtzXpbb4g0fH6qCLi4X9mz9ZTkjLf7+Ogg/ixNtIPrr8NfdqO0
# 5fa6xu94adIwy/V3PCgmE4xl5xyQDWkAGSxqP/0eEW3iBIoajZ9NlLAMgEY/24ay
# iPIGQV5VUgzV5F397jhCov5YsfdT3gFd6z+jnwAE+a69iujAMzZIHRR05JXgQIR2
# DfX0LsmDF5VaGbsioVCGZkhK4LsrFye+ckgHmiSOhE56azf+sv/d0PfeV/jY+DqZ
# K44PX0ftqunb0Ag=
# SIG # End signature block
