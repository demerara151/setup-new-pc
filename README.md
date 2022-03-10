# Initial command

* 管理者権限でターミナル、またはPowershell(5.1)を開く

  ```powershell
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser

  iwr -useb get.scoop.sh | iex

  scoop install 7zip mingit sudo
  scoop update

  git clone https://github.com/demerara151/setup-new-pc.git

  Set-Location setup-new-pc
  git checkout vm

  Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
  sudo .\Sophia\Sophia.ps1

  .\installAll.ps1

  ```

# Telemetry
  * `WPD`
    * プライバシー： `Windows Update` と `Windows Defender ウィルス対策`、`Windows Push Notification Service` 以外の項目を全てオフに
    * ブロッカー： 3項目全てを適用。`Firewall` はそのまま
    * アプリ： 不要なものを選択して削除

  * `O&O ShutUp10`
    * `Actions` から `Recommended and somewhat recommended settings` を選択
  * `windowsspyblocker`
    * 全て `1` を選択

# SymLink
* 再起動したら、ターミナルでデフォルトのシェルを `Powershell 7` に設定する

* ターミナルを再起動して、シンボリックリンクを作成する

  ```powershell
  .\symLinkCreator.ps1
  ```
