<#
	.SYNOPSIS
	Default preset file for "Sophia Script for Windows 11 (PowerShell 7)"

	Version: v6.5.4
	Date: 16.07.2023

	Copyright (c) 2014—2023 farag
	Copyright (c) 2019—2023 farag & Inestic

	Thanks to all https://forum.ru-board.com members involved

	.DESCRIPTION
	Place the "#" char before function if you don't want to run it
	Remove the "#" char before function if you want to run it
	Every tweak in the preset file has its' corresponding function to restore the default settings

	.EXAMPLE Run the whole script
	.\Sophia.ps1

	.EXAMPLE Run the script by specifying the module functions as an argument
	.\Sophia.ps1 -Functions "DiagTrackService -Disable", "DiagnosticDataLevel -Minimal", UninstallUWPApps

	.EXAMPLE Download and expand the latest Sophia Script version archive (without running) according which Windows and PowerShell versions it is run on
	irm script.sophi.app -useb | iex

	.NOTES
	Supported Windows 11 versions
	Version: 22H2
	Builds: 22621.1992+
	Editions: Home/Pro/Enterprise

	.NOTES
	To use the TAB completion for functions and their arguments dot source the Functions.ps1 script first:
		. .\Function.ps1 (with a dot at the beginning)
	Read more in the Functions.ps1 file

	.LINK GitHub
	https://github.com/farag2/Sophia-Script-for-Windows

	.LINK Telegram
	https://t.me/sophianews
	https://t.me/sophia_chat

	.LINK Discord
	https://discord.gg/sSryhaEv79

	.NOTES
	https://forum.ru-board.com/topic.cgi?forum=62&topic=30617#15
	https://habr.com/company/skillfactory/blog/553800/
	https://forums.mydigitallife.net/threads/powershell-windows-10-sophia-script.81675/
	https://www.reddit.com/r/PowerShell/comments/go2n5v/powershell_script_setup_windows_10/

	.LINK Authors
	https://github.com/farag2
	https://github.com/Inestic
#>

#Requires -RunAsAdministrator
#Requires -Version 7.3

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string[]]
	$Functions
)

Clear-Host

$Host.UI.RawUI.WindowTitle = "Sophia Script for Windows 11 v6.5.4 (PowerShell 7) | Made with $([System.Char]::ConvertFromUtf32(0x1F497)) of Windows | $([System.Char]0x00A9) farag & Inestic, 2014$([System.Char]0x2013)2023"

Remove-Module -Name Sophia -Force -ErrorAction Ignore
Import-Module -Name $PSScriptRoot\Manifest\Sophia.psd1 -PassThru -Force

# PowerShell 7 doesn't load en-us localization automatically if there is no localization folder in user's language which is determined by $PSUICulture
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-localizeddata?view=powershell-7.3
try
{
	Import-LocalizedData -BindingVariable Global:Localization -UICulture $PSUICulture -BaseDirectory $PSScriptRoot\Localizations -FileName Sophia -ErrorAction Stop
}
catch
{
	Import-LocalizedData -BindingVariable Global:Localization -UICulture en-US -BaseDirectory $PSScriptRoot\Localizations -FileName Sophia
}

<#
	.SYNOPSIS
	Run the script by specifying functions as an argument
	Запустить скрипт, указав в качестве аргумента функции

	.EXAMPLE
	.\Sophia.ps1 -Functions "DiagTrackService -Disable", "DiagnosticDataLevel -Minimal", UninstallUWPApps

	.NOTES
	Use commas to separate funtions
	Разделяйте функции запятыми
#>
if ($Functions)
{
	Invoke-Command -ScriptBlock {InitialActions}

	foreach ($Function in $Functions)
	{
		Invoke-Expression -Command $Function
	}

	# The "PostActions" and "Errors" functions will be executed at the end
	Invoke-Command -ScriptBlock {PostActions; Errors}

	exit
}

#region Protection
# The mandatory checks. If you want to disable a warning message about whether the preset file was customized, remove the "-Warning" argument
# Обязательные проверки. Чтобы выключить предупреждение о необходимости настройки пресет-файла, удалите аргумент "-Warning"
InitialActions -Warning

# Enable script logging. Log will be recorded into the script folder. To stop logging just close console or type "Stop-Transcript"
# Включить логирование работы скрипта. Лог будет записываться в папку скрипта. Чтобы остановить логгирование, закройте консоль или наберите "Stop-Transcript"
# Logging

# Create a restore point
# Создать точку восстановления
CreateRestorePoint
#endregion Protection

#region Privacy & Telemetry
<#
	Disable the "Connected User Experiences and Telemetry" service (DiagTrack), and block the connection for the Unified Telemetry Client Outbound Traffic
	Disabling the "Connected User Experiences and Telemetry" service (DiagTrack) can cause you not being able to get Xbox achievements anymore and affects Feedback Hub

	Отключить службу "Функциональные возможности для подключенных пользователей и телеметрия" (DiagTrack) и блокировать соединение для исходящего трафик клиента единой телеметрии
	Отключение службы "Функциональные возможности для подключенных пользователей и телеметрия" (DiagTrack) может привести к тому, что вы больше не сможете получать достижения Xbox, а также влияет на работу Feedback Hub
#>
DiagTrackService -Disable

# Enable the "Connected User Experiences and Telemetry" service (DiagTrack), and allow the connection for the Unified Telemetry Client Outbound Traffic (default value)
# Включить службу "Функциональные возможности для подключенных пользователей и телеметрия" (DiagTrack) и разрешить подключение для исходящего трафик клиента единой телеметрии (значение по умолчанию)
# DiagTrackService -Enable

# Set the diagnostic data collection to minimum
# Установить уровень сбора диагностических данных ОС на минимальный
DiagnosticDataLevel -Minimal

# Set the diagnostic data collection to default (default value)
# Установить уровень сбора диагностических данных ОС по умолчанию (значение по умолчанию)
# DiagnosticDataLevel -Default

# Turn off the Windows Error Reporting
# Отключить запись отчетов об ошибках Windows
ErrorReporting -Disable

# Turn on the Windows Error Reporting (default value)
# Включить отчеты об ошибках Windows (значение по умолчанию)
# ErrorReporting -Enable

# Change the feedback frequency to "Never"
# Изменить частоту формирования отзывов на "Никогда"
FeedbackFrequency -Never

# Change the feedback frequency to "Automatically" (default value)
# Изменить частоту формирования отзывов на "Автоматически" (значение по умолчанию)
# FeedbackFrequency -Automatically

# Turn off the diagnostics tracking scheduled tasks
# Отключить задания диагностического отслеживания
ScheduledTasks -Disable

# Turn on the diagnostics tracking scheduled tasks (default value)
# Включить задания диагностического отслеживания (значение по умолчанию)
# ScheduledTasks -Enable

# Do not use sign-in info to automatically finish setting up device after an update
# Не использовать данные для входа для автоматического завершения настройки устройства после перезапуска
SigninInfo -Disable

# Use sign-in info to automatically finish setting up device after an update (default value)
# Использовать данные для входа, чтобы автоматически завершить настройку после обновления (значение по умолчанию)
# SigninInfo -Enable

# Do not let websites provide locally relevant content by accessing language list
# Не позволять веб-сайтам предоставлять местную информацию за счет доступа к списку языков
LanguageListAccess -Disable

# Let websites provide locally relevant content by accessing language list (default value)
# Позволить веб-сайтам предоставлять местную информацию за счет доступа к списку языков (значение по умолчанию)
# LanguageListAccess -Enable

# Do not let apps show me personalized ads by using my advertising ID
# Не разрешать приложениям показывать персонализированную рекламу с помощью моего идентификатора рекламы
AdvertisingID -Disable

# Let apps show me personalized ads by using my advertising ID (default value)
# Разрешить приложениям показывать персонализированную рекламу с помощью моего идентификатора рекламы (значение по умолчанию)
# AdvertisingID -Enable

# Hide the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested
# Скрывать экран приветствия Windows после обновлений и иногда при входе, чтобы сообщить о новых функциях и предложениях
WindowsWelcomeExperience -Hide

# Show the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested (default value)
# Показывать экран приветствия Windows после обновлений и иногда при входе, чтобы сообщить о новых функциях и предложениях (значение по умолчанию)
# WindowsWelcomeExperience -Show

