# Setup for Windows11
* 実行環境
  * Windows 11
  * Powershell 5.1

1. 初期設定は英語で行う（日本語だとSophiaスクリプトの実行時にローカライズが見つからずエラーになるため）
* デフォルトのままWindowsを使う場合は関係ないので、素直に日本語で始める

2. Microsoftアカウントの作成を回避
* Windows 10 の場合： 初期設定時のネットワーク設定画面で、ネットワークの設定をスキップする
* Windows 11 Home の場合： ネットに繋ぐ設定画面で`Alt+F4`を押す。これでMicrosoftアカウントのセットアップをスキップできるらしい。
    * 上記の方法でキャンセルできなかった場合、Microsoftアカウント設定画面で`Shift+F10`を押してコマンドプロンプトを呼び出す。
    ```CMD
    X:/Source> netsh wlan disconnect
    X:/Source> exit
    ```
    と、入力して左上の戻る矢印をクリック。すると、ローカルアカウントの設定画面に飛ぶのでいつも通り設定するだけ。
    * 起動後、設定画面からネットワークのトラブルシューティングを実行すればいい
* Windows 11 Pro の場合： アカウント設定画面にサインインオプションとして「オフラインアカウントで使用」という選択肢があるのでネットに繋げたままでも問題ない

3. 起動したらWindows Updateを実行して再起動

4. scoopで7zipとmingitをインストール
```powershell
# 実行ポリシーの設定
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# scoopのインストール
iwr -useb get.scoop.sh | iex

scoop install 7zip mingit
scoop update
```

5. このリポジトリをクローン

```powershell
git clone https://github.com/demerara151/setup-new-pc.git
```

6. Sophia Scriptを走らせる
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\Sophia.ps1
```

7. 再起動し、自動インストールスクリプトを走らせ、アプリを一括インストール。もしくは単に中身をコピーして貼り付ける
```powershell
.\minInstaller.ps1

# Or Install all apps from main PC
.\AutoInstallerFull.ps1
```

8. 復元ポイントの作成
* `SystemPorpertiesProtection.exe`を起動。復元ポイントの構成をクリックし作成できるようにする

9. テレメトリー及び不要なアプリの殲滅
```powershell
iwr -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\Downloads\wpd.zip | Set-Location $HOME\Downloads; 7z x wpd.zip

.\WPD.exe
# Windows DefenderとWindows Update以外全て無効化して構わない

windowsspyblocker.exe
# 1だけ選択していけばOK

OOSU10.exe
# limitedまでを全てブロック
```

10. サービス管理ツールで、`Print Spooler`と`Windows Search`、そして`Microsoft EdgeUpdate`関連を全て無効化する

11. タスクスケジューラで`Edge Update`関連を全て無効化する

12. 最終確認及び後片付け
* `bulk-crap-uninstaller`で、プリインストールされているソフトが残ってないか確認
* `ccleaner`で、一時ファイル＆レジストリの掃除

## それぞれの役割
* Sophiaはゴミ掃除と初期設定、WPDはそれで消しきれないアプリの削除とテレメトリーのブロック、shutup10はテレメトリーのブロックに加え不要な設定を無効化、windowsspyblockerはファイアーウォールのブロックリストにテレメトリー関連の通信を行うIPアドレスを追加

## Notes
* Windows Terminal & Powershell 7.2の環境で、Sophia.ps1を実行したところ複数のコマンドが実行できずに終了したり、表示がおかしくなってプログラムが止まったりとうまくいかなかった。デフォルトのPowershell 5.1で実行するのがベター
* OneDriveは、WPDやBCuninstallerでも削除できるがうまくアンインストールできず中途半端に残ったりするので、Sophiaで消しておくのがおすすめ
* Microsoft Edgeは消えないし、消さない。色々問題が起きる。ただし、自動アップデートの機能は無効化してOK

## wingetを手動でインストールする場合
* 次の場所からファイルをダウンロード
`https://github.com/microsoft/winget-cli/releases/download/v1.1.12701/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle`
* powershellを使ってインストール
```powershell
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
```

# ブラウザ設定
* LibreWolfを使用
* 正直そのままでも問題ない
* Windowsの設定画面、アプリ -> 既定のアプリで、LibreWolfを既定のブラウザに設定する（ブラウザ側で設定しても適用してくれない）

## 拡張機能の導入
* DarkReader
* Privacy Redirect
* LocalCDN
* Bitwarden
* CanvasBlocker
* ClearURLs
* Cookie AutoDelete

## uBlockOriginの上級者設定
* 設定画面の「私は上級者です」にチェック
* デフォルトのフィルターを全て適用
* My rulesに、次の2行を追加
```txt
* * 3p-frame block
* * 3p-script block
```

## 拡張機能にダークテーマを適用する
* about:configで`toolkit.legacyUserProfileCustomizations.stylesheets`の値を`true`に変更
* Profileフォルダーに、[chrome](librewolf/chrome)フォルダーをそのまま移動
* 適宜、`addons.css`内の拡張機能のUUIDを置き換え

## about:configで変更したい箇所

| key                                                | value | note                                       |
| -------------------------------------------------- | :---: | ------------------------------------------ |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか       |
| browser.cache.disk.capacity                        |   0   | デフォルトは256000                         |
| browser.cache.disk.smart_size.enabled              | false | キャッシュサイズを自動で計算してくれる機能 |
