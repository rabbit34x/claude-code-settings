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
├── settings.json       # グローバル設定
├── agents/             # カスタムエージェント
│   ├── project-manager/
│   ├── technical-designer/
│   ├── document-reviewer/
│   ├── implement/
│   ├── code-reviewer/
│   ├── code-verifier/
│   └── quality-fixer/
├── commands/           # カスタムコマンド
├── hooks/              # ライフサイクルフック
└── skills/             # カスタムスキル
```

## 開発ワークフロー

詳細は [WORKFLOW.md](WORKFLOW.md) を参照。

```
User Request → Project Manager → Technical Designer → Document Reviewer
→ Implement → Code Reviewer → Code Verifier → Quality Fixer → Ready
```
