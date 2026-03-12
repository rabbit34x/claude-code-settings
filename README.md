# claude-code-settings

Claude Codeのグローバル設定リポジトリ。

## セットアップ

```bash
git clone <repository-url>
cd claude-code-settings
./setup.sh
```

`~/.claude/` 配下にシンボリックリンクが作成されます。

## ディレクトリ構成

### settings.json

Claude Code本体の設定ファイル。パーミッション、サンドボックス、フック、デフォルトモードなどを定義する。

変更するとき: 権限モデル、サンドボックス設定、環境変数など、Claude Codeの動作そのものを変えたいとき。

https://docs.anthropic.com/en/docs/claude-code/settings

### rules/

グローバルに適用されるルール。**ユーザーコンテキストとして注入**される。`paths` フロントマターで対象ファイルを限定できる。

追加するとき: タスクの手順、禁止行動、Lint・テストの実行手順など、Claudeに従わせたいルールがあるとき。

プロジェクト固有のルールはこのリポジトリではなく、各プロジェクトの `.claude/rules/` に置く。

https://docs.anthropic.com/en/docs/claude-code/memory#organize-rules-with-clauderules

### agents/

サブエージェントの定義。research、plan、implementなどの専門エージェントを定義する。

追加するとき: 新しい役割のサブエージェントが必要なとき。

https://docs.anthropic.com/en/docs/claude-code/sub-agents

### skills/

スラッシュコマンドとして呼び出せるスキルの定義。

追加するとき: `/command` 形式で呼び出したい再利用可能な操作があるとき。

https://docs.anthropic.com/en/docs/claude-code/sub-agents#skills

### CLAUDE.md

グローバルなプロジェクトメモリ。ユーザーコンテキストとして注入される。

現在の構成ではワークフローは `skills/`、手順は `rules/` に定義しているため、基本的に空。

https://docs.anthropic.com/en/docs/claude-code/memory

## 設計方針

- **Skills** はスラッシュコマンドとして明示的に呼び出すワークフロー
- **Hooks** はOSレベルで強制されるため、Claudeの判断に依存しない
- **Rules** はユーザーコンテキストとして注入される。`paths` フロントマターで対象ファイルを限定できる

## ライセンス

MIT
