# Setup for new PC
自分用PC設定集  
* 2021/11/25: Windows11向けに加筆＆修正。wingetがインストールされてる前提だけど、なくても大丈夫。

## Microsoftアカウントの作成を回避
* Windows 10 の場合： 初期設定時のネットワーク設定画面で、ネットワークの設定をスキップする
* Windows 11 Home の場合： ネットに繋ぐ設定画面で`Alt+F4`を押す。これでMicrosoftアカウントのセットアップをスキップできるらしい。
* Windows 11 Pro の場合： アカウント設定画面にサインインオプションとして「オフラインアカウントで使用」という選択肢があるのでネットに繋げたままでも問題ない

## Workflow
1. 初期設定が終わったら、ネットに繋いでwindows updateを実行

2. 再起動

3. グラフィックドライバーをアップデートまたは確認

4. 再起動

5. 予め作成しておいた、[sophia script](/sophia.ps1)をダウンロード、またはUSB等で持ってくる
* スクリプトを`Powershell 7.0~` 用に作成していた場合、デフォルトのPowershellのバージョンが5.1だったなら、wingetで7.2をインストール。
```Powershell
winget install Microsoft.Powershell
if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
}
```

1. 管理者権限でPowershellを開き、次のコマンドを入力
    ```Powershell
    # 現在のセッションのみ有効な実行ポリシーの変更
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    ```

2. debloat tool を走らせ、余計な機能やアプリを一括アンインストール
    ```Powershell
    .\Sophia.ps1
    ```
    ※詳しくは、[Sophia-Script-for-Windows](https://github.com/farag2/Sophia-Script-for-Windows)を参照

3. 再起動

4. [wpd](https://wpd.app/)をダウンロードし、上記のスクリプトで削除できないテレメトリーや不要なアプリを削除  
    実行前に必ず復元ポイントを作成する。（Windows11の場合、デフォルトで復元ポイントの作成が無効化されているので失敗する。「システムの保護」から手動で「復元ポイントの作成」を有効化する必要あり）

5.  再起動

6.  Scoop及び、wingetで複数のプログラムをまとめてインストール  
[Auto Installer](/autoinstaller.ps1)をダウンロード
し、Powershellで実行
```Powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\autoinstaller.ps1
```

12. 再起動

13. タスクスケジューラで、「EdgeUpdate」と「NvidiaTelemetry」関連を全て無効化する
* EdgeUpdateは何度でも復活するので注意。一通りセットアップが終わった後の方がいいかもしれない

14. サービス管理ツールで、とりあえず「Windows Search Index」と「Print spooler」を無効化

15. エクスプローラーでローカルディスクのプロパティを開き、全てのインデックスを解除する。

16. [Clibor](https://forest.watch.impress.co.jp/library/software/clibor/)を手動でインストール

# Firefoxの初期設定
* 2021/11/22: LibreWolfがWindowsでも使えて、wingetでインストールできるようになったので、暫くLibreWolfを試す予定。
* 11/25: LibreWolfが優秀すぎるので完全移行。検索エンジンは[You](https://you.com)を使用。拡張機能は下記のものをそのまま運用。

## ffprofileの適用
まず初めに、[Firefox Profilemaker](https://ffprofile.com/)でプロファイルを作成する
1. URLバーで、`about:support`と入力
2. 「プロファイルフォルダーを開く」をクリック
3. Firefoxを終了する
4. 開いたデフォルトプロファイルフォルダーの中身を全て削除する
5. そのフォルダーに先ほど作成した`profile.zip`の中身を展開する
6. 再度Firefoxを起動する
7. 拡張機能マネージャーを起動して拡張機能をアップデートする

## ffprofileで導入される拡張機能
* uBlockOrigin
* CanvasBlocker
* ClearURLs
* Cookie AutoDelete

## 手動で別途導入する拡張機能
* LocalCDN
* DarkReader
* Privacy Redirect
* Bitwarden
* uBlacklist

## about:configで変更する内容

### General settings

| key                                                | value | note                                 |
| -------------------------------------------------- | :---: | ------------------------------------ |
| keyword.enabled                                    | true  | アドレスバーで直接検索できる         |
| browser.tabs.loadBookmarksInTabs                   | true  | ブックマークを新しいタブで開く       |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか |

### Cache settings
LibreWolfの場合は、下から２つだけ自分で設定する必要あり

| key                                   | value | note                                                   |
| ------------------------------------- | ----- | ------------------------------------------------------ |
| browser.cache.disk.enable             | false | ディスクキャシュをしない                               |
| browser.cache.memory.enable           | true  | メモリでキャシュする                                   |
| browser.cache.memory.capacity         | -1    | メモリサイズに合わせてキャッシュ量を自動調整してくれる |
| browser.cache.disk.capacity           | 0     | デフォルトは256000                                     |
| browser.cache.disk.smart_size.enabled | false | キャッシュサイズを自動で計算してくれる機能             |
