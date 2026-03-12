# claude-code-settings

Claude Codeのグローバル設定リポジトリ。

## セットアップ

```bash
git clone <repository-url>
cd claude-code-settings
./setup.sh
```

`~/.claude/` 配下にシンボリックリンクが作成されます。

## 設計方針

### 何をどこに定義するか

| 関心事 | 定義場所 | 注入方式 |
|--------|---------|---------|
| ワークフロー | `~/.claude/output-styles/` | システムプロンプト |
| Formatter・Linter の自動実行 | `settings.json` の `hooks` | ライフサイクルフック |
| プロジェクト固有のルール | `.claude/rules/` | ユーザーコンテキスト（パス制限可） |
| Lint・テストの実行手順 | `.claude/rules/` | ユーザーコンテキスト（パス制限可） |
| 禁止行動 | `.claude/rules/` | ユーザーコンテキスト（パス制限可） |
| アーキテクチャ上の制約 | `.claude/rules/` | ユーザーコンテキスト（パス制限可） |

- **Output Style** はシステムプロンプトとして注入されるため、全セッションに一貫して適用される
- **Hooks** はOS レベルで強制されるため、Claude の判断に依存しない
- **Rules** はユーザーコンテキストとして注入される。`paths` フロントマターで対象ファイルを限定できる

## ライセンス

MIT
