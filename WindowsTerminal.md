# 本体のインストール
* デフォルトでインストールされている場合は不要
```Powershell
scoop install windows-terminal
```

# posh-git
```Powershell
scoop install posh-git

# Pofileに設定を反映させる
Add-PoshGitToProfile
```

# oh-my-posh
```Powershell
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
```
設定を反映させるために、$PROFILEに次の行を追加

```profile.ps1
oh-my-posh --init --shell pwsh --config "$(scoopprefix oh-my-posh)/themes/ys.omp.json" | Invoke-Expression
```
* `ys.omp.json`の`ys`の部分は好きなテーマの名前
