# 函館マップコレクション（ローカル開発用）

このリポジトリは函館のスポットを地図で表示する Flutter アプリの基盤です。
当面はデータベースなしで進めます（将来的に差し替え可能な設計にします）。

## 前提
- Flutter がインストールされていること
- git が使えること

## リポジトリのクローンとローカル準備（PowerShell）

```powershell
# リポジトリをクローン
git clone https://github.com/Ryoma-Fukusho/osakana_MCB.git
cd .\osakana_MCB\

# 新しい作業ブランチを作る（例）
git checkout -b feature/home-map

# 依存取得
flutter pub get

# 解析・整形・テスト
flutter analyze
dart format .
flutter test

# 実機またはエミュレータで起動
flutter run
```

## ブランチとワークフロー（簡易ルール）
- `main` は常に動作する状態に保つ（チームで合意したら保護ブランチにする）
- ブランチ名:
	- 機能: `feature/<説明>` 例: `feature/home-map`
	- 修正: `fix/<説明>`
- 作業手順:
	1. `git pull origin main`
	2. `git checkout -b feature/<name>`
	3. 作業 → 小さくコミット → `git push origin feature/<name>`
	4. GitHub で PR を作成し、コードレビューの後に `main` へマージ

## 何をこのブランチで提供済みか（現在の状態）
- `lib/screens/home_screen.dart` — 地図上にスポットを表示するホーム画面のスキャフォールド
- `lib/models/spot.dart` — Spot モデル定義
- `lib/repository/*` — `SpotRepository` のインタフェースと InMemory 実装（`assets/places.json` から初期ロード）
- `assets/places.json` — 函館の簡易スポットデータ（サンプル）

## 下級生（実装担当）への割り当て案
- 検索機能 (`lib/screens/search_screen.dart`) — SpotRepository.search を使ってフィルタ表示
- 投稿機能 (`lib/screens/post_screen.dart`) — SpotRepository.add を呼んでホームに反映

## 依存関係（追加済み）
- `flutter_map`, `latlong2` — OpenStreetMap を使った地図表示
- `url_launcher` — URL を開く（現時点では外部ブラウザ）
- `shared_preferences` — 後で簡易永続化を入れる場合に使用

## 開発時の注意
- `build/` 以下や自動生成ファイルは編集しないでください。
- 新しいパッケージを追加したら `flutter pub get` を実行してください。

---
他に README に載せたい内容（CI ワークフロー、スクリーンショットの追加、コードスタイルの詳細）があれば教えてください。必要ならこのまま Home の実装を拡張して、検索画面・投稿画面の雛形も作成します。
