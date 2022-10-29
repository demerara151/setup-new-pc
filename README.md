# Setup workflow for Windows 11

**`Windows` を快適に使うための `PC` セットアップ手順**

### こんな人におすすめ

-   余計なプログラムやファイルは出来るだけ排除したい
-   `Microsoft` 製品は一部を除いて基本的に使わない
-   プライバシーとセキュリティを強化したい
-   `PC` のスペックが低い、または回線速度に問題がある

---

## Requirements

-   Windows 11 Home | Pro | EnterPrise | Insider
-   Powershell 7.2.7
-   [Sophia Script for Windows 11](https://github.com/farag2/Sophia-Script-for-Windows)

---

## Getting started

1. `Microsoft アカウント`の作成を回避

    PC の初期設定時（既に OS をインストール済み、もしくはアカウント作成済みの場合は次へスキップ）

    - インターネット設定画面で、<kbd>Alt</kbd> + <kbd>F4</kbd> を押して設定プロセス自体を終了させてしまう

    - 上記の方法でインターネット接続を回避できなかった場合、`Microsoft アカウント` 設定画面で、<kbd>Shift</kbd> + <kbd>F10</kbd> を押してコマンドプロンプトを立ち上げ、以下のコマンドを入力しインターネット接続を一時的に切断する（Wi-Fi の場合）

        ```CMD
        X:\Sources> netsh wlan disconnect
        X:\Sources> exit
        ```

    - コマンドプロンプトが閉じたら左上の戻る矢印をクリック

    > 有線の場合はケーブルを抜くか、ルーターの電源を一回落とす。また、<kbd>Windows</kbd> + <kbd>R</kbd> で「ファイル名を指定して実行」を起動し、`taskmgr` と入力してタスクマネージャーを起動。ネットワークに関連するプロセスを探してタスクを終了させてもいい。

2. Windows update

    起動したら `Windows Update` を実行して再起動。更新内容がなくなるまで `Windows Update` と再起動を繰り返す

    > バージョンが古いと `Sophia script` が実行できないため

3. スクリプトの編集

    - [`Sophia Script for Windows 11`](/Sophia/Sophia.ps1)

        メモ帳で開き、中身を自分好みに編集。もしくは、別の PC で事前に編集しておく

    - [`installAll.ps1`](/installAll.ps1)

        メモ帳で開き、不要なアプリが含まれていないか確認する。不要なアプリ名を削除、もしくは、各行のコマンドの先頭に # を付けることでコマンドの実行を防ぐ

4. パッケージマネージャーと必要なスクリプトの準備

    `Windowsキー` を押して、検索窓に`wt` と入力して <kbd>Enter</kbd> でターミナルを起動

    以下のコマンドをコピーして張り付け

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

    irm get.scoop.sh | iex

    scoop install 7zip mingit sudo pwsh
    scoop update

    git clone https://github.com/demerara151/setup-new-pc.git
    ```

    一度ターミナルを終了し、再度起動して <kbd>Ctrl</kbd> + <kbd>,</kbd> で設定画面を開く。「既定のプロファイル」を `Windows Powershell` から `Powershell`に変更、設定を保存して終了

---

## Run the script

### `Sophia Script for Windows 11` の実行

> OS のインストール直後に実行するのがベストのため、既に PC を普段使いしているなら以下のスクリプトは使用せず、[`Sophiapp`](https://github.com/Sophia-Community/SophiApp/) を利用してください

事前にスクリプトを編集した上で、以下のコマンドをコピーしてターミナルに張り付け

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
sudo ~/setup-new-pc/Sophia/Sophia.ps1
```

プログラムが終了し、PC を再起動するようメッセージが表示されたら、PC を再起動

-   実行に失敗した場合、

    -   (1) `Windows Update` がまだ残っていないか確認。
    -   (2) 「既定のプロファイル」が `Powershell` に変更されているか確認。
    -   (3) `PC` または、ターミナルの再起動。
    -   (4) それでも実行できない場合は、`Issue` へ報告お願いします。

### メインスクリプトの実行

PC の再起動後、再度ターミナルを起動して次のスクリプトを実行

```powershell
~/setup-new-pc/installAll.ps1
```

必要なアプリがまとめてインストールされます

### プライバシーとセキュリティの強化

アプリのインストール完了後、自動的に以下の 2 つのアプリが立ち上がるので、以下のようにそれぞれ設定

-   `WPD`

    -   プライバシー : `Windows Update` と `Windows Defender ウィルス対策`、`Service`全般はそのままで、それ以外の項目を全てオフに
    -   ブロッカー : `Update` 以外を適用。`Firewall` の設定はそのまま
    -   アプリ : `App Installer` と `Windows Terminal` 以外の不要なアプリを選択して削除

-   `shutup10`

    -   `Actions` から `Recommended and somewhat recommended settings` を選択

## Personal Settings

以下は個人的な設定です。適用する場合は、必ずファイルの中身を**事前に確認**してください

> 既に、設定している個人的な設定も上書きされる可能性があります。各自バックアップを取り、自己責任でお願いします

### 各種設定ファイルの配置

ユーザーフォルダ直下に、`.config` の名前で配置します。既に存在している場合は、全て上書きされるので注意してください

```powershell
Move-Item -Path ~/setup-new-pc/.config -Destination ~/ -Force
```

### 設定ファイル用シンボリックリンクの作成 [`symLinkCreator.ps1`](symLinkCreator.ps1)

ターミナルの「既定のプロファイル」が `Powershell`に変更されている事を確認し、次のスクリプトを走らせる

```powershell
~/setup-new-pc/symLinkCreator.ps1
```

本来、`%APPDATA%` や `%LOCALAPPDATA%` 等に保存される設定ファイルへのシンボリックリンクが `/.config` 内に作成されます。以降、このスクリプトで設定した全ての設定ファイルはこの `/.config` 内からアクセスできるようになります

### 不要なサービスの停止 [`stopService.ps1`](/stopService.ps1)

個人的に全く使わない以下のようなサービスを停止します。メモリの使用量をわずかに減らせます

-   印刷
-   ファックス
-   IPv6
-   Windows Search
-   Microsoft Edge 自動アップデート
-   Xbox gaming

```powershell
~/setup-new-pc/stopService.ps1
```

#### コピペ用追加設定一括コマンド

```powershell
~/setup-new-pc/installAll.ps1
Move-Item -Path ~/setup-new-pc/.config -Destination ~/ -Force
~/setup-new-pc/symLinkCreator.ps1
~/setup-new-pc/stopService.ps1
```

### Hyper-V の有効化

`BIOS` でハイパーバイザーが有効になっている前提

```Powershell
sudo ~/setup-new-pc/hyper-v/hv.bat
```

> もし、`Windows Insider Program` への参加が条件で実行できない場合は、`scoop` で `offlineinsiderenroll` をインストールし、`Microsoft アカウント` を作成せずに `Windows Insider Program` へ参加する

## Note

-   `OneDrive` は、必ず `Sophia Script` で消しておくこと。ここで正確に消さないと中途半端に残ったりアップデートで復活する

    > 10/25 追記：`privacy.sexy` のスクリプトでも綺麗に消すことに成功

-   `Windows` の既定のアプリに設定したいプログラムは `scoop` ではなく、必ず `winget` でインストールする

-   `Microsoft Edge` をアンインストールすると、ログイン時にフリーズして PC が使用できなくなる不具合に遭遇。開発環境だけの問題かもしれないけど、怖いのでそのままにしておくことにする

---

## ブラウザ設定（LibreWolf）

正直そのままでも問題ないが、`Settings` -> `LibreWolf` -> `Fingerprinting` の `Enable letterboxing` にチェックを入れておくとよさげ

### 拡張機能の導入（`uBlockOrigin` は、デフォルトで導入済み）

-   DarkReader : 常にダークモード
-   Bitwarden : パスワード管理
-   libredirect : プライバシーを尊重するサイトへ自動リダイレクト

### `uBlockOrigin` の上級者設定

1. 設定画面の `I am an advance user` にチェック

2. デフォルトのフィルターを全て適用

3. `My rules` タブに、次の 2 行を追加

    ```
    * * 3p-frame block
    * * 3p-script block
    ```

#### 追加フィルタ

-   AdGuard Social Media
-   [oisd](https://oisd.nl/)
-   [1Hosts Pro](https://github.com/badmojr/1Hosts)
-   [Energized Ultimate Protection](https://filterlists.com/lists/energized-ultimate-protection)
-   [Energized Xtreme Extension](https://filterlists.com/lists/energized-xtreme-extension)

### about:config で変更したい箇所

| key                                                | default | new  | description                        |
| :------------------------------------------------- | :-----: | :--: | :--------------------------------- |
| network.http.max-persistent-connections-per-server |    6    |  8   | 1 つのサーバーに対する最大接続数   |
| browser.tabs.loadBookmarksInTabs                   |  false  | true | ブックマークを常に新しいタブで開く |

---

## [AutoHotkey](/.config/AutoHotkey/KeySwapV2.ahk)

-   10/21 更新: _AutoHotkey のバージョンを `Version 1.1.34.04` から `Version 2.0-beta.12` へアップグレード。_ 既存のバージョンとの互換性はないため、以前のスクリプトを削除。スクリプトファイル、及び実行ファイルのパスも変わっているため注意。

> 参照: [AutoHotkey V2](https://lexikos.github.io/v2/docs/AutoHotkey.htm) `https://lexikos.github.io/v2/docs/AutoHotkey.htm`

英語配列キーボード向けのキーの挙動変更。入れ替えるキーは以下の 2 つ

|  1  | <kbd>;</kbd>  セミコロン | <kbd>:</kbd>  コロン |
| :-: | :----------------------- | :------------------- |
|  2  | <kbd>CapsLock</kbd>      | <kbd>ESC</kbd>       |

> 上記の手順でシンボリックリンクを作成していたなら、PC の再起動後に既定のプログラムを設定するようポップアップが出るので、`~/scoop/apps/autohotkey2/current/AutoHotkey64.exe` を選択

> または、Windows の設定 > アプリ > 既定のアプリで、ファイルの種類の既定値を設定する。上部の窓に、`.ahk`と入力して上記のプログラムをエクスプローラーから探して選択

## 日本語フォント

必要に応じて手動でインストール

-   [RocknRoll One](https://github.com/fontworks-fonts/RocknRoll): 現在 `foobar2000` のプレイリストにフォント適用中