# Get tips and suggestions when I use Windows (default value)
# Получать советы и предложения при использованию Windows (значение по умолчанию)
# WindowsTips -Enable

# Do not get tips and suggestions when I use Windows
# Не получать советы и предложения при использованию Windows
WindowsTips -Disable

# Hide from me suggested content in the Settings app
# Скрывать рекомендуемое содержимое в приложении "Параметры"
SettingsSuggestedContent -Hide

# Show me suggested content in the Settings app (default value)
# Показывать рекомендуемое содержимое в приложении "Параметры" (значение по умолчанию)
# SettingsSuggestedContent -Show

# Turn off automatic installing suggested apps
# Отключить автоматическую установку рекомендованных приложений
AppsSilentInstalling -Disable

# Turn on automatic installing suggested apps (default value)
# Включить автоматическую установку рекомендованных приложений (значение по умолчанию)
# AppsSilentInstalling -Enable

# Do not suggest ways to get the most out of Windows and finish setting up this device
# Не предлагать способы завершения настройки этого устройства для наиболее эффективного использования Windows
WhatsNewInWindows -Disable

# Suggest ways to get the most out of Windows and finish setting up this device (default value)
# Предложить способы завершения настройки этого устройства для наиболее эффективного использования Windows (значение по умолчанию)
# WhatsNewInWindows -Enable

# Don't let Microsoft use your diagnostic data for personalized tips, ads, and recommendations
# Не разрешать корпорации Майкрософт использовать диагностические данные персонализированных советов, рекламы и рекомендаций
TailoredExperiences -Disable

# Let Microsoft use your diagnostic data for personalized tips, ads, and recommendations (default value)
# Разрешить корпорации Майкрософт использовать диагностические данные для персонализированных советов, рекламы и рекомендаций (значение по умолчанию)
# TailoredExperiences -Enable

# Disable Bing search in the Start Menu
# Отключить в меню "Пуск" поиск через Bing
BingSearch -Disable

# Enable Bing search in the Start Menu (default value)
# Включить поиск через Bing в меню "Пуск" (значение по умолчанию)
# BingSearch -Enable

# Do not show websites from your browsing history in the Start menu
# Не показать веб-сайты из журнала браузера в меню "Пуск"
BrowsingHistory -Hide

# Show websites from your browsing history in the Start menu (default value)
# Показать веб-сайты из журнала браузера в меню "Пуск" (значение по умолчанию)
# BrowsingHistory -Show
#endregion Privacy & Telemetry

#region UI & Personalization
# Show the "This PC" icon on Desktop
# Отобразить значок "Этот компьютер" на рабочем столе
# ThisPC -Show

# Hide the "This PC" icon on Desktop (default value)
# Скрыть "Этот компьютер" на рабочем столе (значение по умолчанию)
ThisPC -Hide

# Do not use item check boxes
# Не использовать флажки для выбора элементов
CheckBoxes -Disable

# Use check item check boxes (default value)
# Использовать флажки для выбора элементов (значение по умолчанию)
# CheckBoxes -Enable

# Show hidden files, folders, and drives
# Отобразить скрытые файлы, папки и диски
HiddenItems -Enable

# Do not show hidden files, folders, and drives (default value)
# Не показывать скрытые файлы, папки и диски (значение по умолчанию)
# HiddenItems -Disable

# Show file name extensions
# Отобразить расширения имён файлов
FileExtensions -Show

# Hide file name extensions (default value)
# Скрывать расширения имён файлов файлов (значение по умолчанию)
# FileExtensions -Hide

# Show folder merge conflicts
# Не скрывать конфликт слияния папок
MergeConflicts -Show

# Hide folder merge conflicts (default value)
# Скрывать конфликт слияния папок (значение по умолчанию)
# MergeConflicts -Hide

# Open File Explorer to "This PC"
# Открывать проводник для "Этот компьютер"
OpenFileExplorerTo -ThisPC

# Open File Explorer to Quick access (default value)
# Открывать проводник для "Быстрый доступ" (значение по умолчанию)
# OpenFileExplorerTo -QuickAccess

# Disable the File Explorer compact mode (default value)
# Отключить компактный вид проводника (значение по умолчанию)
FileExplorerCompactMode -Disable

# Enable the File Explorer compact mode
# Включить компактный вид проводника
# FileExplorerCompactMode -Enable

# Do not show sync provider notification within File Explorer
# Не показывать уведомления поставщика синхронизации в проводнике
OneDriveFileExplorerAd -Hide

# Show sync provider notification within File Explorer (default value)
# Показывать уведомления поставщика синхронизации в проводнике (значение по умолчанию)
# OneDriveFileExplorerAd -Show

# When I snap a window, do not show what I can snap next to it
# При прикреплении окна не показывать, что можно прикрепить рядом с ним
SnapAssist -Disable

# When I snap a window, show what I can snap next to it (default value)
# При прикреплении окна показывать, что можно прикрепить рядом с ним (значение по умолчанию)
# SnapAssist -Enable

# Show the file transfer dialog box in the detailed mode
# Отображать диалоговое окно передачи файлов в развернутом виде
FileTransferDialog -Detailed

# Show the file transfer dialog box in the compact mode (default value)
# Отображать диалоговое окно передачи файлов в свернутом виде (значение по умолчанию)
# FileTransferDialog -Compact

# Display the recycle bin files delete confirmation dialog
# Запрашивать подтверждение на удаление файлов в корзину
RecycleBinDeleteConfirmation -Enable

# Do not display the recycle bin files delete confirmation dialog (default value)
# Не запрашивать подтверждение на удаление файлов в корзину (значение по умолчанию)
# RecycleBinDeleteConfirmation -Disable

# Hide recently used files in Quick access
# Скрыть недавно использовавшиеся файлы на панели быстрого доступа
QuickAccessRecentFiles -Hide

# Show recently used files in Quick access (default value)
# Показать недавно использовавшиеся файлы на панели быстрого доступа (значение по умолчанию)
# QuickAccessRecentFiles -Show

# Hide frequently used folders in Quick access
# Скрыть недавно используемые папки на панели быстрого доступа
QuickAccessFrequentFolders -Hide

# Show frequently used folders in Quick access (default value)
# Показать часто используемые папки на панели быстрого доступа (значение по умолчанию)
# QuickAccessFrequentFolders -Show

# Set the taskbar alignment to the center (default value)
# Установить выравнивание панели задач по центру (значение по умолчанию)
TaskbarAlignment -Center

# Set the taskbar alignment to the left
# Установить выравнивание панели задач по левому краю
# TaskbarAlignment -Left

# Hide the widgets icon on the taskbar
# Скрыть кнопку "Мини-приложения" с панели задач
TaskbarWidgets -Hide

# Show the widgets icon on the taskbar (default value)
# Отобразить кнопку "Мини-приложения" на панели задач (значение по умолчанию)
# TaskbarWidgets -Show

# Hide the search on the taskbar
# Скрыть поле или значок поиска на панели задач
TaskbarSearch -Hide

# Show the search icon on the taskbar
# Показать значок поиска на панели задач
# TaskbarSearch -SearchIcon

# Show the search icon and label on the taskbar
# Показать значок и метку поиска на панели задач
# TaskbarSearch -SearchIconLabel

# Show the search box on the taskbar (default value)
# Показать поле поиска на панели задач (значение по умолчанию)
# TaskbarSearch -SearchBox

# Hide the Task view button from the taskbar
# Скрыть кнопку "Представление задач" с панели задач
TaskViewButton -Hide

# Show the Task view button on the taskbar (default value)
# Отобразить кнопку "Представление задач" на панели задач (значение по умолчанию)
# TaskViewButton -Show

# Hide the Chat icon (Microsoft Teams) on the taskbar and prevent Microsoft Teams from installing for new users
# Скрыть кнопку чата (Microsoft Teams) с панели задач и запретить установку Microsoft Teams для новых пользователей
TaskbarChat -Hide

# Show the Chat icon (Microsoft Teams) on the taskbar and remove block from installing Microsoft Teams for new users (default value)
# Отобразить кнопку чата (Microsoft Teams) на панели задач и убрать блокировку на устанвоку Microsoft Teams для новых пользователей (значение по умолчанию)
# TaskbarChat -Show

