# Setup workflow for Windows 11

**`Windows 11` の設定手順覚書**

## Supported environment

  * Windows 11 Home
  * Powershell 5.1

## Required script

  * [Sophia Script for Windows 11 v6.0.12](https://github.com/farag2/Sophia-Script-for-Windows)

***

## How to use

* `Microsoft アカウント` の作成を回避
  * インターネット設定画面で、<kbd>Alt</kbd> + <kbd>F4</kbd>
  * 又は、Microsoftアカウント設定画面で、<kbd>Shift</kbd> + <kbd>F10</kbd>

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

* `scoop` のインストール、このリポジトリのクローン、`Sophia Script` の実行、不要なサービスの停止、必要なアプリのインストール、`Microsoft Edge` の削除、`WPD` の起動

  ```powershell
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser

  iwr -useb get.scoop.sh | iex

  scoop install 7zip mingit
  scoop update

  Set-Location $HOME\Documents
  git clone https://github.com/demerara151/setup-new-pc.git

  Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
  .\$HOME\Documents\setup-new-pc\Sophia\Sophia.ps1

  .\$HOME\Documents\setup-new-pc\InstallAll.ps1

  ```

* テレメトリーの駆逐
  * `WPD`
    * プライバシー： Windows Update と Defender 以外の項目は全てブロックして構わない
    * ブロッカー： 左２つを適用
    * アプリ： 不要なものを全て選択して、選択したものを削除

  * `O & O ShutUp10`
    * `Actions` から `Recommended and somewhat recommended settings` を選択
  * `windowsspyblocker`
    * 全て１を選択

# Notes

* `OneDrive` は、必ず `Sophia Script` で消しておくこと。ここで正確に消さないと中途半端に残ったりアップデートで復活する

* `Windows` の既定のアプリに設定したいプログラムは `scoop` ではなく、必ず `winget` でインストールする

***

# ブラウザ設定（LibreWolf）

正直そのままでも問題ない


## 拡張機能の導入

* DarkReader
* LocalCDN
* Bitwarden
* ClearURLs
* Cookie AutoDelete
* Privacy Redirect
  * nitter = fdn.fr
  * invidious = kavin.rocks
  * reddit = kavin.rocks


## uBlockOriginの上級者設定

1. 設定画面の「私は上級者です」にチェック
2. デフォルトのフィルターを全て適用
3. `My rules` に、次の2行を追加

  ```
  * * 3p-frame block
  * * 3p-script block
  ```


## LocalCDNの設定

1. `Advanced` のタブ下部にある項目の `uBlock` をクリック
2. 表示された内容をコピーして、uBOの設定画面にある `My rules` の右側の欄に貼り付け
3. `Save` で確定し、`Commit` を押す


## about:configで変更したい箇所

| key                                                | value | note                                       |
| -------------------------------------------------- | :---: | ------------------------------------------ |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか       |
| browser.cache.disk.capacity                        |   0   | デフォルトは256000                         |
| browser.cache.disk.smart_size.enabled              | false | キャッシュサイズを自動で計算してくれる機能 |

***

# Autohotkeyの設定

* 英語配列キーボード向けのキーの挙動変更。入れ替えるキーは以下の2つ
  * セミコロン（`;`）とコロン（`:`）
  * `CapsLock` と `ESC`
* [colon.ahk](autohotkey/colon.ahk)を、スタートアッププログラムのあるフォルダ（shell:startup）に配置
* プロパティを開き、既定のプログラムを `$HOME\scoop\apps\autohotkey\current\autohotkeyU64.exe` に変更


# 日本語フォントの導入（手動）
* [Klee One](https://github.com/fontworks-fonts/Klee)
* [RocknRoll One](https://github.com/fontworks-fonts/RocknRoll)
* [IBM Plex Sans JP](https://github.com/IBM/plex/releases)
  * TrueTypeを選択


# "Hyper-V"の有効化
* コマンドプロンプトを管理者権限で開き、次のバッチファイルを実行
  ```Powershell
  .\$HOME\Documents\setup-new-pc\hyper-v\hv.bat

  ```
* もし、`Windows Insider Program` への参加が条件で、実行できない場合は、`scoop install offlineinsiderenroll` で `Microsoft アカウント` を作成せずにインサイダーへ参加する
