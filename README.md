# Setup workflow for Windows 11

**This branch is for test purpose. Too small installer to start using PC.**

# TODO

## Supported environment

* Windows 11 Home
* Powershell 5.1

## Required script

* [Sophia Script for Windows 11 v6.0.12](https://github.com/farag2/Sophia-Script-for-Windows)

***

## How to use

* `Microsoft アカウント` の作成を回避
  
  * インターネット設定画面で、<kbd>Alt</kbd> + <kbd>F4</kbd>
  
  * 又は、`Microsoft アカウント`設定画面で、<kbd>Shift</kbd> + <kbd>F10</kbd>
    
    ```CMD
    X:\Sources> netsh wlan disconnect
    X:\Sources> exit
    ```
  
  * プロンプトが閉じたら左上の戻る矢印をクリック

* 起動したら `Windows Update` を実行して再起動。更新内容がなくなるまで `Windows Update` を繰り返す

* 復元ポイントを構成
  
  ```powershell
  SystemPropertiesProtection.exe
  ```

* `scoop` のインストール、このリポジトリのクローン、`Sophia Script` の実行、不要なサービスの停止、必要なアプリのインストール、`WPD` の起動
  
  ```powershell
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser
  
  iwr -useb get.scoop.sh | iex
  
  scoop install 7zip mingit
  scoop update
  
  Set-Location $HOME\Documents
  git clone https://github.com/demerara151/setup-new-pc.git
  
  Set-Location setup-new-pc
  git switch Minimal-Test
  
  Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
  .\Sophia\Sophia.ps1
  
  .\InstallAll.ps1
  ```

* テレメトリーの駆逐
  
  * `WPD`
    
    * プライバシー： `Windows Update` と `Windows Defender` 以外の項目を全てオフに
    * ブロッカー： 3項目全てを適用。`Firewall` はそのまま
    * アプリ： 不要なものを選択して削除
  
  * `O&O ShutUp10`
    
    * `Actions` から `Recommended and somewhat recommended settings` を選択
  
  * `windowsspyblocker`
    
    * 全て `1` を選択

# Notes

* `OneDrive` は、必ず `Sophia Script` で消しておくこと。ここで正確に消さないと中途半端に残ったりアップデートで復活する

* `Windows` の既定のアプリに設定したいプログラムは `scoop` ではなく、必ず `winget` でインストールする
