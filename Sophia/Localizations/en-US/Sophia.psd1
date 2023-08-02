ConvertFrom-StringData -StringData @'
UnsupportedOSBuild                        = The script supports Windows 11 22H2+.
UpdateWarning                             = Your Windows 11 build: {0}.{1}. Supported builds: 22621.1992+. Run Windows Update and try again.
UnsupportedLanguageMode                   = The PowerShell session in running in a limited language mode.
LoggedInUserNotAdmin                      = The logged-on user doesn't have admin rights.
UnsupportedPowerShell                     = You're trying to run script via PowerShell {0}.{1}. Run the script in the appropriate PowerShell version.
UnsupportedHost                           = The script doesn't support running via {0}.
Win10TweakerWarning                       = Probably your OS was infected via the Win 10 Tweaker backdoor.
TweakerWarning                            = The Windows stability may have been compromised by using {0}. Just in case, reinstall Windows.
bin                                       = There are no files in the bin folder. Please, re-download the archive.
RebootPending                             = The PC is waiting to be restarted.
UnsupportedRelease                        = A new version found.
KeyboardArrows                            = Please use the arrow keys {0} and {1} on your keyboard to select your answer
CustomizationWarning                      = Have you customized every function in the {0} preset file before running Sophia Script?
WindowsComponentBroken                    = {0} broken or removed from the OS.
UpdateDefender                            = Microsoft Defender definitions are out-of-date. Run Windows Update and try again.
ControlledFolderAccessDisabled            = Controlled folder access disabled.
ScheduledTasks                            = Scheduled tasks
OneDriveUninstalling                      = Uninstalling OneDrive...
OneDriveInstalling                        = Installing OneDrive...
OneDriveDownloading                       = Downloading OneDrive...
OneDriveWarning                           = The "{0}" function will be applied only if the preset is configured to remove OneDrive (or the app was already removed), otherwise the backup functionality for the "Desktop" and "Pictures" folders in OneDrive breaks.
WindowsFeaturesTitle                      = Windows features
OptionalFeaturesTitle                     = Optional features
EnableHardwareVT                          = Enable Virtualization in UEFI.
UserShellFolderNotEmpty                   = Some files left in the "{0}" folder. Move them manually to a new location.
RetrievingDrivesList                      = Retrieving drives list...
DriveSelect                               = Select the drive within the root of which the "{0}" folder will be created.
CurrentUserFolderLocation                 = The current "{0}" folder location: "{1}".
UserFolderRequest                         = Would you like to change the location of the "{0}" folder?
UserDefaultFolder                         = Would you like to change the location of the "{0}" folder to the default value?
ReservedStorageIsInUse                    = This operation is not supported when reserved storage is in use\nPlease re-run the "{0}" function again after PC restart.
ShortcutPinning                           = The "{0}" shortcut is being pinned to Start...
SSDRequired                               = To use Windows Subsystem for Android™ on your device, your PC needs to have Solid State Drive (SSD) installed.
UninstallUWPForAll                        = For all users
UWPAppsTitle                              = UWP Apps
HEVCDownloading                           = Downloading HEVC Video Extensions from Device Manufacturer...
GraphicsPerformanceTitle                  = Would you like to set the graphics performance setting of an app of your choice to "High performance"?
ActionCenter                              = In order to use "{0}" function you have to enable Action Center.
WindowsScriptHost                         = Windows Script Host access is disabled on this machine. In order to use "{0}" function you have to enable Windows Script Host.
ScheduledTaskPresented                    = The "{0}" function was already created as "{1}".
CleanupTaskNotificationTitle              = Windows clean up
CleanupTaskNotificationEvent              = Run task to clean up Windows unused files and updates?
CleanupTaskDescription                    = Cleaning up Windows unused files and updates using built-in Disk cleanup app.
CleanupNotificationTaskDescription        = Pop-up notification reminder about cleaning up Windows unused files and updates.
SoftwareDistributionTaskNotificationEvent = Windows update cache successfully deleted.
TempTaskNotificationEvent                 = Temporary files folder successfully cleaned up.
FolderTaskDescription                     = The {0} folder cleanup.
EventViewerCustomViewName                 = Process Creation
EventViewerCustomViewDescription          = Process creation and command-line auditing events.
RestartWarning                            = Make sure to restart your PC.
ErrorsLine                                = Line
ErrorsMessage                             = Errors/Warnings
DialogBoxOpening                          = Displaying the dialog box...
Disable                                   = Disable
AllFilesFilter                            = All Files
FolderSelect                              = Select a folder
FilesWontBeMoved                          = Files will not be moved.
Install                                   = Install
NoData                                    = Nothing to display.
NoInternetConnection                      = No Internet connection.
RestartFunction                           = Please re-run the "{0}" function.
NoResponse                                = A connection could not be established with {0}.
Restore                                   = Restore
Run                                       = Run
Skipped                                   = Skipped.
GPOUpdate                                 = Updating GPO...
TelegramGroupTitle                        = Join our official Telegram group.
TelegramChannelTitle                      = Join our official Telegram channel.
DiscordChannelTitle                       = Join our official Discord channel.
Uninstall                                 = Uninstall
'@