# Show seconds on the taskbar clock
# Показывать секунды на часах на панели задач
# SecondsInSystemClock -Show

# Hide seconds on the taskbar clock (default value)
# Скрыть секунды на часах на панели задач (значение по умолчанию)
SecondsInSystemClock -Hide

# Unpin the "Microsoft Edge", "Microsoft Store" shortcuts from the taskbar
# Открепить ярлыки "Microsoft Edge", "Microsoft Store" от панели задач
UnpinTaskbarShortcuts -Shortcuts Edge, Store

# View the Control Panel icons by large icons
# Просмотр иконок Панели управления как: крупные значки
# ControlPanelView -LargeIcons

# View the Control Panel icons by small icons
# Просмотр иконок Панели управления как: маленькие значки
# ControlPanelView -SmallIcons

# View the Control Panel icons by category (default value)
# Просмотр иконок Панели управления как: категория (значение по умолчанию)
ControlPanelView -Category

# Set the default Windows mode to dark
# Установить режим Windows по умолчанию на темный
WindowsColorMode -Dark

# Set the default Windows mode to light (default value)
# Установить режим Windows по умолчанию на светлый (значение по умолчанию)
# WindowsColorMode -Light

# Set the default app mode to dark
# Установить цвет режима приложения на темный
AppColorMode -Dark

# Set the default app mode to light (default value)
# Установить цвет режима приложения на светлый (значение по умолчанию)
# AppColorMode -Light

# Hide first sign-in animation after the upgrade
# Скрывать анимацию при первом входе в систему после обновления
FirstLogonAnimation -Disable

# Show first sign-in animation after the upgrade (default value)
# Показывать анимацию при первом входе в систему после обновления (значение по умолчанию)
# FirstLogonAnimation -Enable

# Set the quality factor of the JPEG desktop wallpapers to maximum
# Установить коэффициент качества обоев рабочего стола в формате JPEG на максимальный
JPEGWallpapersQuality -Max

# Set the quality factor of the JPEG desktop wallpapers to default
# Установить коэффициент качества обоев рабочего стола в формате JPEG по умолчанию
# JPEGWallpapersQuality -Default

# Do not add the "- Shortcut" suffix to the file name of created shortcuts
# Нe дoбaвлять "- яpлык" к имени coздaвaeмых яpлыков
ShortcutsSuffix -Disable

# Add the "- Shortcut" suffix to the file name of created shortcuts (default value)
# Дoбaвлять "- яpлык" к имени coздaвaeмых яpлыков (значение по умолчанию)
# ShortcutsSuffix -Enable

# Use the Print screen button to open screen snipping
# Использовать кнопку PRINT SCREEN, чтобы запустить функцию создания фрагмента экрана
# PrtScnSnippingTool -Enable

# Do not use the Print screen button to open screen snipping (default value)
# Не использовать кнопку PRINT SCREEN, чтобы запустить функцию создания фрагмента экрана (значение по умолчанию)
PrtScnSnippingTool -Disable

# Let me use a different input method for each app window
# Позволить выбирать метод ввода для каждого окна
AppsLanguageSwitch -Enable

# Do not use a different input method for each app window (default value)
# Не использовать метод ввода для каждого окна (значение по умолчанию)
# AppsLanguageSwitch -Disable

# When I grab a windows's title bar and shake it, minimize all other windows
# При захвате заголовка окна и встряхивании сворачиваются все остальные окна
AeroShaking -Enable

# When I grab a windows's title bar and shake it, don't minimize all other windows (default value)
# При захвате заголовка окна и встряхивании не сворачиваются все остальные окна (значение по умолчанию)
# AeroShaking -Disable

# Download and install free dark "Windows 11 Cursors Concept v2" cursors from Jepri Creations
# Скачать и установить бесплатные темные курсоры "Windows 11 Cursors Concept v2" от Jepri Creations
# Cursors -Dark

# Download and install free light "Windows 11 Cursors Concept v2" cursors from Jepri Creations
# Скачать и установить бесплатные светлые курсоры "Windows 11 Cursors Concept v2" от Jepri Creations
Cursors -Light

# Set default cursors
# Установить курсоры по умолчанию
# Cursors -Default

# Do not group files and folder in the Downloads folder
# Не группировать файлы и папки в папке Загрузки
FolderGroupBy -None

# Group files and folder by date modified in the Downloads folder (default value)
# Группировать файлы и папки по дате изменения (значение по умолчанию)
# FolderGroupBy -Default

# Do not expand to open folder on navigation pane (default value)
# Не разворачивать до открытой папки область навигации (значение по умолчанию)
NavigationPaneExpand -Disable

# Expand to open folder on navigation pane
# Развернуть до открытой папки область навигации
# NavigationPaneExpand -Enable
#endregion UI & Personalization

#region OneDrive
# Uninstall OneDrive. The OneDrive user folder won't be removed
# Удалить OneDrive. Папка пользователя OneDrive не будет удалена
OneDrive -Uninstall

# Install OneDrive 64-bit (default value)
# Установить OneDrive 64-бит (значение по умолчанию)
# OneDrive -Install

# Install OneDrive 64-bit all users to %ProgramFiles% depending which installer is triggered
# Установить OneDrive 64-бит для всех пользователей в %ProgramFiles% в зависимости от от того, как запускается инсталлятор
# OneDrive -Install -AllUsers
#endregion OneDrive

#region System
#region StorageSense
# Turn on Storage Sense
# Включить Контроль памяти
# StorageSense -Enable

# Turn off Storage Sense (default value)
# Выключить Контроль памяти (значение по умолчанию)
StorageSense -Disable

# Run Storage Sense every month
# Запускать Контроль памяти каждый месяц
# StorageSenseFrequency -Month

# Run Storage Sense during low free disk space (default value)
# Запускать Контроль памяти, когда остается мало место на диске (значение по умолчанию)
# StorageSenseFrequency -Default

# Turn on automatic cleaning up temporary system and app files (default value)
# Автоматически очищать временные файлы системы и приложений (значение по умолчанию)
# StorageSenseTempFiles -Enable

# Turn off automatic cleaning up temporary system and app files
# Не очищать временные файлы системы и приложений
# StorageSenseTempFiles -Disable
#endregion StorageSense

# Disable hibernation. It isn't recommended to turn off for laptops
# Отключить режим гибернации. Не рекомендуется выключать на ноутбуках
Hibernation -Disable

# Enable hibernate (default value)
# Включить режим гибернации (значение по умолчанию)
# Hibernation -Enable

# Change the %TEMP% environment variable path to %SystemDrive%\Temp
# Изменить путь переменной среды для %TEMP% на %SystemDrive%\Temp
# TempFolder -SystemDrive

# Change %TEMP% environment variable path to %LOCALAPPDATA%\Temp (default value)
# Изменить путь переменной среды для %TEMP% на %LOCALAPPDATA%\Temp (значение по умолчанию)
# TempFolder -Default

# Disable the Windows 260 characters path limit
# Отключить ограничение Windows на 260 символов в пути
Win32LongPathLimit -Disable

# Enable the Windows 260 character path limit (default value)
# Включить ограничение Windows на 260 символов в пути (значение по умолчанию)
# Win32LongPathLimit -Enable

# Display Stop error code when BSoD occurs
# Отображать код Stop-ошибки при появлении BSoD
BSoDStopError -Enable

# Do not Stop error code when BSoD occurs (default value)
# Не отображать код Stop-ошибки при появлении BSoD (значение по умолчанию)
# BSoDStopError -Disable

# Choose when to be notified about changes to your computer: never notify
# Настройка уведомления об изменении параметров компьютера: никогда не уведомлять
AdminApprovalMode -Never

# Choose when to be notified about changes to your computer: notify me only when apps try to make changes to my computer (default value)
# Настройка уведомления об изменении параметров компьютера: уведомлять меня только при попытках приложений внести изменения в компьютер (значение по умолчанию)
# AdminApprovalMode -Default

# Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled
# Включить доступ к сетевым дискам при включенном режиме одобрения администратором при доступе из программ, запущенных с повышенными правами
MappedDrivesAppElevatedAccess -Enable

