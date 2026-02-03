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
│   ├── git-init/           # ブランチセットアップ
│   ├── project-manager/
│   ├── technical-designer/
│   ├── document-reviewer/
│   ├── implement/
│   ├── code-reviewer/
│   ├── code-verifier/
│   ├── quality-fixer/
│   └── git-finish/         # PR作成 & クリーンアップ
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

```
git-init → PM → TD → DR → Impl → CR → CV → QF → ユーザー検証 → git-finish(PR) → マージ → git-finish(cleanup)
```
