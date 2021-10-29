# ffprofileの適用
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

# about:configの変更点

## general

| key                                                | value | note                                 |
| -------------------------------------------------- | :---: | ------------------------------------ |
| keyword.enabled                                    | true  | アドレスバーで直接検索できる         |
| browser.tabs.loadBookmarksInTabs                   | true  | ブックマークを新しいタブで開く       |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか |

## memory

| key                           | value | note                                                   |
| ----------------------------- | ----- | ------------------------------------------------------ |
| browser.cache.disk.enable     | false | ディスクキャシュをしない                               |
| browser.cache.memory.enable   | true  | メモリでキャシュする                                   |
| browser.cache.memory.capacity | -1    | メモリサイズに合わせてキャッシュ量を自動調整してくれる |