# Turn off access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled (default value)
# Выключить доступ к сетевым дискам при включенном режиме одобрения администратором при доступе из программ, запущенных с повышенными правами (значение по умолчанию)
# MappedDrivesAppElevatedAccess -Disable

# Turn off Delivery Optimization
# Выключить оптимизацию доставки
DeliveryOptimization -Disable

# Turn on Delivery Optimization (default value)
# Включить оптимизацию доставки (значение по умолчанию)
# DeliveryOptimization -Enable

# Always wait for the network at computer startup and logon for workgroup networks
# Всегда ждать сеть при запуске и входе в систему для рабочих групп
WaitNetworkStartup -Enable

# Never wait for the network at computer startup and logon for workgroup networks (default value)
# Никогда не ждать сеть при запуске и входе в систему для рабочих групп (значение по умолчанию)
# WaitNetworkStartup -Disable

# Do not let Windows manage my default printer
# Не разрешать Windows управлять принтером, используемым по умолчанию
WindowsManageDefaultPrinter -Disable

# Let Windows manage my default printer (default value)
# Разрешать Windows управлять принтером, используемым по умолчанию (значение по умолчанию)
# WindowsManageDefaultPrinter -Enable

<#
	Disable the Windows features using the pop-up dialog box
	If you want to leave "Multimedia settings" element in the advanced settings of Power Options do not disable the "Media Features" feature

	Если вы хотите оставить параметр "Параметры мультимедиа" в дополнительных параметрах схемы управления питанием, не отключайте "Компоненты для работы с медиа"
	Отключить компоненты Windows, используя всплывающее диалоговое окно
#>
WindowsFeatures -Disable

# Enable the Windows features using the pop-up dialog box
# Включить компоненты Windows, используя всплывающее диалоговое окно
# WindowsFeatures -Enable

<#
	Uninstall optional features using the pop-up dialog box
	If you want to leave "Multimedia settings" element in the advanced settings of Power Options do not uninstall the "Media Features" feature

	Удалить дополнительные компоненты, используя всплывающее диалоговое окно
	Если вы хотите оставить параметр "Параметры мультимедиа" в дополнительных параметрах схемы управления питанием, не удаляйте компонент "Компоненты для работы с медиа"
#>
WindowsCapabilities -Uninstall

# Install optional features using the pop-up dialog box
# Установить дополнительные компоненты, используя всплывающее диалоговое окно
# WindowsCapabilities -Install

# Receive updates for other Microsoft products
# Получать обновления для других продуктов Майкрософт
# UpdateMicrosoftProducts -Enable

# Do not receive updates for other Microsoft products (default value)
# Не получать обновления для других продуктов Майкрософт (значение по умолчанию)
UpdateMicrosoftProducts -Disable

# Set power plan on "High performance". It isn't recommended to turn on for laptops
# Установить схему управления питанием на "Высокая производительность". Не рекомендуется включать на ноутбуках
# PowerPlan -High

# Set power plan on "Balanced" (default value)
# Установить схему управления питанием на "Сбалансированная" (значение по умолчанию)
PowerPlan -Balanced

# Do not allow the computer to turn off the network adapters to save power. It isn't recommended to turn off for laptops
# Запретить отключение всех сетевых адаптеров для экономии энергии. Не рекомендуется выключать на ноутбуках
NetworkAdaptersSavePower -Disable

# Allow the computer to turn off the network adapters to save power (default value)
# Разрешить отключение всех сетевых адаптеров для экономии энергии (значение по умолчанию)
# NetworkAdaptersSavePower -Enable

<#
	Disable the Internet Protocol Version 6 (TCP/IPv6) component for all network connections
	Before invoking the function, a check will be run whether your ISP supports the IPv6 protocol using https://ipify.org

	Выключить IP версии 6 (TCP/IPv6)
	Перед выполнением функции будет проведена проверка: поддерживает ли ваш провайдер IPv6, используя ресурс https://ipify.org
#>
IPv6Component -Disable

<#
	Enable the Internet Protocol Version 6 (TCP/IPv6) component for all network connections (default value)
	Before invoking the function, a check will be run whether your ISP supports the IPv6 protocol using https://ipify.org

	Включить IP версии 6 (TCP/IPv6) (значение по умолчанию)
	Перед выполнением функции будет проведена проверка: поддерживает ли ваш провайдер IPv6, используя ресурс https://ipify.org
#>
# IPv6Component -Enable

<#
	Enable the Internet Protocol Version 6 (TCP/IPv6) component for all network connections. Prefer IPv4 over IPv6
	Before invoking the function, a check will be run whether your ISP supports the IPv6 protocol using https://ipify.org

	Включить IP версии 6 (TCP/IPv6) и предпочитать. Предпочтение IPv4 перед IPv6
	Перед выполнением функции будет проведена проверка: поддерживает ли ваш провайдер IPv6, используя ресурс https://ipify.org
#>
# IPv6Component -PreferIPv4overIPv6

# Override for default input method: English
# Переопределить метод ввода по умолчанию: английский
InputMethod -English

# Override for default input method: use language list (default value)
# Переопределить метод ввода по умолчанию: использовать список языков (значение по умолчанию)
# InputMethod -Default

<#
	Change user folders location to the root of any drive using the interactive menu
	User files or folders won't me moved to a new location. Move them manually
	They're located in the %USERPROFILE% folder by default

	Переместить пользовательские папки в корень любого диска на выбор с помощью интерактивного меню
	Пользовательские файлы и папки не будут перемещены в новое расположение. Переместите их вручную
	По умолчанию они располагаются в папке %USERPROFILE%
#>
# Set-UserShellFolderLocation -Root

<#
	Select folders for user folders location manually using a folder browser dialog
	User files or folders won't me moved to a new location. Move them manually
	They're located in the %USERPROFILE% folder by default

	Выбрать папки для расположения пользовательских папок вручную, используя диалог "Обзор папок"
	Пользовательские файлы и папки не будут перемещены в новое расположение. Переместите их вручную
	По умолчанию они располагаются в папке %USERPROFILE%
#>
# Set-UserShellFolderLocation -Custom

<#
	Change user folders location to the default values
	User files or folders won't me moved to the new location. Move them manually
	They're located in the %USERPROFILE% folder by default

	Изменить расположение пользовательских папок на значения по умолчанию
	Пользовательские файлы и папки не будут перемещены в новое расположение. Переместите их вручную
	По умолчанию они располагаются в папке %USERPROFILE%
#>
Set-UserShellFolderLocation -Default

# Use the latest installed .NET runtime for all apps
# Использовать последнюю установленную среду выполнения .NET для всех приложений
# LatestInstalled.NET -Enable

# Do not use the latest installed .NET runtime for all apps (default value)
# Не использовать последнюю установленную версию .NET для всех приложений (значение по умолчанию)
# LatestInstalled.NET -Disable

<#
	Save screenshots by pressing Win+PrtScr on the Desktop
	The function will be applied only if the preset is configured to remove the OneDrive application, or the app was already uninstalled
	Otherwise the backup functionality for the "Desktop" and "Pictures" folders in OneDrive breaks

	Сохранять скриншоты по нажатию Win+PrtScr на рабочий столе
	Функция будет применена только в случае, если в пресете настроено удаление приложения OneDrive или приложение уже удалено,
	иначе в OneDrive ломается функционал резервного копирования для папок "Рабочий стол" и "Изображения"
#>
WinPrtScrFolder -Desktop

# Save screenshots by pressing Win+PrtScr in the Pictures folder (default value)
# Cохранять скриншоты по нажатию Win+PrtScr в папку "Изображения" (значение по умолчанию)
# WinPrtScrFolder -Default

<#
	Run troubleshooter automatically, then notify me
	In order this feature to work the OS level of diagnostic data gathering will be set to "Optional diagnostic data", and the error reporting feature will be turned on

	Автоматически запускать средства устранения неполадок, а затем уведомлять
	Чтобы заработала данная функция, уровень сбора диагностических данных ОС будет установлен на "Необязательные диагностические данные" и включится создание отчетов об ошибках Windows
#>
RecommendedTroubleshooting -Automatically

