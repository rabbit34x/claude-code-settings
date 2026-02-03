# claude-code-settings

Claude Codeのグローバル設定とカスタムエージェントをまとめたリポジトリ。

## セットアップ

```bash
git clone <repository-url>
cd claude-code-settings
./setup.sh
```

`~/.claude/` 配下にシンボリックリンクが作成されます。

## 構成

```
├── CLAUDE.md           # グローバルプロジェクトメモリ（ワークフロー指示）
├── WORKFLOW.md         # 詳細ワークフロードキュメント
├── settings.json       # グローバル設定
├── agents/             # カスタムエージェント
│   ├── git-init/           # ブランチセットアップ
│   ├── project-manager/
│   ├── technical-designer/
│   ├── document-reviewer/
│   ├── test-designer/
│   ├── implement/
│   ├── code-reviewer/
│   ├── security-auditor/
│   ├── code-verifier/
│   ├── quality-fixer/
│   ├── dependency-auditor/
│   ├── integration-tester/
│   └── git-finish/
├── commands/           # カスタムコマンド
├── hooks/              # ライフサイクルフック
└── skills/             # カスタムスキル
    ├── git-start/      # ブランチ作成
    └── git-finish/     # PR作成 & クリーンアップ
```

## スキルコマンド

| コマンド | 説明 |
|---------|------|
| `/git-start <branch>` | mainから最新を取得し、新しい開発ブランチを作成 |
| `/git-finish` | PR作成またはマージ後のクリーンアップを自動判定 |

## 開発ワークフロー

詳細は [WORKFLOW.md](WORKFLOW.md) を参照。

### フロー概要

```
git-init → PM → TD → DR → TestD → Impl → CR → SA → CV → QF → DA → IT → ユーザー検証 → git-finish
```

### エージェント一覧

| # | エージェント | 役割 | 主な成果物 |
|---|------------|------|----------|
| 0 | Git Init | ブランチセットアップ | 開発ブランチ |
| 1 | Project Manager | 要件整理・タスク分解 | 要件定義書 |
| 2 | Technical Designer | 設計・アーキテクチャ決定 | 設計ドキュメント |
| 3 | Document Reviewer | 設計ドキュメントレビュー | レビュー結果 |
| 4 | Test Designer | テスト設計 | テスト設計書 |
| 5 | Implement | コード実装・テスト実装 | ソースコード・テストコード |
| 6 | Code Reviewer | コードの正しさ検証 | レビュー指摘事項 |
| 7 | Security Auditor | セキュリティ脆弱性チェック | セキュリティ監査レポート |
| 8 | Code Verifier | ドキュメントとコードの整合性確認 | 整合性チェック結果 |
| 9 | Quality Fixer | 静的解析・フォーマット | 整形済みコード |
| 10 | Dependency Auditor | 依存関係監査・ライセンスチェック | 依存関係監査レポート |
| 11 | Integration Tester | E2E・API統合テスト実行 | 統合テスト結果レポート |
| 12 | ユーザー | ビルド・ユニットテスト | - |
| 13 | Git Finish | PR作成・クリーンアップ | PR |

## 使用例

```bash
# 機能開発を依頼
claude "JWT認証を使用したログイン機能を実装してください"

# 自動的に以下が実行される:
# 1. Git Init: ブランチ作成
# 2. Project Manager: 要件整理
# 3. Technical Designer: 設計
# 4. Document Reviewer: 設計レビュー
# 5. Test Designer: テストケース設計
# 6. Implement: コード・テスト実装
# 7. Code Reviewer: コードレビュー
# 8. Security Auditor: セキュリティチェック
# 9. Code Verifier: 整合性確認
# 10. Quality Fixer: 静的解析
# 11. Dependency Auditor: 依存関係監査
# 12. Integration Tester: 統合テスト実行

# ユーザー検証（手動）
npm test && npm run build

# 承認・PR作成
claude "承認します"
```

## バージョン履歴

### v2.0.0 (2026-02-03)
- 4つの新規エージェント追加
  - Test Designer: テスト設計の専門化
  - Security Auditor: OWASP Top 10ベースのセキュリティ監査
  - Dependency Auditor: 依存関係とライセンスの監査
  - Integration Tester: 統合テストの自動実行
- ワークフローの拡張（8ステップ → 12ステップ）
- 多層防御アーキテクチャの実装
- WORKFLOW.md の大幅更新

### v1.0.0 (2026-02-02)
- 初版リリース
- 基本ワークフローの定義（8ステップ）
- Git Init / Git Finish エージェントの追加

## ライセンス

MIT
