# Setup Workflow for Windows 11

**Windows を快適に使うための PC セットアップ手順**

### こんな人におすすめ

- 余計なプログラムやファイルは出来るだけ排除したい
- Microsoft 製品は一部を除いて基本的に使わない
- プライバシーとセキュリティを強化したい
- PC のスペックが低い、または回線速度に問題がある

### Screenshot

![taskmgr](https://user-images.githubusercontent.com/54271767/219234992-6b27ac3e-009f-4414-a7d1-57456196df07.png)

---

## Table of Contents

<!--toc:start-->

- [Requirements](#requirements)
- [Dependencies](#dependencies)
- [Before Get Started](#before-get-started)
  - [Microsoft アカウントの作成を回避](#microsoft-アカウントの作成を回避)
- [Installation](#installation)
  - [スクリプトの編集](#スクリプトの編集)
- [Usage](#usage)
  - [Sophia Script for Windows 11](#sophia-script-for-windows-11)
  - [メインスクリプトの実行](#メインスクリプトの実行)
  - [プライバシーとセキュリティの強化](#プライバシーとセキュリティの強化)
- [Personal Settings](#personal-settings)
  - [各種設定ファイルの配置](#各種設定ファイルの配置)
  - [不要なサービスの停止](#不要なサービスの停止)
  - [Hyper-V の有効化](#hyper-v-の有効化)
- [Note](#note)
- [ブラウザ設定](#ブラウザ設定)
  - [Set LibreWolf as the default browser](#set-librewolf-as-the-default-browser)
  - [Update](#update)
  - [Addons](#addons)
  - [uBlockOrigin](#ublockorigin)
    - [Block third-party remote fonts](#block-third-party-remote-fonts)
    - [Additional filters](#additional-filters)
  - [Advanced preferences](#advanced-preferences)
- [日本語フォント](#日本語フォント)
- [TODO](#todo)
<!--toc:end-->

---

## Requirements

- Windows 11 Home | Pro | EnterPrise | Insider

## Dependencies

- [Scoop]
- [O&O ShutUp10]
- [Sophia Script for Windows]

---

## Before Get Started

以下の手順は、OS のインストールが終わり PC の初期設定が終わった直後に実行することを推奨しています。そのため、PC の初期設定時に Microsoft アカウントの作成を回避する方法を紹介しておきます。

### Microsoft アカウントの作成を回避

1. インターネット設定画面で、<kbd>Alt</kbd> + <kbd>F4</kbd> を押して設定プロセス自体を終了させてしまう

2. 上記の方法でインターネット接続を回避できなかった場合、Microsoft アカウント設定画面で、<kbd>Shift</kbd> + <kbd>F10</kbd> を押してコマンドプロンプトを立ち上げ、以下のコマンドを入力しインターネット接続を一時的に切断する（Wi-Fi の場合）

```CMD
X:\Sources> netsh wlan disconnect
X:\Sources> exit
```

> 有線の場合はケーブルを抜くか、ルーターの電源を一回落とす。また、<kbd>Windows</kbd> + <kbd>R</kbd> で「ファイル名を指定して実行」を起動し、`taskmgr` と入力してタスクマネージャーを起動。ネットワークに関連するプロセスを探してタスクを終了させてもいい。

コマンドプロンプトが閉じたら左上の戻る矢印をクリック

## Installation

<kbd>Windows</kbd> キーを押して、検索窓に「shell」と入力して <kbd>Enter</kbd> で `Windows PowerShell` を起動

以下のコマンドをコピーして張り付け

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

irm get.scoop.sh | iex

scoop install 7zip mingit gsudo pwsh
scoop update

git clone https://github.com/demerara151/setup-new-pc.git
```

一度 `Windows PowerShell` を終了し、<kbd>Windows</kbd> キーを押して `PowerShell Core` を探して起動

### スクリプトの編集

- [Sophia.ps1](/Sophia/Sophia.ps1)

  <!-- TODO: Write how to edit guide. -->

  メモ帳で開き、中身を自分好みに編集。もしくは、別の PC で事前に編集しておく

- [installAll.ps1](/scripts/installAll.ps1)

  <!-- TODO: Write examples. -->

  メモ帳で開き、不要なアプリが含まれていないか確認する。不要なアプリ名を削除、もしくは、各行のコマンドの先頭に `#` を付けることでコマンドの実行を防ぐ

---

## Usage

### Sophia Script for Windows 11

> ⚠️OS のインストール直後に実行するのがベストのため、既に PC を普段使いしているなら以下のスクリプトは使用せず、[Sophiapp] を利用してください

事前にスクリプトを編集した上で、以下のコマンドをコピーしてターミナルに張り付け

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
sudo ~/setup-new-pc/Sophia/Sophia.ps1
```

プログラムが終了し、PC を再起動するようメッセージが表示されたら、PC を再起動

- 実行に失敗した場合、

  1. `Windows Update` の実行
  2. `PoserShell`、または PC の再起動
  3. `PowerShell` のバージョンがスクリプトの要件を満たしているか確認

### メインスクリプトの実行

PC の再起動後、再度 `PowerShell Core` を起動して次のスクリプトを実行

```powershell
~/setup-new-pc/scripts/installAll.ps1
```

必要なアプリがまとめてインストールされます

### プライバシーとセキュリティの強化

アプリのインストール完了後、自動的に以下のアプリが立ち上がるので、以下のように設定

- [O&O ShutUp10]

  `Actions` から `Recommended and somewhat recommended settings` を選択

#### Experimental

以下のアプリはまだ実験段階です。必ず復元ポイントを作成してから実行してください

また、なんらかのトラブルが発生した際にイベントビューア等を駆使して、問題を切り分けられる自信のある方のみ実行してください。特に PC に疎い方による実行はおすすめしません

- privacy.sexy

  `privacy.sexy.exe` を起動、または[サイト](https://privacy.sexy)にアクセスして、左上の `Select:
None | Standard | Strict | All` というリストから `Standard` を選択。実行ボタン（画面下にある右三角のアイコン）をクリック

## Personal Settings

以下は個人的な設定です。適用する場合は、必ずファイルの中身を**事前に確認**してください

### 各種設定ファイルの配置

現在設定ファイルは [chezmoi] で管理しています。設定ファイルをダウンロードして適用するには、`chezmoi init <repo>` します

```powershell
chezmoi init https://codeberg.org/Gambling1594/dotfiles.git
```

中には暗号化されているファイルもあり復号できずにエラーとなるため、適用する前に削除します

```powershell
Get-ChildItem ~/.local/share/chezmoi -Include encrypted_* -Recurse | Remove-Item
```

次に、設定ファイルをプログラムによって決められたデフォルトの場所に配置します

> ⚠️ 全ての既存の設定ファイルの内容が上書きされます。既存の設定ファイルがあるならバックアップをとっておくか、適用したくない設定ファイルは事前に `~/.local/share/chezmoi` の中から削除しておいてください

```powershell
chezmoi apply
```

### 不要なサービスの停止

個人的に全く使わない以下のサービスをまとめて停止します

- 印刷
- ファックス
- IPv6
- ダイレクトアクセス
- 位置情報
- IoT 家電
- デジカメ、スキャナー
- リモートレジストリ
- Windows 検索
- Microsoft Edge 自動アップデート
- ネットワークデータ使用状況
- Xbox gaming

```powershell
sudo ~/setup-new-pc/scripts/stopService.ps1
```

> 詳細は、[stopService.ps1](/scripts/stopService.ps1) 及び、[wiki](https://github.com/demerara151/setup-new-pc/wiki/Services) で確認できます

### Hyper-V の有効化

BIOS で「ハードウェアの仮想化サポート」が有効になっている前提で、

```Powershell
sudo ~/setup-new-pc/scripts/hyper-v/hv.bat
```

> もし、_Windows Insider Program_ への参加が条件で `Hyper-V` が実行できない場合は、[OfflineInsiderEnroll] をインストール（`scoop install offlineinsiderenroll`）することで、Microsoft アカウントの作成を回避して _Windows Insider Program_ へ参加可能

## Note

- `Microsoft Edge` そのものは、アンインストールできます。しかし、`Microsoft Edge WebView2 Runtime` は、Windows を使う上で必須のコンポーネントなのでアンインストールできません。万が一アンインストールしてしまうと、Windows が起動しない等の不具合が発生する恐れがあります

---

## ブラウザ設定

LibreWolf の各種設定内容について

### Set LibreWolf as the default browser

まず、ポータブル版を今まで通りインストールします

```powershell
scoop install librewolf
librewolf.exe
```

そのポータブル版で <https://librewolf.net/installation/windows> を開いて、最新版のインストーラーをダウンロードします

インストールが終わったら Windows の設定を開き、アプリ > 既定のアプリ で LibreWolf を選択し、一番上にある「既定値に設定」をクリックして LibreWolf を既定のアプリに設定します

LibreWolf を既定のアプリに設定できたなら、`scoop` でインストールした方はアンインストールして構いません

```powershell
scoop uninstall librewolf
```

### Update

LibreWolf 自身には自動アップデート機能は付いていません。アップデートする際は、毎回上記のページを開いて最新版をダウンロードし、インストーラーを実行する必要があります

幸い、非公式ですが、アップデートがあったら知らせてくれる拡張機能 [LibreWolf Updater extension] があります。毎日ページを開いて確認するのが面倒な人は、こちらの拡張機能の利用を検討してください

> 6/1 にリリースされた `LibreWolf 113.0.2-1` からは、初回インストール時、または更新時に、`LibreWolf Updater extension` をブラウザ本体と同時にインストールできるようになりました。加えて、スケジュールタスクに登録することもできるようになり、ブラウザのアップデートが大分楽になりました。

[librewolf updater extension]: https://addons.mozilla.org/en-US/firefox/addon/librewolf-updater/

### Addons

私が現在利用している拡張機能の一覧です。LibreWolf では、拡張機能は出来る限り最小限に抑えることが推奨されています

> Recommended Addons - LibreWolf <https://librewolf.net/docs/addons/>

> 💡`uBlockOrigin` は、最初からインストールされています

- [DarkReader] 常にダークモード
- [LibRedirect] プライバシーを尊重するサイトへ自動リダイレクト
- [KeePassXC-Browser] パスワード管理

  導入手順: <https://keepassxc.org/docs/KeePassXC_GettingStarted.html#_setup_browser_integration>

> `HTTPS Everywhere`、`Privacy Badger`、`CookieAutoDelete` 等に代表されるプライバシー・セキュリティ関連の拡張機能は、いずれも不要です。LibreWolf または、`uBlockOrigin` が既に同等あるいはそれ以上の機能を有しています。

### uBlockOrigin

ダイナミックフィルタリングを利用するため、上級者機能を有効化します

1. 設定画面の `I am an advanced user` にチェック
2. デフォルトのフィルターを全て適用
3. `My rules` タブに、次の 2 行を追加

   ```
   * * 3p-frame block
   * * 3p-script block
   ```

> この機能は初心者向けではありません。利用する際は、[ドキュメント](https://github.com/gorhill/uBlock/wiki/Advanced-user-features)を注意深く読み込んでからにしてください。

#### Block third-party remote fonts

`My Filters` のタブに、以下の行を追加することで、サードパーティーのリモートフォントをブロックできます

```
! Block all third-party remote fonts
*$font,third-party
```

> 行の先頭に `!` を付けるとコメントになります

#### Additional filters

私が現在 `uBlockOrigin` で適用している追加のフィルタリストです

- AdGuard Social Media
- [oisd]
- [1Hosts Pro]
- [antipopads:reborn]

> PC のスペックが低い場合、これらのフィルターを全て適用するとかなり重たくなります。様子を見ながら適度に適用してください。初めは `oisd` だけ適用するのがよさそうです

### Advanced preferences

個人的に `about:config` で変更したい設定項目

| key                                                | default | new  | description                        |
| :------------------------------------------------- | :-----: | :--: | :--------------------------------- |
| network.http.max-persistent-connections-per-server |    6    |  8   | 1 つのサーバーに対する最大接続数   |
| browser.tabs.loadBookmarksInTabs                   |  false  | true | ブックマークを常に新しいタブで開く |

> LibreWolf の場合、初めからプライバシーやセキュリティに関する各種の上級設定が変更されています。それ以外の上記のような変更は単なる好みです。

---

## 日本語フォント

プログラミング等とは関係のない一般的な日本語フォントです。インストールは手動になります

- [RocknRoll One](https://github.com/fontworks-fonts/RocknRoll)

> プログラミング用日本語フォントは、`IBM Plex Sans JP` を利用しています。`sudo scoop install IBMPlexSans-JP --global` でインストールできます

## TODO

- [x] [privacy.sexy](https://privacy.sexy) の利用方法の追加
- [ ] Project の wiki を作成して [Adguard Home](https://https://github.com/AdguardTeam/AdGuardHome) の利用方法を解説する

<!-- Link Reference -->

<!-- Dependencies -->

[scoop]: https://scoop.sh
[o&o shutup10]: https://www.oo-software.com/en/shutup10
[sophia script for windows]: https://github.com/farag2/Sophia-Script-for-Windows

<!-- Optional Dependencies -->

[chezmoi]: https://www.chezmoi.io
[sophiapp]: https://github.com/Sophia-Community/SophiApp/
[offlineinsiderenroll]: https://github.com/abbodi1406/offlineinsiderenroll

<!-- Browser Addons -->

[keepassxc-browser]: https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
[darkreader]: https://addons.mozilla.org/en-US/firefox/addon/darkreader/
[libredirect]: https://addons.mozilla.org/en-US/firefox/addon/libredirect/

<!-- AdBlock Filter -->

[oisd]: https://oisd.nl/
[1hosts pro]: https://github.com/badmojr/1Hosts
[antipopads:reborn]: https://github.com/AdroitAdorKhan/antipopads-re