<#
	Ask me before running troubleshooter (default value)
	In order this feature to work the OS level of diagnostic data gathering will be set to "Optional diagnostic data"

	Спрашивать перед запуском средств устранения неполадок (значение по умолчанию)
	Чтобы заработала данная функция, уровень сбора диагностических данных ОС будет установлен на "Необязательные диагностические данные" и включится создание отчетов об ошибках Windows
#>
# RecommendedTroubleshooting -Default

# Launch folder windows in a separate process
# Запускать окна с папками в отдельном процессе
FoldersLaunchSeparateProcess -Enable

# Do not launch folder windows in a separate process (default value)
# Не запускать окна с папками в отдельном процессе (значение по умолчанию)
# FoldersLaunchSeparateProcess -Disable

# Disable and delete reserved storage after the next update installation
# Отключить и удалить зарезервированное хранилище после следующей установки обновлений
ReservedStorage -Disable

# Enable reserved storage (default value)
# Включить зарезервированное хранилище (значение по умолчанию)
# ReservedStorage -Enable

# Disable help lookup via F1
# Отключить открытие справки по нажатию F1
F1HelpPage -Disable

# Enable help lookup via F1 (default value)
# Включить открытие справки по нажатию F1 (значение по умолчанию)
# F1HelpPage -Enable

# Enable Num Lock at startup
# Включить Num Lock при загрузке
# NumLock -Enable

# Disable Num Lock at startup (default value)
# Выключить Num Lock при загрузке (значение по умолчанию)
# NumLock -Disable

# Disable Caps Lock
# Выключить Caps Lock
# CapsLock -Disable

# Enable Caps Lock (default value)
# Включить Caps Lock (значение по умолчанию)
# CapsLock -Enable

# Turn off pressing the Shift key 5 times to turn Sticky keys
# Выключить залипание клавиши Shift после 5 нажатий
StickyShift -Disable

# Turn on pressing the Shift key 5 times to turn Sticky keys (default value)
# Включить залипание клавиши Shift после 5 нажатий (значение по умолчанию)
# StickyShift -Enable

# Don't use AutoPlay for all media and devices
# Не использовать автозапуск для всех носителей и устройств
Autoplay -Disable

# Use AutoPlay for all media and devices (default value)
# Использовать автозапуск для всех носителей и устройств (значение по умолчанию)
# Autoplay -Enable

# Disable thumbnail cache removal
# Отключить удаление кэша миниатюр
ThumbnailCacheRemoval -Disable

# Enable thumbnail cache removal (default value)
# Включить удаление кэша миниатюр (значение по умолчанию)
# ThumbnailCacheRemoval -Enable

# Automatically saving my restartable apps and restart them when I sign back in
# Автоматически сохранять мои перезапускаемые приложения из системы и перезапускать их при повторном входе
# SaveRestartableApps -Enable

# Turn off automatically saving my restartable apps and restart them when I sign back in (default value)
# Выключить автоматическое сохранение моих перезапускаемых приложений из системы и перезапускать их при повторном входе (значение по умолчанию)
SaveRestartableApps -Disable

# Enable "Network Discovery" and "File and Printers Sharing" for workgroup networks
# Включить сетевое обнаружение и общий доступ к файлам и принтерам для рабочих групп
# NetworkDiscovery -Enable

# Disable "Network Discovery" and "File and Printers Sharing" for workgroup networks (default value)
# Выключить сетевое обнаружение и общий доступ к файлам и принтерам для рабочих групп (значение по умолчанию)
NetworkDiscovery -Disable

# Notify me when a restart is required to finish updating
# Уведомлять меня о необходимости перезагрузки для завершения обновления
RestartNotification -Show

# Do not notify me when a restart is required to finish updating (default value)
# Не yведомлять меня о необходимости перезагрузки для завершения обновления (значение по умолчанию)
# RestartNotification -Hide

# Restart as soon as possible to finish updating
# Перезапустить устройство как можно быстрее, чтобы завершить обновление
RestartDeviceAfterUpdate -Enable

# Don't restart as soon as possible to finish updating (default value)
# Не перезапускать устройство как можно быстрее, чтобы завершить обновление (значение по умолчанию)
# RestartDeviceAfterUpdate -Disable

# Automatically adjust active hours for me based on daily usage
# Автоматически изменять период активности для этого устройства на основе действий
ActiveHours -Automatically

# Manually adjust active hours for me based on daily usage (default value)
# Вручную изменять период активности для этого устройства на основе действий (значение по умолчанию)
# ActiveHours -Manually

# Do not get Windows updates as soon as they're available for your device (default value)
# Не получать последние обновления, как только они будут доступны (значение по умолчанию)
WindowsLatestUpdate -Disable

# Get Windows updates as soon as they're available for your device
# Получайте последние обновления, как только они будут доступны
# WindowsLatestUpdate -Enable

<#
	Register app, calculate hash, and associate with an extension with the "How do you want to open this" pop-up hidden
	Зарегистрировать приложение, вычислить хэш и ассоциировать его с расширением без всплывающего окна "Каким образом вы хотите открыть этот файл?"

	Set-Association -ProgramPath "C:\SumatraPDF.exe" -Extension .pdf -Icon "shell32.dll,100"
	Set-Association -ProgramPath "%ProgramFiles%\Notepad++\notepad++.exe" -Extension .txt -Icon "%ProgramFiles%\Notepad++\notepad++.exe,0"
	Set-Association -ProgramPath MSEdgeMHT -Extension .html
#>
# Set-Association -ProgramPath "%ProgramFiles%\Notepad++\notepad++.exe" -Extension .txt -Icon "%ProgramFiles%\Notepad++\notepad++.exe,0"

# Экспортировать все ассоциации в Windows в корень папки в виде файла Application_Associations.json
# Export all Windows associations into Application_Associations.json file to script root folder
# Export-Associations

<#
	Импортировать все ассоциации в Windows из файла Application_Associations.json
	Вам необходимо установить все приложения согласно экспортированному файлу Application_Associations.json, чтобы восстановить все ассоциации

	Import all Windows associations from an Application_Associations.json file
	You need to install all apps according to an exported Application_Associations.json file to restore all associations
#>
# Import-Associations

# Set Windows Terminal as default terminal app to host the user interface for command-line applications
# Установить Windows Terminal как приложение терминала по умолчанию для размещения пользовательского интерфейса для приложений командной строки
DefaultTerminalApp -WindowsTerminal

# Set Windows Console Host as default terminal app to host the user interface for command-line applications (default value)
# Установить Windows Console Host как приложение терминала по умолчанию для размещения пользовательского интерфейса для приложений командной строки (значение по умолчанию)
# DefaultTerminalApp -ConsoleHost

<#
	Install the latest Microsoft Visual C++ Redistributable Packages 2015–2022 (x86/x64)
	Установить последнюю версию распространяемых пакетов Microsoft Visual C++ 2015–2022 (x86/x64)

	https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist
#>
# InstallVCRedist

<#
	Install the latest .NET Desktop Runtime 6, 7 (x86/x64)
	Установить последнюю версию .NET Desktop Runtime 6, 7 (x86/x64)

	https://dotnet.microsoft.com/en-us/download/dotnet
#>
# InstallDotNetRuntimes

# Enable proxying only blocked sites from the unified registry of Roskomnadzor. The function is applicable for Russia only
# Включить проксирование только заблокированных сайтов из единого реестра Роскомнадзора. Функция применима только для России
# https://antizapret.prostovpn.org
# RKNBypass -Enable

# Disable proxying only blocked sites from the unified registry of Roskomnadzor (default value)
# Выключить проксирование только заблокированных сайтов из единого реестра Роскомнадзора (значение по умолчанию)
# https://antizapret.prostovpn.org
# RKNBypass -Disable

# Enable all necessary dependencies (reboot may require) and open Microsoft Store WSA page to install Windows Subsystem for Android™ with Amazon Appstore manually
# Включить все необходимые зависимости (может потребоваться перезагрузка) и открыть страницу WSA в Microsoft Store, чтобы вручную установить Windows Subsystem for Android™ with Amazon Appstore
# Install-WSA

# List Microsoft Edge channels to prevent desktop shortcut creation upon its' update
# Перечислите каналы Microsoft Edge для предотвращения создания ярлыков на рабочем столе после его обновления
PreventEdgeShortcutCreation -Channels Stable, Beta, Dev, Canary

