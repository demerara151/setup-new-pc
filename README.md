# Setup for new PC
自分用PC設定集

# OSインストール直後

* 初期設定時にはネットに繋がない（Microsoftアカウントを要求されるため）

1. 初期設定が終わったら、ネットに繋いでwindows updateを実行

2. 再起動

3. グラフィックドライバーをアップデートまたは確認

4. 再起動

5. 予め作成しておいた、[sophia script](/sophia.ps1)をダウンロード、またはUSB等で持ってくる

6. 管理者権限でPowershellを開き、次のコマンドを入力
    ```Powershell
    # 現在のセッションのみ有効な実行ポリシーの変更
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    ```

7. debloat tool を走らせる
    ```Powershell
    .\Sophia.ps1
    ```
    ※詳しくは、[Sophia-Script-for-Windows](https://github.com/farag2/Sophia-Script-for-Windows)を参照

8. 再起動

9. [wpd](https://wpd.app/)をダウンロードし、テレメトリーや不要なアプリを削除  
    必ず復元ポイントを作成する

10. 再起動

11. Scoopで複数のプログラムをまとめてインストール  
[Auto Installer](/autoinstaller.ps1)をダウンロード
し、Powershellで実行
```Powershell
.\autoinstaller.ps1
```

12. 再起動

13. タスクスケジューラで、「MicrosoftEdgeUpdateTaskMachineCore」と「NvTmRep_CrashReport」関連を全て無効化する

14. いくつかのソフトを手動でインストール
* Steam と discord は scoop でもインストールできるが以前うまく機能しなかったため手動にしている。が、再度検証してみてもいい  

|  名前   | URL                                                         |
| :-----: | :---------------------------------------------------------- |
| Clibor  | https://forest.watch.impress.co.jp/library/software/clibor/ |
|  Steam  | https://store.steampowered.com/                             |
| discord | https://discord.com/                                        |
|   wpd   | https://wpd.app/                                            |
| es.exe  | https://www.voidtools.com/downloads/                        |

# Firefoxの初期設定
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

### general

| key                                                | value | note                                 |
| -------------------------------------------------- | :---: | ------------------------------------ |
| keyword.enabled                                    | true  | アドレスバーで直接検索できる         |
| browser.tabs.loadBookmarksInTabs                   | true  | ブックマークを新しいタブで開く       |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか |

### memory

| key                           | value | note                                                   |
| ----------------------------- | ----- | ------------------------------------------------------ |
| browser.cache.disk.enable     | false | ディスクキャシュをしない                               |
| browser.cache.memory.enable   | true  | メモリでキャシュする                                   |
| browser.cache.memory.capacity | -1    | メモリサイズに合わせてキャッシュ量を自動調整してくれる |

# Update Notes
These tools are under devlopment. Use them with your own risk.
* Create [sophia.ps1](/sophia.ps1) on 27/10/2021
* Create [manualInstaller.ps1](/manualInstaller.ps1) on 02/11/2021

# Fonts
* `CascadiaCode-NF`は、"CaskaydiaCove NF"という名前で使う
