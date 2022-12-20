# 不要な Windows サービス

個人的に不要な Windows サービスの詳細。Windows Update の度に増えたり減ったりするので気付いたら編集します。

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Fax](#fax)
- [Print Spooler](#print-spooler)
- [IP Helper](#ip-helper)
- [IP 変換構成サービス](#ip-変換構成サービス)
- [Network Connectivity Assistant](#network-connectivity-assistant)
- [Geo Location](#geo-location)
- [Windows Search](#windows-search)
- [Microsoft Edge Elevation Service](#microsoft-edge-elevation-service)
- [Microsoft Edge Update Service](#microsoft-edge-update-service)
- [Connected User Experience](#connected-user-experience)
- [AllJoyn Router Service](#alljoyn-router-service)
- [Program Compatibility Service](#program-compatibility-service)
- [デバイス管理ワイヤレス アプリケーション プロトコル (WAP) プッシュ メッセージ ルーティング サービス](#デバイス管理ワイヤレス-アプリケーション-プロトコル-wap-プッシュ-メッセージ-ルーティング-サービス)
- [Remote Registry](#remote-registry)
- [Windows Image Acquisition](#windows-image-acquisition)
- [Xbox Accessory Management Service](#xbox-accessory-management-service)
- [Xbox Live Auth Manager](#xbox-live-auth-manager)
- [Xbox Live Game Save Service](#xbox-live-game-save-service)
- [Xbox Live Networking Service](#xbox-live-networking-service)
- [Window Network Data Usage Monitor](#window-network-data-usage-monitor)
- [Window Insider Service](#window-insider-service)

## Fax

ファックスの送受信を行うサービス。ファックスを利用する予定がないなら不要です。

## Print Spooler

ファイルの印刷を行うサービス。印刷機能を使わないのなら不要です。デフォルトで常駐してます。無効化推奨

## IP Helper

IPv4 の回線が混みあってきたら自動的に IPv6 へ切り替えてくれるサービス。IPv6 を利用していないなら不要です。

## IP 変換構成サービス

IPv4 と IPv6 の変換を構成して有効にするサービス。上記のサービスを無効化しているならこちらも不要です。

## Network Connectivity Assistant

UI コンポーネントにダイレクトアクセスの状態通知を提供するサービス。ダイレクトアクセスを利用していないなら無効にして構いません。組織に属していない限り使う機会はないと思います。

-   [ダイレクトアクセス機能とは](https://learn.microsoft.com/ja-jp/windows-server/remote/remote-access/directaccess/directaccess)

## Geo Location

Microsoft による現在地特定サービス。地図機能とかで利用してます。Microsoft Edge で近所のお店なんかを調べると正確な位置情報が表示されるのもこれのおかげです。

現在地をリアルタイムで監視されても構わない人を除いて、無効化推奨。

## Windows Search

Windows 標準検索サービス。主な仕事はインデックスを付けること。

インデックスを付与することにより検索がスムーズに行えます。その代償として、四六時中インデックスを貼り続けてるのでストレージアクセスが多くシステムが重たくなります。時折、CPU 使用率 100% を叩きだすことも。加えて、ストレージの寿命を縮めます。

SSD が主流の時代では無用の長物。インデックスなんか貼らなくても SSD なら十分速い。というかデフォルトの検索機能なんてそもそも使わないって人は無効化推奨。

HDD を利用している人で、かつデフォルトの検索機能を多様している人は必須。

## Microsoft Edge Elevation Service

Microsoft Edge のアップデートがないか常時確認するサービス。全部で 3 種類あります。詳細は不明だが、Microsoft 製品も Edge も使わない人は無効化推奨。気を抜くとすぐ復活して常駐します。

File path: `C:\Program Files (x86)\Microsoft\Edge\Application\107.0.1418.26\elevation_service.exe`

## Microsoft Edge Update Service

Microsoft Edge のアップデートがないか常時確認するサービス。

実行パスの引数が、`/svc` のものと `/medsvc` の 2 種類ある。それぞれが何を意味するのかは不明。とにかく永遠に常駐してる。

File path: `C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe`

## Connected User Experience

最もメジャーなテレメトリです。PC の使用状況を収集して Microsoft に送信します。必ず無効化しましょう。

Windows が快適に使えない原因の多くはこのサービスが常駐していることにあります。パソコンが重たいのは大体こいつのせいです。

## AllJoyn Router Service

IoT 家電との通信を可能にするサービスです。スマートテレビや冷蔵庫、電球や暖房といった家電などと連携することができます。IoT 家電との通信が不要なら無効化推奨。

## Program Compatibility Service

プログラム互換性サービス。Windows 11 では動作保証がないプログラムを動かしてくれるサービス。古いソフトや昔のオンラインゲーム、カーネルレベルのアンチチートシステムを導入してるゲームなんかは、これを無効化すると起動しなくなります。

個人的には無効化推奨です。セキュリティ的に非常によくありません。が、利便性や娯楽を奪うことになるため、危険性を理解した上で利用するのであれば止めません。

## デバイス管理ワイヤレス アプリケーション プロトコル (WAP) プッシュ メッセージ ルーティング サービス

もう一つのテレメトリサービスです。ユーザーの PC 使用状況を Microsoft に送信します。プライバシーを守りたいなら無効化必須。

## Remote Registry

外部の PC からこの PC のレジストリを編集することができるようになるサービス。セキュリティ的に非常に危険なため、今すぐ無効化することをおすすめします。ハッカーをこれを利用することで簡単に PC を乗っ取ります。

## Windows Image Acquisition

スキャナーやデジタルカメラを PC に接続して使う場合に必要になるサービス。それらのデバイスを使う予定がないなら不要。

## Xbox Accessory Management Service

Xbox のアプリケーションを利用してゲームをプレイするつもりがないなら、全て不要なサービス。現在全部で 4 種類のサービスが存在してます。以下 3 種、全て Xbox 関連のサービスで無効化推奨。

## Xbox Live Auth Manager

上記を参照。

## Xbox Live Game Save Service

上記を参照。

## Xbox Live Networking Service

上記を参照。

## Window Network Data Usage Monitor

ネットワークデータの使用状況収集サービス。今月何ギガ使ったとかがわかるサービス。従量制課金接続でも利用していない限り不要。これも Microsoft にデータを送信する。

## Window Insider Service

Windows Insider を利用していない場合のみ無効化可能。現在、Windows 11 でのみインサイダーへの参加が可能。無効化非推奨。