# Do not prevent desktop shortcut creation upon Microsoft Edge update (default value)
# Не предотвращать создание ярлыков на рабочем столе при обновлении Microsoft Edge (значение по умолчанию)
# PreventEdgeShortcutCreation -Disable

# Prevent all internal SATA drives from showing up as removable media in the taskbar notification area
# Запретить отображать все внутренние SATA-диски как съемные носители в области уведомлений на панели задач
SATADrivesRemovableMedia -Disable

# Show up all internal SATA drives as removeable media in the taskbar notification area (default value)
# Отображать все внутренние SATA-диски как съемные носители в области уведомлений на панели задач (значение по умолчанию)
# SATADrivesRemovableMedia -Default
#endregion System

#region WSL
<#
	Enable Windows Subsystem for Linux (WSL), install the latest WSL Linux kernel version, and a Linux distribution using a pop-up form
	The "Receive updates for other Microsoft products" setting will enabled automatically to receive kernel updates

	Установить подсистему Windows для Linux (WSL), последний пакет обновления ядра Linux и дистрибутив Linux, используя всплывающую форму
	Параметр "При обновлении Windows получать обновления для других продуктов Майкрософт" будет включен автоматически в Центре обновлении Windows, чтобы получать обновления ядра
#>
# Install-WSL
#endregion WSL

#region Start menu
# Unpin all Start apps
# Открепить все приложения от начального экрана
UnpinAllStartApps

# Show default Start layout (default value)
# Отображать стандартный макет начального экрана (значение по умолчанию)
# StartLayout -Default

# Show more pins on Start
# Отображать больше закреплений на начальном экране
StartLayout -ShowMorePins

# Show more recommendations on Start
# Отображать больше рекомендаций на начальном экране
# StartLayout -ShowMoreRecommendations
#endregion Start menu

#region UWP apps
<#
	Uninstall UWP apps using the pop-up dialog box
	If the "For All Users" is checked apps packages will not be installed for new users
	The "ForAllUsers" argument sets a checkbox to unistall packages for all users

	Удалить UWP-приложения, используя всплывающее диалоговое окно
	Пакеты приложений не будут установлены для новых пользователей, если отмечена галочка "Для всех пользователей"
	Аргумент "ForAllUsers" устанавливает галочку для удаления пакетов для всех пользователей
#>
UninstallUWPApps

<#
	Restore the default UWP apps using the pop-up dialog box
	UWP apps can be restored only if they were uninstalled only for the current user

	Восстановить стандартные UWP-приложения, используя всплывающее диалоговое окно
	UWP-приложения могут быть восстановлены, только если они были удалены для текущего пользователя
#>
# RestoreUWPApps

# Download and install "HEVC Video Extensions from Device Manufacturer" to be able to open .heic and .heif formats
# Скачать и установить "Расширения для видео HEVC от производителя устройства", чтобы иметь возможность открывать форматы .heic и .heif
# HEVC -Install

<#
	Open Microsoft Store "HEVC Video Extensions from Device Manufacturer" page to install this extension manually to be able to open .heic and .heif formats
	The extension can be installed without an Microsoft account

	Открыть страницу "Расширения для видео HEVC от производителя устройства" в Microsoft Store, чтобы вручную установить расширение для открытия форматов .heic и .heif
	Расширение может быть установлено бесплатно без учетной записи Microsoft
#>
# HEVC -Manually

# Disable Cortana autostarting
# Выключить автозагрузку Кортана
CortanaAutostart -Disable

# Enable Cortana autostarting (default value)
# Включить автозагрузку Кортана (значение по умолчанию)
# CortanaAutostart -Enable

# Disable Microsoft Teams autostarting
# Выключить автозагрузку Microsoft Teams
TeamsAutostart -Disable

# Enable Microsoft Teams autostarting (default value)
# Включить автозагрузку Microsoft Teams (значение по умолчанию)
# TeamsAutostart -Enable
#endregion UWP apps

#region Gaming
<#
	Disable Xbox Game Bar
	To prevent popping up the "You'll need a new app to open this ms-gamingoverlay" warning, you need to disable the Xbox Game Bar app, even if you uninstalled it before

	Отключить Xbox Game Bar
	Чтобы предотвратить появление предупреждения "Вам понадобится новое приложение, чтобы открыть этот ms-gamingoverlay", вам необходимо отключить приложение Xbox Game Bar, даже если вы удалили его раньше
#>
XboxGameBar -Disable

# Enable Xbox Game Bar (default value)
# Включить Xbox Game Bar (значение по умолчанию)
# XboxGameBar -Enable

# Disable Xbox Game Bar tips
# Отключить советы Xbox Game Bar
XboxGameTips -Disable

# Enable Xbox Game Bar tips (default value)
# Включить советы Xbox Game Bar (значение по умолчанию)
# XboxGameTips -Enable

# Choose an app and set the "High performance" graphics performance for it. Only if you have a dedicated GPU
# Выбрать приложение и установить для него параметры производительности графики на "Высокая производительность". Только при наличии внешней видеокарты
# Set-AppGraphicsPerformance

<#
	Turn on hardware-accelerated GPU scheduling. Restart needed
	Only if you have a dedicated GPU and WDDM verion is 2.7 or higher

	Включить планирование графического процессора с аппаратным ускорением. Необходима перезагрузка
	Только при наличии внешней видеокарты и WDDM версии 2.7 и выше
#>
GPUScheduling -Enable

# Turn off hardware-accelerated GPU scheduling (default value). Restart needed
# Выключить планирование графического процессора с аппаратным ускорением (значение по умолчанию). Необходима перезагрузка
# GPUScheduling -Disable
#endregion Gaming

#region Scheduled tasks
<#
	Create the "Windows Cleanup" scheduled task for cleaning up Windows unused files and updates.
	A native interactive toast notification pops up every 30 days. You have to enable Windows Script Host in order to make the function work

	Создать задание "Windows Cleanup" по очистке неиспользуемых файлов и обновлений Windows в Планировщике заданий.
	Задание выполняется каждые 30 дней. Необходимо включить Windows Script Host для того, чтобы работала функция
#>
# CleanupTask -Register

# Delete the "Windows Cleanup" and "Windows Cleanup Notification" scheduled tasks for cleaning up Windows unused files and updates
# Удалить задания "Windows Cleanup" и "Windows Cleanup Notification" по очистке неиспользуемых файлов и обновлений Windows из Планировщика заданий
# CleanupTask -Delete

<#
	Create the "SoftwareDistribution" scheduled task for cleaning up the %SystemRoot%\SoftwareDistribution\Download folder
	The task will wait until the Windows Updates service finishes running. The task runs every 90 days. You have to enable Windows Script Host in order to make the function work

	Создать задание "SoftwareDistribution" по очистке папки %SystemRoot%\SoftwareDistribution\Download в Планировщике заданий
	Задание будет ждать, пока служба обновлений Windows не закончит работу. Задание выполняется каждые 90 дней. Необходимо включить Windows Script Host для того, чтобы работала функция
#>
# SoftwareDistributionTask -Register

# Delete the "SoftwareDistribution" scheduled task for cleaning up the %SystemRoot%\SoftwareDistribution\Download folder
# Удалить задание "SoftwareDistribution" по очистке папки %SystemRoot%\SoftwareDistribution\Download из Планировщика заданий
# SoftwareDistributionTask -Delete

<#
	Create the "Temp" scheduled task for cleaning up the %TEMP% folder
	Only files older than one day will be deleted. The task runs every 60 days. You have to enable Windows Script Host in order to make the function work

	Создать задание "Temp" в Планировщике заданий по очистке папки %TEMP%
	Удаляться будут только файлы старше одного дня. Задание выполняется каждые 60 дней. Необходимо включить Windows Script Host для того, чтобы работала функция
#>
# TempTask -Register

# Delete the "Temp" scheduled task for cleaning up the %TEMP% folder
# Удалить задание "Temp" по очистке папки %TEMP% из Планировщика заданий
# TempTask -Delete
#endregion Scheduled tasks

