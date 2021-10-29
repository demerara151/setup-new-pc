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

    scoop install aria2 bat bitwarden bottom broot ccleaner deepl deno dust everything exifcleaner fd ffmpeg flac foobar2000 freetube fzf gallery-dl gimp git github gitui go hwinfo imageglass julia less lightbulb losslesscut lsd mailspring mpv neovim nu playnite python ripgrep sharex sqlitebrowser starship streamlink streamlink-twitch-gui sudo tldr touch trilium typora ungoogled-chromium vscodium-portable waterfox-current zoxide

    sudo scoop install vcredist2015 vcredist2019 victor-mono icaros-np Meslo-NF FiraCode
    ```

13. ついでに、pythonでも必要なものをインストール
    ```powershell
    python -m pip install flake8 black yt-dlp legendary-gl
    ```

14. 再起動

15. [Clibor](https://forest.watch.impress.co.jp/library/software/clibor/)を手動でインストール

16. タスクスケジューラで、「MicrosoftEdgeUpdateTaskMachineCore」と「NvTmRep_CrashReport」関連を全て無効化する
