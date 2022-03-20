# Setup workflow for Windows 11

**`Windows 11` の設定手順覚書**

## Supported environment

* Windows 11 Home
* Powershell 5.1

## Required script

* [Sophia Script for Windows 11 v6.0.13](https://github.com/farag2/Sophia-Script-for-Windows)

***

## How to use

* `OS` インストール時に `Microsoft アカウント` の作成を回避

  * インターネット設定画面で、<kbd>Alt</kbd> + <kbd>F4</kbd>

  * 又は、`Microsoft アカウント` 設定画面で、<kbd>Shift</kbd> + <kbd>F10</kbd>

    ```CMD
    X:\Sources> netsh wlan disconnect
    X:\Sources> exit
    ```

  * プロンプトが閉じたら左上の戻る矢印をクリック

* 起動したら `Windows Update` を実行して再起動。更新内容がなくなるまで `Windows Update` と再起動を繰り返す

* **管理者権限**で `PowerShell` を開く。"ファイル名を指定して実行"で、`powershell` と入力し、<kbd>Ctrl</kbd> と <kbd>Shift</kbd> を押しながら <kbd>Enter</kbd> 又は、`OK` をクリック

* 復元ポイントを構成。復元ポイントを作成できるようにするだけでここでは作成しなくてよい

  ```powershell
  SystemPropertiesProtection.exe
  ```

* `scoop` のインストール、このリポジトリのクローン

  ```powershell
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser

  iwr -useb get.scoop.sh | iex

  scoop install 7zip mingit sudo
  scoop update

  git clone https://github.com/demerara151/setup-new-pc.git

  Set-Location setup-new-pc
  ```

* `Sophia Script` の実行

  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
  sudo .\Sophia\Sophia.ps1
  ```

* アプリの一括インストール、及び不要なサービスの停止、`WPD` のインストールと起動

  ```powershell
  .\installAll.ps1
  ```

* テレメトリーの駆逐

  * `WPD`

    * プライバシー： `Windows Update` と `Windows Defender ウィルス対策`、`Service`全般 以外の項目を全てオフに
    * ブロッカー： `Update` 以外を適用。`Firewall` はそのまま
    * アプリ： 不要なものを選択して削除

  * `O&O ShutUp10`

    * `Actions` から `Recommended and somewhat recommended settings` を選択

  * `windowsspyblocker`

    * 全て `1` を選択

* 再起動したら、ターミナルの設定画面で「既定のプロファイル」を `Windows Powershell` から `Powershell`に変更する

* ターミナルを再起動して、各種設定ファイルのシンボリックリンクを作成する

  ```powershell
  .\symLinkCreator.ps1
  ```

# Notes

* `OneDrive` は、必ず `Sophia Script` で消しておくこと。ここで正確に消さないと中途半端に残ったりアップデートで復活する

* `Windows` の既定のアプリに設定したいプログラムは `scoop` ではなく、必ず `winget` でインストールする

* `Microsoft Edge` をアンインストールすると、ログイン時にフリーズしてPCが使用できなくなる不具合に遭遇。開発環境だけの問題かもしれないけど、怖いのでそのままにしておくことにする

***

# ブラウザ設定（LibreWolf）

正直そのままでも問題ないが、`Enable letterboxing` にチェックを入れておくとよさげ

## 拡張機能の導入

* DarkReader（常にダークモード）
* Bitwarden（パスワード管理）
* Privacy Redirect（プライバシーを尊重するサイトへ自動リダイレクト）
  * nitter = https://nitter.fdn.fr
  * invidious = https://invidious.kavin.rocks
  * reddit = https://libreddit.kavin.rocks

## uBlockOriginの上級者設定

1. 設定画面の「私は上級者です」にチェック

2. デフォルトのフィルターを全て適用

3. `My rules` に、次の2行を追加

   ```
   * * 3p-frame block
   * * 3p-script block
   ```

### 追加フィルタ

* AdGuard Social Media
* [Energized Ultimate Protection](https://filterlists.com/lists/energized-ultimate-protection)
* [Energized Xtreme Extension](https://filterlists.com/lists/energized-xtreme-extension)

## about:configで変更したい箇所

| key                                                | value | note                                                                                                          |
| ------------------------------------------------- | :---: | ------------------------------------------------------------------------------------------------------------- |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか<br />（デフォルトは6。現在保留中）                                       |
| browser.tabs.loadBookmarksInTabs                   | true  | ブックマークを常に新しいタブで開く<br />（一時期デフォルトで true だったけど最新版では false になってたので） |

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

# "Hyper-V"の有効化

* 管理者権限でコマンドプロンプトを開き、バッチファイルを実行

  ```Powershell
  sudo
  cmd
  .\hyper-v\hv.bat
  ```

* もし、`Windows Insider Program` への参加が条件で、実行できない場合は、`scoop install offlineinsiderenroll` で `Microsoft アカウント` を作成せずに `Windows Insider Program` へ参加する
