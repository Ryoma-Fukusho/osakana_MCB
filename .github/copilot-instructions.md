## 概要

このリポジトリは Flutter の標準テンプレートをベースにしたアプリです。AI エージェントは以下のポイントを押さえれば素早く貢献できます。

## 重要な参照ファイル

- `lib/main.dart` — アプリのエントリポイント（`MyApp` → `MyHomePage`）。UI の起点。
- `pubspec.yaml` — 依存関係、アセット、Flutter 設定。
- `analysis_options.yaml` — プロジェクトの lint ルール（`flutter_lints` を使用）。
- `test/widget_test.dart` — テンプレートのテスト。ここにウィジェット/ユニットテストを追加する。
- `android/`, `ios/`, `windows/`, `macos/`, `linux/` — プラットフォーム固有コード。ネイティブ修正はこれらを編集。

## アーキテクチャ／慣習（このプロジェクト固有）

- 小規模な単一 Flutter アプリ。StatefulWidget と `setState` を使った簡潔な状態管理が既存のパターン。
- Null-safety が有効（Dart SDK >= 3.x）。すべての新コードは null-safety に準拠すること。
- リントは `analysis_options.yaml` により管理。`flutter_lints` に準拠しているので、`dart format` と `flutter analyze` を実行してから PR を出す。
- 自動生成・ビルド成果物（`build/` や各プラットフォームの `Generated*` ファイル）は編集しない。

## よく使うコマンド（PowerShell 用例）

```powershell
flutter pub get
flutter analyze
dart format .
flutter test
flutter run           # 接続されているデバイスで起動
flutter build apk     # Android APK を生成
# Windows ビルド
flutter build windows
# 直接 Gradle を使う（Android）
& .\android\gradlew.bat assembleDebug
```

注: iOS ビルドは macOS が必要です（`flutter build ios` を使用）。

## 変更時の具体的手順

- 新パッケージ追加: `pubspec.yaml` を編集 → `flutter pub get` 実行 → 必要ならネイティブ側（Android/iOS）の権限や設定を追加。
- アセット追加: 画像などは `assets/` またはプロジェクトの任意ディレクトリに置き、`pubspec.yaml` の `flutter:` 配下で宣言する。
- ネイティブ統合: Android の権限は `android/app/src/main/AndroidManifest.xml`、iOS の説明は `ios/Runner/Info.plist` に追加。

## テストと品質ゲート

- PR 前に `flutter analyze` と `flutter test` をローカルで実行すること。
- 既存の `test/widget_test.dart` を参考にして、ウィジェットレベルのテストを追加する。

## 具体的な例（エージェント向け行動指針）

- 新しい画面を追加する場合:
  1. `lib/screens/` を作成（命名はスネークケース or lowerCamelCase のディレクトリ名）。
  2. `lib/main.dart` から Navigator で遷移させるかルーティングを追加。
- ネイティブ権限が必要なパッケージ（例: カメラ）:
  1. `pubspec.yaml` にパッケージ追加
  2. `flutter pub get`
  3. Android: `AndroidManifest.xml` へ権限追記、iOS: `Info.plist` に説明追加

## 編集してはいけない箇所

- `build/` 以下、及び自動生成ファイル（`GeneratedPluginRegistrant.*` など）は直接編集しない。

---
このファイルに不足があれば具体的に教えてください（CI ワークフロー、リリース手順、追加のディレクトリ規約など）。
