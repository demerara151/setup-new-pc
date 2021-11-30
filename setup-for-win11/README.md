# Setup for Windows11
* 実行環境
  * Windows 11
  * Powershell 5.1

1. 初期設定は英語で行う

2. サインインオプションでオフラインアカウントを選択
* どうやらPro版だと、オフラインアカウントという選択肢が出るみたい
* Home版の場合は、今まで通りネットワークの設定をスキップすることで回避可能
* 万が一、選択できない状態になった場合は、ルーターの電源を落とすか、Shift+F10でコマンドプロンプトを表示して`shutdown /r`と入力して再起動する

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

7. 再起動し、`minInstaller.ps1`を走らせ、アプリを一括インストール。もしくは単に中身をコピーして貼り付ける
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\minInstaller.ps1
```

8. 復元ポイントの作成
* `SystemPorpertiesProtection.exe`を起動。復元ポイントの構成をクリックし作成できるようにする

9. テレメトリー及び不要なアプリの殲滅
```powershell
iwr -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\Downloads\wpd.zip | Set-Location Downloads; 7z x wpd.zip

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

## Dark theme for librewolf
* Profileフォルダーに、[chrome](./chrome)フォルダーをそのまま移動
