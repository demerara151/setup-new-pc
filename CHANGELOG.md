# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2023-09-20

### Changed

- Update Sophia Script to v6.5.6.
- Remove `brotli`, `gitui`, and `goodbye-dpi` from `installAll.ps1`.

## 2023-08-02

### Changed

- Revert back mpv-git to mpv to install because new version of mpv fix some critical bugs with `yt-dlp`.
- Change `windowsdesktop-runtime-lts` to `windowsdesktop-runtime` because `lightbulb` now supports `.NET 7 runtime`.

### Fixed

- Install `icaros-np` with global option can be failed to install and uninstall. So remove `--global` option from that.

## 2023-07-08

### Changed

- Remove unnecessary condition statement in `stopService.ps1`.
- Change the link of Windows service information to `../wiki/Services` instead of `/docs/windows-service.md`.
- Remove `aria2`, `so` and `tldr` from `installAll.ps1`.
- Switch `mpv` to `mpv-git` in `installAll.ps1`.
- Re-edit the section about `winget` in `installAll.ps1`.

## 2023-07-06

### Added

- Write about `privacy.sexy` in README.
- Add wiki for additional documents.

## 2023-07-03

### Changed

- Update Sophia Script to v6.5.2.
- Update Japanese translation of Sophia Script.
- Now using raw CLI script instead of GUI wrapper.
- Changes several tweaks in the script. Especially security and privacy (logging and auditing).

### Added

- Add new app to install; element, marksman, ruff and osv-scanner.

## 2023-04-02

### Fixed

- fix duplicate link in README.

### Changed

- remove `AutoHotKey` section from README and add it to the config repo.

## 2023-03-21

### Changed

- change `rustup-msvc` to `rustup` because default toolchain become `msvc`.
- remove `CascadiaCode` font. replace it with `Delugia`.

## 2023-03-09

### Added

- add `delta` to install
- add `privacy.sexy` to install

### Changed

- change `sqlitebrowser` to `sqlitestudio`

### Fixed

- `gpg4win` require admin privilege to install

## 2023-02-14

### Fixed

- fix path for running scripts in README

## 2022-12-22

### Changed

- Change app name `autohotkey2` to `autohotkey`. [(#10075)](https://github.com/ScoopInstaller/Extras/pull/10075)

## 2022-12-20

### Added

- Add another windows service that can be stopped in [stopService.ps1](/scripts/stopService.ps1).
- Add detail of windows service in `windows-service.md`.

## 2022-12-19

### Changed

- Remove `symLinkCreator.ps1`.
- Update Sophia script to v6.2.5

### Added

- Add new instruction about config installation with chezmoi in [README.md](/README.md).

## 2022-12-17

### Changed

- change password manager to `KeePassXC` instead of `Bitwarden`.

## 2022-12-16

### Changed

- remove `wpd`
- remove `privacy.sexy` because that is still experimental. Even `standard` modification will break some functionality. Be careful to use it.

## 2022-12-15

### Added

- add new apps in [installAll.ps1](/installAll.ps1).
  new apps: `ddu`, `nvcleanstall`, `keepassxc`, `gpg4win`, `chezmoi`, `privacy.sexy`, `synctrayzor`, `hyper`, `brotli`, `deno`, `helix`, `goodbyedpi`, `inkscape`, `openshot`, `waifu2x-ncnn-vulkan` and `Delugia-Nerd-Font-Complete`.

- add more app categories in [installAll.ps1](/installAll.ps1).

### Changed

- change environment for running scripts to `PowerShell Core` instead of `Windows Terminal`.
- remove some unused apps like `monolith`.

## 2022-12-13

### Added

- Add gpg key to sign each commits.
- Add `ja-JP` translation file for `Sophia Script` to be able to use them with Japanese out of the box but still experimental.

## 2022-11-06

### Changed

- Changed installation of discord, gsudo, and librewolf.
- Removed Steam and MSVC Toolchain from auto installation script. They have to install manually from today.

## 2022-11-05

### Changed

- Stop using winget because of broken source issue. See [Issue#2666](https://github.com/microsoft/winget-cli/issues/2666)

## 2022-11-04

### Added

- Add `start-python.md` in docs: Getting started guide for python development.

### Changed

- Update [README.md](/README.md): Organize contents and structure to more readable document.

## 2022-11-03

### Changed

- Remove FiraCode and add JetBrainsMono and Hack font in [installAll.ps1](/installAll.ps1).

## 2022-10-30

### Changed

- update Sophia script v6.2.0

### Added

- Add `display-driver.md` in docs: Guide to uninstall and install Display Driver cleanly.

## 2022-10-29

### Changed

- `README` を `GitHub` 上で見やすくなるよう書き換え
- 更新履歴をここ `CHANGELOG.md` に移動

### Added

- `CHANGELOG.md`

## 2022-10-25

### Changed

- `extras bucket` に `wpd` が追加されたため、`scoop` でのインストールに変更

- より汎用的にするため、アプリのインストールとサービスの停止、設定ファイルの配置の 3 つのプロセスを個々のプロセスに分割。アプリのインストールだけがしたい場合、[installAll.ps1](/installAll.ps1)のみを実行すれば済むように

- 不要なサービスの停止と設定ファイルの配置を、追加設定の項目に移動

## 2022-10-21

### Changed

- `AutoHotkey` のバージョンを更新。
- update `Sophia Script for Windows 11 v6.1.5`
- 実行環境の `Powershell` のバージョンをデフォルトの `5.1(Windows Powershell)` から `7.2(Powershell)` に変更
- `scoop` の導入時に `pwsh` (7.2) もインストールするように

## 2022-10-17

### Fixed

- `legendary` が、バケットを移動していたのは間違いだったようで、元の `games bucket` に戻っていたため修正

### Changed

- `Heroic launcher` が、`scoop` でもインストールできるようになったので、`winget` から移動

## 2022-08-20

- `legendary` が、`extras bucket` に移動したため、`games bucket` が不要に
- `vscode` の同期機能を利用し始めたため、`vscodium` の設定ファイルの配置プロセスを削除

## 2022-07-04

- `DNS` 管理アプリ [Adguard Home](https://github.com/AdguardTeam/AdGuardHome) を導入し、`windowsspyblocker` のフィルターを適用（`spy` と `extra` の 2 種）
