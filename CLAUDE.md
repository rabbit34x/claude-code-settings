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

### 重要なルール

- 各ステップのエージェントを順番に実行すること
- レビューで問題が見つかった場合は、指定されたステップに戻って修正
- Integration Tester までは自動実行、ユーザー検証は手動
- 詳細は `WORKFLOW.md` を参照

## 言語

ユーザーとのコミュニケーションは日本語で行うこと。
