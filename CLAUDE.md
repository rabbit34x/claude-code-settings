# Claude Code グローバル設定

## 開発ワークフロー

開発タスクを受けた場合は、必ず以下のワークフローに従って進めること。

### フロー

```
/git-start → PM → TD → DR → Impl → CR → CV → QF → ユーザー検証 → /git-finish
```

### 各ステップ

1. **`/git-start <branch>`** - 開発ブランチを作成
2. **Project Manager** - 要件整理・タスク分解
3. **Technical Designer** - 設計・アーキテクチャ決定
4. **Document Reviewer** - 設計ドキュメントレビュー（要修正なら TD へ戻る）
5. **Implement** - コード実装
6. **Code Reviewer** - コードの正しさ検証（問題あれば Impl へ戻る）
7. **Code Verifier** - ドキュメントとコードの整合性確認（齟齬あれば Impl へ戻る）
8. **Quality Fixer** - 静的解析・フォーマット
9. **ユーザー検証** - ビルド・テスト実行（失敗なら Impl へ戻る）
10. **`/git-finish`** - PR作成、マージ後はクリーンアップ

### 重要なルール

- 各ステップのエージェントを順番に実行すること
- レビューで問題が見つかった場合は、指定されたステップに戻って修正
- Quality Fixer までは自動実行、ユーザー検証は手動
- 詳細は `WORKFLOW.md` を参照

## 言語

ユーザーとのコミュニケーションは日本語で行うこと。
