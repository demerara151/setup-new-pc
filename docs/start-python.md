# Python の環境構築

> このページは、[wiki](https://demerara151/setup-new-pc/wiki) に移行しました。docs 内の全てのドキュメントの移行作業が完了次第削除する予定です。

Windows で、VSCode を使った Python の環境構築手順です

出来る限り最小限の構成で構築します

## インストール

Python と パッケージマネージャー、VSCode を scoop でインストールします

```powershell
scoop install python poetry vscode
```

## Poetry の使い方

Python のパッケージマネージャー Poetry の具体的な使い方です

### 設定

仮想環境用のフォルダーをどこに作成するかを設定します

私は各プロジェクトの配下に仮想環境用のフォルダーを作成するのが好きなので、そのように設定します

この場合、以下のコマンドで設定できます

```powershell
poetry config virtualenvs.in-project true
```

デフォルトの `~\\AppData\\Local\\Poetry` に作成したい場合、このコマンドは不要です

### 新しいプロジェクトの作成

poetry で 新しいプロジェクトを作成します

```powershell
poetry new my-python-project
```

このコマンドは、新しい Python プロジェクトのフォルダーを作成します

### 仮想環境の初期化

先ほど作成したプロジェクトフォルダーに入り、`install` コマンドを実行します

```powershell
cd my-python-project
poetry install
```

このコマンドは、`.venv` フォルダーをプロジェクトの中に作成します

> デフォルトでは、`~\\AppData\\Local\\Poetry` の中

### 依存関係の追加

開発に必要なライブラリは `add` コマンドで追加できます

```powershell
# Example
poetry add pydantic typer[all] httpx[http2]
```

開発環境のみで使用するライブラリは `--group dev` オプションで指定します

```powershell
# Example
poetry add --group dev pytest black flake8
```

## VSCode の準備

プロジェクトの準備が整ったら、エディターの準備をします

### ワークスペース

先ほど作成したフォルダーを VSCode で開きます

```powershell
code my-python-project
```

メニューから「ファイル」を選択し、「名前を付けてワークスペースを保存...」をクリックします

### 拡張機能

Python の拡張機能をマーケットプレイスからインストールします。左側に縦に並んでるアイコンから拡張機能をクリックし、検索窓に `ms-python.python` と入力して検索してください

### 設定

設定ページを開き、ワークスペースのタブに切り替えます。右上の歯車のアイコンを押して設定ファイルを開きます

> 設定ファイルは `Ctrl + ,` でも開けます

以下の行を `{}` の内側に追加します

```jsonc
// my-python-project.code-workspace
"settings": {
    "[python]": {
      "editor.defaultFormatter": "ms-python.python",
      "editor.stickyScroll.enabled": true,
      "editor.wordBasedSuggestions": false,
      "editor.wordWrap": "on",
      "editor.wordWrapColumn": 79
    },
    "python.analysis.completeFunctionParens": true,
    "python.analysis.inlayHints.functionReturnTypes": true,
    "python.analysis.inlayHints.variableTypes": true,
    "python.analysis.logLevel": "Warning",
    "python.analysis.typeCheckingMode": "strict",
    "python.defaultInterpreterPath": ".venv\\Scripts\\python.exe",
    "python.formatting.blackArgs": ["--line-length=79"],
    "python.formatting.provider": "black",
    "python.languageServer": "Pylance",
    "python.linting.enabled": true,
    "python.linting.flake8Enabled": true,
    "python.linting.lintOnSave": true,
    "python.terminal.activateEnvironment": true,
    "python.testing.pytestArgs": ["tests"],
    "python.testing.pytestEnabled": true,
    "python.testing.unittestEnabled": false,
 }
```
