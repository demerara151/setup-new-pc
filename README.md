# Setup workflow for Windows 11

**`Windows` を快適に使うための `PC` セットアップ手順**

## こんな人におすすめ

-   余計なプログラムやファイルは出来るだけ排除したい
-   `Microsoft` 製品は一部を除いて基本的に使わない
-   プライバシーとセキュリティを強化したい
-   `PC` のスペックが低い、または回線速度に問題がある

## 推奨環境

-   Windows 11 Home
-   Powershell 5.x （デフォルト）
-   [Sophia Script for Windows 11 v6.0.14](https://github.com/farag2/Sophia-Script-for-Windows)

## 事前準備

リポジトリをクローンしたら、スクリプトを走らせる前に編集すべき点

#### [Sophia Script](/Sophia/Sophia.ps1)

-   デフォルトのまま使ってもいいし、直接中身を編集してもいいけど、上記のリンクから最新バージョンを各自ダウンロードして編集したほうが間違いがなくてよい

-   編集したものを既存の `Sophia` フォルダーの中身と入れ替える

#### [installAll.ps1](/installAll.ps1)

-   自分用に必要なソフトをまとめています。各自の判断で事前に追加・除外してください

## 更新履歴

### 05/07

-   `nu` の更新&変更が頻繁で追いつけないため一旦除外

-   `ungoogled-chrome` から `brave` へ乗り換え。カスタマイズする手間が掛かりすぎて面倒になった。なお、メインは変わらず `LibreWolf` なのでほとんど出番はない（主にストレコ用）

### 07/04

-   使用頻度が少ない `github` と `picard` を `installAll.ps1` から除外

-   `DNS` 管理ソフト の [Adguard Home](https://github.com/AdguardTeam/AdGuardHome) を導入し、`windowsspyblocker` のフィルターを適用（`spy` と `extra` の 2 種）

-   これにより `windowsspyblocker` も不要になったため、`installAll.ps1` から除外

### 08/20

-   `legendary` が、`extras bucket` に移動したため、`games bucket` が不要に。

-   `vscodium` の設定ファイルの設置プロセスを削除。(`vscode` の同期機能を利用し始めたため)

---

# 手順

## OS のインストール

`Microsoft アカウント` の作成を回避

-   インターネット設定画面で、<kbd>Alt</kbd> + <kbd>F4</kbd>

-   または、`Microsoft アカウント` 設定画面で、<kbd>Shift</kbd> + <kbd>F10</kbd>

    ```CMD
    X:\Sources> netsh wlan disconnect
    X:\Sources> exit
    ```

-   プロンプトが閉じたら左上の戻る矢印をクリック

> 有線の場合はケーブルを抜くか、ルーターの電源を一回落とす。また、<kbd>Windows</kbd> + <kbd>R</kbd> で「ファイル名を指定して実行」を起動し、`taskmgr` と入力してタスクマネージャーを起動。ネットワークに関連するプロセスを探してタスクを終了させてもいい。

## Windows update

起動したら `Windows Update` を実行して再起動。更新内容がなくなるまで `Windows Update` と再起動を繰り返す

## パッケージマネージャーとスクリプトの準備

`Windowsキー` を押して、検索窓に`wt` と入力して<kbd>Enter</kbd> でターミナルを起動

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

Invoke-RestMethod get.scoop.sh | Invoke-Expression

scoop install 7zip mingit sudo
scoop update

git clone https://github.com/demerara151/setup-new-pc.git
```

## Sophia Script の実行

事前にスクリプトを<u>編集・準備</u>した上で

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
sudo ~/setup-new-pc/Sophia/Sophia.ps1
```

## メインスクリプトの実行

PC の再起動後、再度ターミナルを起動して次のスクリプトを実行

```powershell
~/setup-new-pc/installAll.ps1
```

アプリのインストールが不要な場合は、サービスの停止と `WPD` のインストールのみ実行

```powershell
# Disable services
~/setup-new-pc/stopService.ps1

# Install WPD
New-Item -ItemType Directory -Path ~/setup-new-pc/WPD
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile ~/setup-new-pc/WPD/wpd.zip

# Extract archive
7z x wpd.zip
Remove-Item -Path ~/setup-new-pc/WPD/wpd.zip

# Run WPD
Start-Process -FilePath ~/setup-new-pc/WPD/wpd.exe
```

## テレメトリーの無効化

-   `WPD`

    -   プライバシー : `Windows Update` と `Windows Defender ウィルス対策`、`Service`全般 以外の項目を全てオフに
    -   ブロッカー : `Update` 以外を適用。`Firewall` はそのまま
    -   アプリ : `App Installer` と `Windows Terminal` 以外の不要なアプリを選択して削除

-   `O&O ShutUp10`

    -   `Actions` から `Recommended and somewhat recommended settings` を選択

# 追加設定

以下は個人的な設定です。適用する場合は、必ずファイルの中身を**事前に確認**してください

## ドットファイル用シンボリックリンクの作成

ターミナルの「既定のプロファイル」を `Windows Powershell` から `Powershell`に変更し、ターミナルを再起動したら次のスクリプトを走らせる

```powershell
~/setup-new-pc/symLinkCreator.ps1
```

## Hyper-V の有効化

`BIOS` でハイパーバイザーが有効になっている前提

```Powershell
sudo ~/setup-new-pc/hyper-v/hv.bat
```

> もし、`Windows Insider Program` への参加が条件で実行できない場合は、`scoop` で `offlineinsiderenroll` をインストールし、`Microsoft アカウント` を作成せずに `Windows Insider Program` へ参加する

# Note

-   `OneDrive` は、必ず `Sophia Script` で消しておくこと。ここで正確に消さないと中途半端に残ったりアップデートで復活する

-   `Windows` の既定のアプリに設定したいプログラムは `scoop` ではなく、必ず `winget` でインストールする

-   `Microsoft Edge` をアンインストールすると、ログイン時にフリーズして PC が使用できなくなる不具合に遭遇。開発環境だけの問題かもしれないけど、怖いのでそのままにしておくことにする

---

# ブラウザ設定（LibreWolf）

正直そのままでも問題ないが、`Settings` -> `LibreWolf` -> `Fingerprinting` の `Enable letterboxing` にチェックを入れておくとよさげ

## 拡張機能の導入（uBlockOrigin は、デフォルトで導入済み）

-   DarkReader : 常にダークモード

-   Bitwarden : パスワード管理

-   libredirect : プライバシーを尊重するサイトへ自動リダイレクト

## uBlockOrigin の上級者設定

1. 設定画面の `I am an advance user` にチェック

2. デフォルトのフィルターを全て適用

3. `My rules` タブに、次の 2 行を追加

    ```
    * * 3p-frame block
    * * 3p-script block
    ```

### 追加フィルタ

-   AdGuard Social Media
-   [oisd](https://oisd.nl/)
-   [1Hosts Pro](https://github.com/badmojr/1Hosts)
-   [Energized Ultimate Protection](https://filterlists.com/lists/energized-ultimate-protection)
-   [Energized Xtreme Extension](https://filterlists.com/lists/energized-xtreme-extension)

## about:config で変更したい箇所

| key                                                | default | new  | description                        |
| :------------------------------------------------- | :-----: | :--: | :--------------------------------- |
| network.http.max-persistent-connections-per-server |    6    |  8   | 1 つのサーバーに対する最大接続数   |
| browser.tabs.loadBookmarksInTabs                   |  false  | true | ブックマークを常に新しいタブで開く |

---

# [Autohotkey](/.config/autohotkey/keyswap.ahk)

英語配列キーボード向けのキーの挙動変更。入れ替えるキーは以下の 2 つ

| Before                   | After                |
| :----------------------- | :------------------- |
| <kbd>;</kbd>  セミコロン | <kbd>:</kbd>  コロン |
| <kbd>CapsLock</kbd>      | <kbd>ESC</kbd>       |

> 上記の手順でシンボリックリンクを作成していたなら、PC の再起動後に既定のプログラムを設定するようポップアップが出るので、`~/scoop/apps/autohotkey/current/autohotkeyU64.exe` を選択

# 日本語フォント

必要に応じて手動でインストール

-   [RocknRoll One](https://github.com/fontworks-fonts/RocknRoll) `foobar2000` のプレイリストにフォント適用中