#region Microsoft Defender & Security
# Enable Microsoft Defender Exploit Guard network protection
# Включить защиту сети в Microsoft Defender Exploit Guard
# NetworkProtection -Enable

# Disable Microsoft Defender Exploit Guard network protection (default value)
# Выключить защиту сети в Microsoft Defender Exploit Guard (значение по умолчанию)
NetworkProtection -Disable

# Enable detection for potentially unwanted applications and block them
# Включить обнаружение потенциально нежелательных приложений и блокировать их
# PUAppsDetection -Enable

# Disable detection for potentially unwanted applications and block them (default value)
# Выключить обнаружение потенциально нежелательных приложений и блокировать их (значение по умолчанию)
PUAppsDetection -Disable

# Dismiss Microsoft Defender offer in the Windows Security about signing in Microsoft account
# Отклонить предложение Microsoft Defender в "Безопасность Windows" о входе в аккаунт Microsoft
DismissMSAccount

# Dismiss Microsoft Defender offer in the Windows Security about turning on the SmartScreen filter for Microsoft Edge
# Отклонить предложение Microsoft Defender в "Безопасность Windows" включить фильтр SmartScreen для Microsoft Edge
DismissSmartScreenFilter

# Enable events auditing generated when a process is created (starts)
# Включить аудит событий, возникающих при создании или запуске процесса
# AuditProcess -Enable

# Disable events auditing generated when a process is created (starts) (default value)
# Выключить аудит событий, возникающих при создании или запуске процесса (значение по умолчанию)
AuditProcess -Disable

<#
	Include command line in process creation events
	In order this feature to work events auditing (ProcessAudit -Enable) will be enabled

	Включать командную строку в событиях создания процесса
	Для того, чтобы работал данный функционал, будет включен аудит событий (AuditProcess -Enable)
#>
# CommandLineProcessAudit -Enable

# Do not include command line in process creation events (default value)
# Не включать командную строку в событиях создания процесса (значение по умолчанию)
CommandLineProcessAudit -Disable

<#
	Create the "Process Creation" сustom view in the Event Viewer to log executed processes and their arguments
	In order this feature to work events auditing (AuditProcess -Enable) and command line (CommandLineProcessAudit -Enable) in process creation events will be enabled

	Создать настраиваемое представление "Создание процесса" в Просмотре событий для журналирования запускаемых процессов и их аргументов
	Для того, чтобы работал данный функционал, буден включен аудит событий (AuditProcess -Enable) и командной строки (CommandLineProcessAudit -Enable) в событиях создания процесса
#>
EventViewerCustomView -Enable

# Remove the "Process Creation" custom view in the Event Viewer to log executed processes and their arguments (default value)
# Удалить настраиваемое представление "Создание процесса" в Просмотре событий для журналирования запускаемых процессов и их аргументов (значение по умолчанию)
# EventViewerCustomView -Disable

# Enable logging for all Windows PowerShell modules
# Включить ведение журнала для всех модулей Windows PowerShell
# PowerShellModulesLogging -Enable

# Disable logging for all Windows PowerShell modules (default value)
# Выключить ведение журнала для всех модулей Windows PowerShell (значение по умолчанию)
PowerShellModulesLogging -Disable

# Enable logging for all PowerShell scripts input to the Windows PowerShell event log
# Включить ведение журнала для всех вводимых сценариев PowerShell в журнале событий Windows PowerShell
# PowerShellScriptsLogging -Enable

# Disable logging for all PowerShell scripts input to the Windows PowerShell event log (default value)
# Выключить ведение журнала для всех вводимых сценариев PowerShell в журнале событий Windows PowerShell (значение по умолчанию)
PowerShellScriptsLogging -Disable

# Microsoft Defender SmartScreen doesn't marks downloaded files from the Internet as unsafe
# Microsoft Defender SmartScreen не помечает скачанные файлы из интернета как небезопасные
AppsSmartScreen -Disable

# Microsoft Defender SmartScreen marks downloaded files from the Internet as unsafe (default value)
# Microsoft Defender SmartScreen помечает скачанные файлы из интернета как небезопасные (значение по умолчанию)
# AppsSmartScreen -Enable

# Disable the Attachment Manager marking files that have been downloaded from the Internet as unsafe
# Выключить проверку Диспетчером вложений файлов, скачанных из интернета, как небезопасные
SaveZoneInformation -Disable

# Enable the Attachment Manager marking files that have been downloaded from the Internet as unsafe (default value)
# Включить проверку Диспетчера вложений файлов, скачанных из интернета как небезопасные (значение по умолчанию)
# SaveZoneInformation -Enable

# Disable Windows Script Host. Blocks WSH from executing .js and .vbs files
# Отключить Windows Script Host. Блокирует запуск файлов .js и .vbs
WindowsScriptHost -Disable

# Enable Windows Script Host (default value)
# Включить Windows Script Host (значение по умолчанию)
# WindowsScriptHost -Enable

# Enable Windows Sandbox
# Включить Windows Sandbox
# WindowsSandbox -Enable

# Disable Windows Sandbox (default value)
# Выключить Windows Sandbox (значение по умолчанию)
# WindowsSandbox -Disable

<#
	Enable DNS-over-HTTPS for IPv4
	The valid IPv4 addresses: 1.0.0.1, 1.1.1.1, 149.112.112.112, 8.8.4.4, 8.8.8.8, 9.9.9.9

	Включить DNS-over-HTTPS для IPv4
	Действительные IPv4-адреса: 1.0.0.1, 1.1.1.1, 149.112.112.112, 8.8.4.4, 8.8.8.8, 9.9.9.9
#>
# DNSoverHTTPS -Enable -PrimaryDNS 1.0.0.1 -SecondaryDNS 1.1.1.1

# Disable DNS-over-HTTPS for IPv4 (default value)
# Выключить DNS-over-HTTPS для IPv4 (значение по умолчанию)
# DNSoverHTTPS -Disable

# Enable Local Security Authority protection to prevent code injection
# Включить защиту локальной системы безопасности, чтобы предотвратить внедрение кода
LocalSecurityAuthority -Enable

# Disable Local Security Authority protection (default value)
# Выключить защиту локальной системы безопасности (значение по умолчанию)
# LocalSecurityAuthority -Disable
#endregion Microsoft Defender & Security

#region Context menu
# Show the "Extract all" item in the Windows Installer (.msi) context menu
# Отобразить пункт "Извлечь все" в контекстное меню Windows Installer (.msi)
# MSIExtractContext -Show

# Hide the "Extract all" item from the Windows Installer (.msi) context menu (default value)
# Скрыть пункт "Извлечь все" из контекстного меню Windows Installer (.msi) (значение по умолчанию)
MSIExtractContext -Hide

# Show the "Install" item in the Cabinet (.cab) filenames extensions context menu
# Отобразить пункт "Установить" в контекстное меню .cab архивов
# CABInstallContext -Show

# Hide the "Install" item from the Cabinet (.cab) filenames extensions context menu (default value)
# Скрыть пункт "Установить" из контекстного меню .cab архивов (значение по умолчанию)
CABInstallContext -Hide

# Show the "Run as different user" item to the .exe filename extensions context menu
# Отобразить пункт "Запуск от имени другого пользователя" в контекстное меню .exe файлов
# RunAsDifferentUserContext -Show

# Hide the "Run as different user" item from the .exe filename extensions context menu (default value)
# Скрыть пункт "Запуск от имени другого пользователя" из контекстное меню .exe файлов (значение по умолчанию)
RunAsDifferentUserContext -Hide

# Hide the "Cast to Device" item from the media files and folders context menu
# Скрыть пункт "Передать на устройство" из контекстного меню медиа-файлов и папок
CastToDeviceContext -Hide

# Show the "Cast to Device" item in the media files and folders context menu (default value)
# Отобразить пункт "Передать на устройство" в контекстном меню медиа-файлов и папок (значение по умолчанию)
# CastToDeviceContext -Show

# Hide the "Share" item from the context menu
# Скрыть пункт "Отправить" (поделиться) из контекстного меню
ShareContext -Hide

# Show the "Share" item in the context menu (default value)
# Отобразить пункт "Отправить" (поделиться) в контекстном меню (значение по умолчанию)
# ShareContext -Show

