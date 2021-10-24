* 初期設定時にはネットに繋がない（Microsoftアカウントを要求されるため）

1. 初期設定が終わったら、ネットに繋いでwindows updateを実行
2. 再起動
3. グラフィックドライバーをアップデートまたは確認
4. 再起動
5. 予め作成しておいた、sophia scriptのフォルダーをダウンロード、またはUSB等で持ってくる
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

9. [wpd](https://wpd.app/)をインストールし、テレメトリーや不要なアプリを削除  
    必ず復元ポイントを作成する
10. 再起動
11. Scoop をインストール
    ```Powershell
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

    # もし上記のコマンドがエラーになるなら次を実行
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    ```
12. 複数のプログラムをまとめて Scoop でインストール
    ```Powershell
    scoop install 7zip git
    scoop update *
    scoop bucket add extra game nerd-fonts

    # 以下、編集中
    scoop install sudo touch aria2 waterfox-current everything ffmpeg lightbulb windows-terminal foobar2000 python vscodium notepadplusplus mpv sharex github bitwarden imageglass gallery-dl crystaldiskinfo crystaldiskmark freetube mailspring hwinfo
    ```
13. 再起動
14. [Clibor](https://forest.watch.impress.co.jp/library/software/clibor/)を手動でインストール
