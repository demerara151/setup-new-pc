# Setup for Windows11
* 実行環境
  * Windows 11
  * Powershell 5.1

1. 初期設定は英語で行う

2. サインインオプションでオフラインアカウントを選択

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

7. 再起動し、`minInstaller.ps1`を走らせ、アプリを一括インストール
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\minInstaller.ps1
```

8. 復元ポイントの作成
* `設定＞システム＞バージョン情報＞デバイスの仕様` の下に並ぶ項目から*システムの保護*を選択。構成をクリックし、復元ポイントの作成を可能にする。可能にしたら、作成をクリックし復元ポイントを作成。

9.  wpdのインストール及び実行
```powershell
Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile $HOME\Downloads\wpd.zip
7z x wpd.zip
.\wpd.exe
```

10. 再起動し、追加で`windowsspyblocker`と`shutup10`をscoopでインストールし、実行。