# Hide the "Edit with Clipchamp" item from the media files context menu
# Скрыть пункт "Редактировать в Climpchamp" из контекстного меню
EditWithClipchampContext -Hide

# Show the "Edit with Clipchamp" item in the media files context menu (default value)
# Отобразить пункт "Редактировать в Climpchamp" в контекстном меню (значение по умолчанию)
# EditWithClipchampContext -Show

# Hide the "Print" item from the .bat and .cmd context menu
# Скрыть пункт "Печать" из контекстного меню .bat и .cmd файлов
PrintCMDContext -Hide

# Show the "Print" item in the .bat and .cmd context menu (default value)
# Отобразить пункт "Печать" в контекстном меню .bat и .cmd файлов (значение по умолчанию)
# PrintCMDContext -Show

# Hide the "Include in Library" item from the folders and drives context menu
# Скрыть пункт "Добавить в библиотеку" из контекстного меню папок и дисков
IncludeInLibraryContext -Hide

# Show the "Include in Library" item in the folders and drives context menu (default value)
# Отобразить пункт "Добавить в библиотеку" в контекстном меню папок и дисков (значение по умолчанию)
# IncludeInLibraryContext -Show

# Hide the "Send to" item from the folders context menu
# Скрыть пункт "Отправить" из контекстного меню папок
SendToContext -Hide

# Show the "Send to" item in the folders context menu (default value)
# Отобразить пункт "Отправить" в контекстном меню папок (значение по умолчанию)
# SendToContext -Show

# Hide the "Compressed (zipped) Folder" item from the "New" context menu
# Скрыть пункт "Сжатая ZIP-папка" из контекстного меню "Создать"
CompressedFolderNewContext -Hide

# Show the "Compressed (zipped) Folder" item to the "New" context menu (default value)
# Отобразить пункт "Сжатая ZIP-папка" в контекстном меню "Создать" (значение по умолчанию)
# CompressedFolderNewContext -Show

# Enable the "Open", "Print", and "Edit" context menu items for more than 15 items selected
# Включить элементы контекстного меню "Открыть", "Изменить" и "Печать" при выделении более 15 элементов
# MultipleInvokeContext -Enable

# Disable the "Open", "Print", and "Edit" context menu items for more than 15 items selected (default value)
# Отключить элементы контекстного меню "Открыть", "Изменить" и "Печать" при выделении более 15 элементов (значение по умолчанию)
MultipleInvokeContext -Disable

# Hide the "Look for an app in the Microsoft Store" item in the "Open with" dialog
# Скрыть пункт "Поиск приложения в Microsoft Store" в диалоге "Открыть с помощью"
UseStoreOpenWith -Hide

# Show the "Look for an app in the Microsoft Store" item in the "Open with" dialog (default value)
# Отобразить пункт "Поиск приложения в Microsoft Store" в диалоге "Открыть с помощью" (значение по умолчанию)
# UseStoreOpenWith -Show

# Show the "Open in Windows Terminal" item in the folders context menu (default value)
# Отобразить пункт "Открыть в Терминале Windows" в контекстном меню папок (значение по умолчанию)
OpenWindowsTerminalContext -Show

# Hide the "Open in Windows Terminal" item in the folders context menu
# Скрыть пункт "Открыть в Терминале Windows" в контекстном меню папок
# OpenWindowsTerminalContext -Hide

# Open Windows Terminal in context menu as administrator by default
# Открывать Windows Terminal из контекстного меню от имени администратора по умолчанию
# OpenWindowsTerminalAdminContext -Enable

# Do not open Windows Terminal in context menu as administrator by default (default value)
# Не открывать Windows Terminal из контекстного меню от имени администратора по умолчанию (значение по умолчанию)
OpenWindowsTerminalAdminContext -Disable

# Disable the Windows 10 context menu style (default value)
# Отключить стиль контекстного меню из Windows 10 (значение по умолчанию)
Windows10ContextMenu -Disable

# Enable the Windows 10 context menu style
# Включить стиль контекстного меню из Windows 10
# Windows10ContextMenu -Enable
#endregion Context menu

#region Update Policies
<#
	Display all policy registry keys (even manually created ones) in the Local Group Policy Editor snap-in (gpedit.msc)
	This can take up to 30 minutes, depending on on the number of policies created in the registry and your system resources

	Отобразить все политики реестра (даже созданные вручную) в оснастке Редактора локальной групповой политики (gpedit.msc)
	Это может занять до 30 минут в зависимости от количества политик, созданных в реестре, и мощности вашей системы
#>
# UpdateLGPEPolicies
#endregion Update Policies

# Environment refresh and other neccessary post actions
# Обновление окружения и прочие необходимые действия после выполнения основных функций
PostActions

# Errors output
# Вывод ошибок
Errors

# SIG # Begin signature block
# MIIblQYJKoZIhvcNAQcCoIIbhjCCG4ICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUhldoaLmX8Jj19djIyEUVcv/4
# sSSgghYNMIIDAjCCAeqgAwIBAgIQaksVnyyz84NPdVUTWD8u7zANBgkqhkiG9w0B
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
# CSqGSIb3DQEJBDEWBBRpIDEh1sr7OHSGfUd2jOjOKqV/FzANBgkqhkiG9w0BAQEF
# AASCAQBLsJScUNnsfvXMn6V7lbzfdhfgCoC54XvEp3Hjsu7rFfUzgYlq5aaUVmFI
# whorkqHUXRNG3c59PBqK+207uSA+Zucfr87/3q6LZ11WrDjaAqRF2aNFlqJtZMqH
# YAS5iVOVfjtZ861+YvaAO+j0+6Svo/UVSi8/k40E4Dvm5n13Pue/8qU7uMCCy5bW
# Ty4IaaSh8VmbLmTqss9O4qX3XcWc49MECUjlHyfbQ5btxmVLlnsoFuszIL/7y7qr
# iNBiEUFVhgpUCPXHjxsN/AdtQ8MWPjX4hnMJCVrcfLmm5dwEVYNOffVhBa36yEZ3
# pjsCNHG8TfmVzrLwCVlY2r8lWebqoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJ
# AgEBMHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTsw
# OQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVT
# dGFtcGluZyBDQQIQDE1pckuU+jwqSj0pB4A9WjANBglghkgBZQMEAgEFAKBpMBgG
# CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcxNjE3
# MjAzMVowLwYJKoZIhvcNAQkEMSIEIFBRtIQDd47tsBwkQx9BelFyyMw7PSJKwC8O
# F4Y7/QPmMA0GCSqGSIb3DQEBAQUABIICAHtVov1RVgG/8SB3FVvudY2QD36X2s3i
# lgOiN5thn366ctMlN3fQ8AuFzEMEj94kTBr796Z1+6wmrWSBIm/snTYNLCKOBnyO
# P9eNxpnwqk8r2powqYhi/Hkj3WbyrjzYC7CUofAw2ndNnNwDLh+gKFU6bs1pytxv
# VmZeQzk5v7UQSHkwGteR4T4o/8iTd2QrzQ0fGo+v3qOsdz/EgBSES4HDqfL5WxDp
# bjjkeKkzj5m0Dfs5ZscAHXzJn6X2NUQn3vqJ2WeqsqhSpOwM2kpT/k3eJNvvKHgy
# kUoKKEhxlRwpbD7LO/vDRETP84RHXpxaDduUZhkreVOEMi+uEcqrTeAz4lOrEphr
# LHFrDVcyGwyUTaPizJRDuMsYdsBRV519QCC4TVqw3Z/j3yuFoKRDtm8YywRGMD4B
# 5RCf+cyzdZwoa4LFNKkHZ8/iTUn142Bl+CUbEaXBOIlbut1IfdfSJK2AN0yCkNhI
# 9f6ax/yzaBpRqmxnIU0+MlTtdpE1nI0rcPufzj5ubtFfIhtJkR1SxaIU0CnOfamh
# nOwMt3NZEgk+zFoYU8O83FLFRT+6QJJviCXjFUEFcuMlDctubeeyfTDg0wwrlv0x
# 0b/+Yy6l59/KA+kJXltBrNi3T2s3TA/vpC8Q2aiuQMJ0rXiAQcF34BYfKhnQMOYr
# lECj0pjyYRYS
# SIG # End signature block
