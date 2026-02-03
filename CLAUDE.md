# Claude Code グローバル設定

## 開発ワークフロー

開発タスクを受けた場合は、必ず以下のワークフローに従って進めること。

### フロー

```
/git-start → PM → TD → DR → TestD → Impl → CR → SA → CV → QF → DA → IT → ユーザー検証 → /git-finish
```

### 各ステップ

1. **`/git-start <branch>`** - 開発ブランチを作成
2. **Project Manager (PM)** - 要件整理・タスク分解
3. **Technical Designer (TD)** - 設計・アーキテクチャ決定
4. **Document Reviewer (DR)** - 設計ドキュメントレビュー（要修正なら TD へ戻る）
5. **Test Designer (TestD)** - テストケース・テスト戦略の設計
6. **Implement (Impl)** - コード実装・テストコード実装
7. **Code Reviewer (CR)** - コードの正しさ検証（問題あれば Impl へ戻る）
8. **Security Auditor (SA)** - セキュリティ脆弱性チェック（脆弱性あれば Impl へ戻る）
9. **Code Verifier (CV)** - ドキュメントとコードの整合性確認（齟齬あれば Impl へ戻る）
10. **Quality Fixer (QF)** - 静的解析・フォーマット
11. **Dependency Auditor (DA)** - 依存関係監査・ライセンスチェック（問題あれば Impl へ戻る）
12. **Integration Tester (IT)** - E2E・API統合テスト実行（失敗なら Impl へ戻る）
13. **ユーザー検証** - ビルド・ユニットテスト実行（失敗なら Impl へ戻る）
14. **`/git-finish`** - PR作成、マージ後はクリーンアップ

### 新規エージェントの役割

#### Test Designer (テスト設計者)
- **配置**: Document Reviewer → Test Designer → Implement
- **責務**: テストケース設計、境界値・エッジケース洗い出し、受け入れテスト基準の明確化
- **成果物**: テスト設計書（`docs/tests/<feature-name>-test-design.md`）

#### Security Auditor (セキュリティ監査者)
- **配置**: Code Reviewer → Security Auditor → Code Verifier
- **責務**: OWASP Top 10に基づく脆弱性チェック、機密情報ハードコード検出、認証・認可ロジック検証
- **判定基準**: Critical/High脆弱性が0件で承認、存在する場合はImplementへ差し戻し

#### Dependency Auditor (依存関係監査者)
- **配置**: Quality Fixer → Dependency Auditor → Integration Tester
- **責務**: 依存パッケージの脆弱性チェック、ライセンス互換性確認、非推奨パッケージ検出
- **判定基準**: Critical/High脆弱性が0件、ライセンス非互換なしで承認

#### Integration Tester (統合テスター)
- **配置**: Dependency Auditor → Integration Tester → ユーザー検証
- **責務**: E2Eテスト・API統合テスト・システム統合テストの実行
- **判定基準**: すべてのテストがパスで承認、失敗がある場合はImplementへ差し戻し
- **注意**: ユニットテストは実行しない（ユーザー検証フェーズで実行）

### 重要なルール

- 各ステップのエージェントを順番に実行すること
- レビューで問題が見つかった場合は、指定されたステップに戻って修正
- Integration Tester までは自動実行、ユーザー検証は手動
- 詳細は `WORKFLOW.md` を参照

### ゲートポイント

| ゲート | チェック内容 | 合格基準 |
|--------|------------|---------|
| 設計承認 | 設計の妥当性 | Document Reviewerの承認 |
| テスト設計 | テストケースの完全性 | Test Designerの完了 |
| コード品質 | コードの正しさ | Code Reviewerの承認 |
| セキュリティ | 脆弱性なし | Security Auditorの承認 |
| 整合性 | ドキュメントとコードの一致 | Code Verifierの承認 |
| 依存関係 | 依存関係の安全性 | Dependency Auditorの承認 |
| 統合テスト | 統合テスト成功 | Integration Testerの承認 |
| 最終承認 | ビルド・ユニットテスト | ユーザーの承認 |

## 言語

ユーザーとのコミュニケーションは日本語で行うこと。
