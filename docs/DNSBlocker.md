# About DNS Blocker

DNS レベルで広告やトラッカーをブロックできるのがメリット。

特に、ブラウザ以外のソフトウェア、ゲーム、PC以外のデバイス、IOT家電等、インターネットに接続する可能性のあるデバイス全てに適用できるが大きい。

ブラウザは、FireFox系＋UblockOrigin環境では無意味だが、Chromium系なら効果あり。

DNSブロッカーをいくつか試したが、どのプロジェクトも大きなデメリットとしてリクエスト先の情報が必ず一度DNSサーバーに送られてしまうと点がある。たとえ、そのデータを一切二次利用しないと公言していても、プライバシーの問題は解決されない。

そこに現れた救世主が、Adguard Home である。

# Adguard Home

サーバーをローカルで管理できる唯一無二のDNSブロッカー。

全てのデータはユーザーの管理下に置かれる。外部に送信されることはない。

現在まだ正式にリリースされているわけではないが、GitHubからダウンロードして利用することができる。

# Installation

[How to install program manually](https://github.com/AdguardTeam/AdGuardHome/wiki/Getting-Started)

まず初めに、以下のコマンドでAdguard Homeを起動する。

```Powershell
sudo .\AdGuardHome
```

ここで表示されるポートナンバー3000のアドレスを開くと、初期設定が始まる。

案内に従って、設定を終えたらコントロールパネルを開きネットワーク設定で、DNSを現在開いているアドレスに設定する。

次に、Adguard Home をサービスに登録する。

```Powershell
sudo .\AdGuardHome -s install
```
