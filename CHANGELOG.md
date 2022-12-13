# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

-   [`privacy.sexy`](https://privacy.sexy) の導入を検討中

## 2022-12-13

### Added

-   Add gpg key to sign each commits.
-   Add `ja-JP` translation file for `Sophia Script` to be able to use them with Japanese out of the box but still experimental.

## 2022-11-06

### Changed

-   Changed installation of discord, gsudo, and librewolf.
-   Removed Steam and MSVC Toolchain from auto installation script. They have to install manually from today.

## 2022-11-05

### Changed

-   Stop using winget because of broken source issue. See [Issue#2666](https://github.com/microsoft/winget-cli/issues/2666)

## 2022-11-04

### Added

-   Add [[start-python.md](/docs/start-python.md)]: Getting started guide for python development.

### Changed

-   Update [README.md](/README.md): Organize contents and structure to more readable document.

## 2022-11-03

### Changed

-   Remove FiraCode and add JetBrainsMono and Hack font in [installAll.ps1](/installAll.ps1).

## 2022-10-30

### Changed

-   update Sophia script v6.2.0

### Added

-   [display-driver.md](/docs/display-driver.md): Guide to uninstall and install Display Driver cleanly.

## 2022-10-29

### Changed

-   `README` を `GitHub` 上で見やすくなるよう書き換え
-   更新履歴をここ `CHANGELOG.md` に移動

### Added

-   `CHANGELOG.md`

## 2022-10-25

### Changed

-   `extras bucket` に `wpd` が追加されたため、`scoop` でのインストールに変更

-   より汎用的にするため、アプリのインストールとサービスの停止、設定ファイルの配置の 3 つのプロセスを個々のプロセスに分割。アプリのインストールだけがしたい場合、[installAll.ps1](/installAll.ps1)のみを実行すれば済むように

-   不要なサービスの停止と設定ファイルの配置を、追加設定の項目に移動

## 2022-10-21

### Changed

-   `AutoHotkey` のバージョンを更新。[AutoHokey](/README.md/#autohotkey)
-   update `Sophia Script for Windows 11 v6.1.5`
-   実行環境の `Powershell` のバージョンをデフォルトの `5.1(Windows Powershell)` から `7.2(Powershell)` に変更
-   `scoop` の導入時に `pwsh` (7.2) もインストールするように

## 2022-10-17

### Fixed

-   `legendary` が、バケットを移動していたのは間違いだったようで、元の `games bucket` に戻っていたため修正

### Changed

-   `Heroic launcher` が、`scoop` でもインストールできるようになったので、`winget` から移動

## 2022-08-20

-   `legendary` が、`extras bucket` に移動したため、`games bucket` が不要に
-   `vscode` の同期機能を利用し始めたため、`vscodium` の設定ファイルの配置プロセスを削除

## 2022-07-04

-   `DNS` 管理アプリ [Adguard Home](https://github.com/AdguardTeam/AdGuardHome) を導入し、`windowsspyblocker` のフィルターを適用（`spy` と `extra` の 2 種）
