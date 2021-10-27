#Requires -RunAsAdministrator
#Requires -Version 5.1

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string[]]
	$Functions
)

Clear-Host

$Host.UI.RawUI.WindowTitle = "Sophia Script for Windows 10 LTSC v5.2.16 | Made with $([char]::ConvertFromUtf32(0x1F497)) of Windows | $([char]0x00A9) farag & Inestic, 2014$([char]0x2013)2021"
Remove-Module -Name Sophia -Force -ErrorAction Ignore
Import-Module -Name $PSScriptRoot\Manifest\Sophia.psd1 -PassThru -Force
Import-LocalizedData -BindingVariable Global:Localization -FileName Sophia -BaseDirectory $PSScriptRoot\Localizations

#region Protection

Checkings -Warning
CreateRestorePoint

#endregion Protection

#region Privacy & Telemetry

DiagTrackService -Disable
DiagnosticDataLevel -Minimal
ErrorReporting -Disable
FeedbackFrequency -Never
ScheduledTasks -Disable
SigninInfo -Disable
LanguageListAccess -Disable
AdvertisingID -Disable

#endregion Privacy & Telemetry

#region UI & Personalization

ThisPC -Hide
CheckBoxes -Disable
HiddenItems -Enable
FileExtensions -Show
MergeConflicts -Show
OpenFileExplorerTo -ThisPC
SnapAssist -Disable
FileTransferDialog -Detailed
FileExplorerRibbon -Minimized
RecycleBinDeleteConfirmation -Disable
3DObjects -Hide
QuickAccessRecentFiles -Hide
QuickAccessFrequentFolders -Hide
TaskViewButton -Hide
PeopleTaskbar -Hide
SecondsInSystemClock -Show
TaskbarSearch -Hide
ControlPanelView -LargeIcons
WindowsColorMode -Dark
NewAppInstalledNotification -Hide
FirstLogonAnimation -Disable
JPEGWallpapersQuality -Max
TaskManagerWindow -Expanded
RestartNotification -Show
ShortcutsSuffix -Disable
PrtScnSnippingTool -Disable
AppsLanguageSwitch -Enable

#endregion UI & Personalization

#region System

StorageSense -Disable
StorageSenseTempFiles -Disable
Hibernation -Disable
Win32LongPathLimit -Disable
BSoDStopError -Enable
AdminApprovalMode -Never
MappedDrivesAppElevatedAccess -Enable
DeliveryOptimization -Disable
WaitNetworkStartup -Enable
WindowsManageDefaultPrinter -Disable
WindowsFeatures -Disable
WindowsCapabilities -Uninstall
UpdateMicrosoftProducts -Enable
PowerPlan -Balanced
LatestInstalled.NET -Enable
NetworkAdaptersSavePower -Disable
IPv6Component -Disable
InputMethod -Default
SetUserShellFolderLocation -Root
WinPrtScrFolder -Desktop
FoldersLaunchSeparateProcess -Enable
F1HelpPage -Disable
NumLock -Disable
CapsLock -Enable
StickyShift -Disable
Autoplay -Disable
ThumbnailCacheRemoval -Disable
NetworkDiscovery -Enable
ActiveHours -Automatically

#endregion System

#region Start menu

RecentlyAddedApps -Hide
AppSuggestions -Hide
RunPowerShellShortcut -Elevated

#endregion Start menu

#region Gaming

XboxGameBar -Disable
XboxGameTips -Disable
SetAppGraphicsPerformance

#endregion Gaming

#region Scheduled tasks

CleanupTask -Delete
SoftwareDistributionTask -Delete
TempTask -Delete

#endregion Scheduled tasks

#region Microsoft Defender & Security

NetworkProtection -Enable
PUAppsDetection -Enable
DefenderSandbox -Enable
AuditProcess -Enable
CommandLineProcessAudit -Enable
EventViewerCustomView -Enable
PowerShellModulesLogging -Enable
PowerShellScriptsLogging -Enable
AppsSmartScreen -Disable
SaveZoneInformation -Disable
WindowsScriptHost -Disable
WindowsSandbox -Enable
DismissMSAccount
DismissSmartScreenFilter

#endregion Microsoft Defender & Security

#region Context menu

MSIExtractContext -Hide
CABInstallContext -Hide
RunAsDifferentUserContext -Hide
CastToDeviceContext -Hide
ShareContext -Hide
EditWithPaint3DContext -Hide
PrintCMDContext -Hide
IncludeInLibraryContext -Hide
SendToContext -Hide
BitLockerContext -Hide
BitmapImageNewContext -Hide
RichTextDocumentNewContext -Hide
CompressedFolderNewContext -Hide
MultipleInvokeContext -Disable
UseStoreOpenWith -Hide

#endregion Context menu

RefreshEnvironment
Errors
