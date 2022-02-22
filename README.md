# Setup for Windows11
* 実行環境
  * Windows 11
  * Powershell 5.1


1. 日本語だとSophiaスクリプトの実行時にローカライズが見つからずエラーになるため、初期設定は英語で行う


2. Microsoftアカウントの作成を回避

* Windows 11 Home の場合： ネットに繋ぐ設定画面で`Alt+F4`を押す
    * 上記の方法でキャンセルできなかった場合、Microsoftアカウント設定画面で`Shift+F10`を押してコマンドプロンプトを呼び出す。
    ```CMD
    # Wi-Fi接続の場合
    X:\Sources> netsh wlan disconnect
    X:\Sources> exit
    ```
    と、入力して左上の戻る矢印をクリック。すると、ローカルアカウントの設定画面に飛ぶのでいつも通り設定するだけ

* Windows 11 Pro の場合： アカウント設定画面にサインインオプションとして「オフラインアカウントで使用」という選択肢があるのでネットに繋げたままでも問題ない（※最新のInsider buildから、Pro版でもMicrosoft アカウントの作成が必須になりました。上記の方法で回避できるかは未確認）

* Windows 11 Enterpriseでは、サインインオプションに「Join Domain instead」という選択肢が用意されている


3. 起動したらWindows Updateを実行して再起動。更新内容がなくなるまで繰り返す


4. 復元ポイントの構成


`SystemPropertiesProtection.exe`を起動。復元ポイントの構成をクリックし作成できるようにする


5. scoopのインストール及び、このリポジトリのクローン

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

iwr -useb get.scoop.sh | iex

scoop install 7zip mingit
scoop update

Set-Location $HOME\Documents; git clone https://github.com/demerara151/setup-new-pc.git

```


6. Sophia Scriptを走らせる


最新のソースコードを[リポジトリ](https://github.com/farag2/Sophia-Script-for-Windows)からダウンロードし、デフォルトの`Sophia.ps1`を、事前に用意した`SophiaPS5.ps1`に置き換えて、実行

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\SophiaPS5.ps1
```


7. アプリの一括インストール、及びWPDの起動

```powershell
.\$HOME\Documents\setup-new-pc\minInstaller.ps1

md $HOME\WPD | Set-Location; iwr -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\WPD\wpd.zip; 7z x wpd.zip; .\WPD.exe

```


8. テレメトリーの駆逐


スタートメニューから"O & O shutup10"と"windowsspyblocker"を起動
* `shutup10`は、'Actions'から'Recommended and somewhat recommended settings'を選択
* `windowsspyblocker`は、1を選択していくだけでOK


9. `Print Spooler`と`Windows Search`、そして`Microsoft EdgeUpdate`関連を全て無効化する

```powershell
sudo Set-Service -Name Spooler -StartupType Disabled -Status Stopped
sudo Set-Service -Name WSearch -StartupType Disabled -Status Stopped
sudo Set-Service -Name edgeupdate -StartupType Disabled -Status Stopped
sudo Set-Service -Name edgeupdatem -StartupType Disabled -Status Stopped
sudo Set-Service -Name MicrosoftEdgeElevationService -StartupType Disabled -Status Stopped

```


10. タスクスケジューラで`Edge Update`関連を全て無効化する


## それぞれの役割
* Sophiaはゴミ掃除と初期設定、WPDはそれで消しきれないアプリの削除とテレメトリーのブロック、shutup10はテレメトリーのブロックに加え不要な設定を無効化、windowsspyblockerはファイアーウォールのブロックリストにテレメトリー関連の通信を行うIPアドレスを追加


## Notes
* OneDriveは、WPDやBCuninstallerでも削除できるがうまくアンインストールできず中途半端に残ったりするので、Sophiaで消しておくのがおすすめ

* Microsoft Edgeは消えないし、消さない。色々問題が起きる。ただし、自動アップデートの機能は無効化してOK

* Windowsの既定のアプリに設定したいプログラムは`winget`でインストールする。Windows 11になってから`scoop`でインストールしたプログラムを設定しずらくなった。ブラウザに関しては全く受け付けてもらえない

* wingetでEdgeを一度インストールし、続けてwingetでアンインストールするとEdgeとその関連サービスとタスクが全て消えることが判明
```powershell
winget install --id Microsoft.Edge -s winget
winget uninstall --id -Microsoft.Edge -s winget
winget install --id Microsoft.EdgeWebView2Runtime -s winget
winget uninstall --id Microsoft.EdgeWebView2Runtime -s winget

```


## wingetを手動でインストールする場合
2022/02/21現在：Windows11をクリーンインストールすると最初から入ってる（Home版では入っていないこともある）
1. `https://github.com/microsoft/winget-cli`からバイナリファイルを直接ダウンロード

2. powershellを使ってインストール
```powershell
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

```
3. scoopでもインストールできるようになった（ただし、インストールされるのはプレビュー版なので注意が必要）
```
scoop install winget

```


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
3. `My rules`に、次の2行を追加
```txt
* * 3p-frame block
* * 3p-script block
```


## LocalCDNの設定
1. Advancedのタブ下部にある項目の`uBlock`をクリック
2. 表示された内容をコピーして、uBOの設定画面にある`My rules`の右側の欄に貼り付け
3. Saveで確定し、Commitを押す


## about:configで変更したい箇所

| key                                                | value | note                                       |
| -------------------------------------------------- | :---: | ------------------------------------------ |
| network.http.max-persistent-connections-per-server |  16   | リソースを何分割でダウンロードするか       |
| browser.cache.disk.capacity                        |   0   | デフォルトは256000                         |
| browser.cache.disk.smart_size.enabled              | false | キャッシュサイズを自動で計算してくれる機能 |


## Autohotkeyの設定
英語配列キーボード向けのキーの挙動変更。入れ替えるキーは以下の2つ
   * セミコロン（`;`）とコロン（`:`）
   * `CapsLock`と`ESC`
1. [colon.ahk](autohotkey/colon.ahk)を、スタートアッププログラムのあるフォルダ（shell:startup）に配置
2. プロパティを開き、既定のプログラムを"$HOME\\scoop\\apps\\autohotkey\\current\\autohotkeyU64.exe"に変更


# 日本語フォントの導入（手動）
1. [Klee One](https://github.com/fontworks-fonts/Klee)
2. [RocknRoll One](https://github.com/fontworks-fonts/RocknRoll)
3. [IBM Plex Sans JP](https://github.com/IBM/plex/releases)
  * TrueTypeを選択


# Windows11 HOMEにおける"Hyper-V"の有効化
コマンドプロンプトを管理者権限で開き、次のバッチファイルを実行
```Powershell
.\$HOME\Documents\setup-new-pc\hyper-v\hv.bat

```
* もし、Windows Insider Program への参加が条件で、実行できない場合は、`scoop install offlineinsiderenroll`でMicrosoftアカウントを作成せずにインサイダーへ参加する


# Experimental
`winget import -i winget-apps.json`による一括インストール
* `winget export -o winget-apps.json -s winget`でエクスポート済み
* エクスポートした winget のバージョンとインポートしようとしている winget のバージョンが違うと実行できないため、`winget-apps.json`の最後にあるバージョンの数字を現在のバージョンで書き換える必要がある