# SIG # Begin signature block
# MIIblQYJKoZIhvcNAQcCoIIbhjCCG4ICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUKwo5S7eAlub/fQ+1v+eontyR
# 2WqgghYNMIIDAjCCAeqgAwIBAgIQaksVnyyz84NPdVUTWD8u7zANBgkqhkiG9w0B
# AQsFADAZMRcwFQYDVQQDDA5Tb3BoaWEgUHJvamVjdDAeFw0yMzA3MTYxNzEwMjJa
# Fw0yNTA3MTYxNzE5NTBaMBkxFzAVBgNVBAMMDlNvcGhpYSBQcm9qZWN0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApicz5jh8o7haSVVBc1LCYPa09UJh
# v9J52gmBcJHyq+sFrgyZvzY5IlLbAfk/VnlyADVKKbr6qc6dhT0BCjTraLAPxLEZ
# dG3GQU9ROwyKom6qdS933uWdQP/GA6miccGxLIVia6eYfLi7WYmFI3NLtXQTs9EO
# EXQTNDuFCl3KN0/CQUiRe1Ye5/tpzFdSq33tcFVuJ/+AkTV3dJTOjafwv3Zejv8e
# isuGAtjaJSti4kGCry8iQLQVfbIUk+gX+39djvug/aZ1LwrMisn6oSO8f8aJoOhg
# PsaQUsPu2j8griGCtC7Wa+sWlBkK5rpeZme6E019qP1dQCIC9Bb2aU+3jQIDAQAB
# o0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0O
# BBYEFBDjDCjlL9oTkLaBglE0uU6zFaLiMA0GCSqGSIb3DQEBCwUAA4IBAQB2RyYn
# B5dCJUJC8WtfweY5eBb4K8IEf23N8dfktjsARnZ6zmG+3ggkABsHWVS392HGMLdW
# r8a2iiqkwZy1TsZl6Y+WfWbaGPnPpBVuVtxe7dC9bsm+5EQObDvFj2msFmgHyDKn
# mSAiu8Qp0SpXFoR6Q3Qkkehhcsp8M4ijQRTpl92fu6EQuJ+1B+2QJRd/DV9Jz+JY
# lkgJ+01R7oBH3HHzfg33DaLLlnOmEpte8SFOYQR3/lv2uOnHrq0KFUQZCk4RJBie
# gcDQdEy5mwQlBzTrF55iu6MU7HV8SS2ehUFcVDVq5B54Z7LzFIo8a7DlBXLr8yhQ
# 3OaYIlpoe8rzQ6IQMIIFjTCCBHWgAwIBAgIQDpsYjvnQLefv21DiCEAYWjANBgkq
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
# MBkxFzAVBgNVBAMMDlNvcGhpYSBQcm9qZWN0AhBqSxWfLLPzg091VRNYPy7vMAkG
# BSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJ
# AzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMG
# CSqGSIb3DQEJBDEWBBQCUlg6UJ7FPHKMdgCZhud8OJOlATANBgkqhkiG9w0BAQEF
# AASCAQB8C5JL2tf3asy1IgNGpqgqAsZjYO7JCzjf3idaTa6HprE1o4a997BLEDFq
# owTmhNTVTYngjPhTesghGC0QP4EODt9UVLlvVi9DkvRFyzAWvvagTBhTKDbDR8v2
# x2LXldYbkG7nFgc015fOAYM5kUpWWY5v+lyXSBRaQpoKc6N4DQMgxOtLSfKZhJCf
# tX6KnPSdlqgkm8bpiPVLpF6PhvBOJ+ssipjbo0tqDmoEi8wOidB+yztA9D3ozqyY
# vEHE/C8AtRV5f4GS/ZVxQM/rKhqp5qwVr2TQkwaRrEiNt/NCXUxhxnLfRTnkpJF6
# toWSbg7Gh6D13ksRu006FvwFrJvzoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJ
# AgEBMHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTsw
# OQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVT
# dGFtcGluZyBDQQIQDE1pckuU+jwqSj0pB4A9WjANBglghkgBZQMEAgEFAKBpMBgG
# CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcxNjE3
# MjAzMlowLwYJKoZIhvcNAQkEMSIEIFp3L467ZgTpSoi11Gza41qIyUesafKfxpWn
# XAAmSD9SMA0GCSqGSIb3DQEBAQUABIICALHyCWMUwKkRHdHjXpO2nS6h85l3dgpx
# hdLlTzHO77IcPnaK3qgeR1zaIJIVmJVJBmqujxI3YVA8tjGKNfYTPmtvHUk9+4zt
# q2ivxIAXu5dqtyuwWYniIiFlRD45mXCxEFnPL0dNBy7OrqwmFH91alxnA33NaPSI
# uqA5vb2UJ8n/Vn1z3Wcll82pFIQW/YBugl+ab0lybqqwdc6y7K2kcxRqA7mepd/I
# x4Vu96cDC/5Rl0CFT9OMjntWwq1BnkPkQ9GmNtzxRhcucRzcheVSSKGRfoPThIPG
# oCpaqQjcHr6W+VXvhak7W6M8CiPcjJJt8EwnwyPEpcGicSErRvfS+GirswSs1I/z
# LcueoLKtUB8fSol3/xh339WiaNCrDvlA08fWvQOBKMFEFHRyPsdMbeyGrP2kA3KO
# F+oNyaSGQGHvIrHGuOZ0pWC5hg+uEp4aHpHigLfkxdaL9opQlhMcSygsqKHL0vvv
# bDhEDsIOaHabaSphlMnrvBExByD0rWbSNsN3QXgW+bjSQWKAqu8hxaJekEeuyPCs
# KC7mWGbuTp6/4uj9mIO0hLUqJPLpFyjkzL+YLknS6I98jR3RFULtY8OLG7y/ffmb
# d5WFAPcCC6vTfQBT5Iu72uQQCSMafzOR4MAtV4t7cXzXzaOCkD0L+hHkrnXmz4S9
# oPgAt4mvXv3P
# SIG # End signature block
