# Rust の環境構築

> このページは、[wiki](https://demerara151/setup-new-pc/wiki) に移行しました。docs 内の全てのドキュメントの移行作業が完了次第削除する予定です。

Windows で、VSCode を使った Rust の環境構築手順です

出来る限り最小限の構成で構築します

## インストール

scoop で `rustup` をインストールします

`rustup` とは、Rust 本体やツールチェーン、コンパイラなどをまとめて管理できるツールです

```powershell
scoop install rustup
```

[Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) から `Visual Studio Build Tools 2022` をダウンロードしてインストールします

次に `Visual Studio Installer` を起動して `C/C++ desktop development` のセクションにある `MSVC Build tools` と `Windows SDK` にチェックを入れてインストールします

![build_tools](https://user-images.githubusercontent.com/54271767/219233838-0b5c43b0-97f6-4c4a-8c1c-b5e7edfb06f5.png)

### 新しいプロジェクトの作成

ターミナルで `cargo new [プロジェクト名]` を実行します

```powershell
# 新しいプロジェクトを作成する
cargo new my_rust_project
```

## VSCode の準備

VSCode でプロジェクトフォルダーを開きます

```powershell
code my_rust_project
```

### 拡張機能

Rust の拡張機能をマーケットプレイスからインストールします。左側に縦に並んでるアイコンから拡張機能をクリックし、検索窓に `rust-lang.rust-analyzer` と入力して検索してください

> もしくは右下に通知が出ているので、そこをクリックしてインストールすることもできます

### 設定

設定ページを開き、ワークスペースのタブに切り替えます。右上の歯車のアイコンを押して設定ファイルを開きます

> 設定ファイルは `Ctrl + ,` でも開けます

以下の行を `{}` の内側に追加します

```jsonc
"settings":
	"[rust]": {
		"editor.defaultFormatter": "rust-lang.rust-analyzer",
	},
```

## 補足

依存関係は `cargo add [crate-name]` で追加できます
