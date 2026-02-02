# claude-code-settings
Claude Codeで利用するグローバル設定をまとめたリポジトリ。

## ディレクトリ構造

```
claude-code-settings/
├── .gitignore          # Git管理対象外ファイルの設定
├── README.md           # このファイル
├── WORKFLOW.md         # 開発ワークフローのドキュメント
├── setup.sh            # セットアップスクリプト（シンボリックリンク作成）
├── settings.json       # Claude Codeのグローバル設定ファイル
├── agents/             # カスタムエージェント定義
│   └── project-manager/    # プロジェクトマネージャーエージェント
│       └── agent.md
├── commands/           # カスタムコマンド（予約）
├── hooks/              # ライフサイクルフック（予約）
└── skills/             # カスタムスキル定義
```

## ファイル説明

- **settings.json**: Claude Codeのグローバル設定を定義するファイル
- **setup.sh**: 設定ファイルのシンボリックリンクを自動作成するスクリプト
- **.gitignore**: OS固有のファイルやエディタの一時ファイルなどを除外
- **README.md**: リポジトリの説明とディレクトリ構造
- **WORKFLOW.md**: 開発ワークフローの詳細ドキュメント
- **agents/**: カスタムエージェント定義ディレクトリ
- **commands/**: カスタムコマンド定義ディレクトリ（将来使用予定）
- **hooks/**: ライフサイクルフック定義ディレクトリ（将来使用予定）
- **skills/**: カスタムスキル定義ディレクトリ

## 開発ワークフロー

このリポジトリは、Claude Codeを使った開発のための標準ワークフローを定義しています。詳細は [WORKFLOW.md](WORKFLOW.md) を参照してください。

### ワークフローの概要

```
User Request → Project Manager → Technical Designer → Document Reviewer
→ Implement → Code Reviewer → Code Verifier → Quality Fixer
→ ユーザー（ビルド・テスト実行） → Ready to Commit
```

### 実装済みエージェント

#### 1. Project Manager (`agents/project-manager/`)

**責務:**
- ユーザーリクエストの理解と整理
- タスクへの分解
- 優先順位の決定
- 実装スコープの明確化

**成果物:**
- タスクリスト
- 要件定義書
- 受け入れ基準

**使用ツール:** Read, Grep, Glob, AskUserQuestion, TodoWrite

詳細は [agents/project-manager/agent.md](agents/project-manager/agent.md) を参照してください。

### 今後実装予定のエージェント

- **Technical Designer**: 技術設計とアーキテクチャ決定
- **Document Reviewer**: 設計ドキュメントのレビュー
- **Implement**: コード実装
- **Code Reviewer**: コードの正しさ検証
- **Code Verifier**: ドキュメントとコードの整合性確認
- **Quality Fixer**: 静的解析とフォーマット

## セットアップ

1. このリポジトリをクローン
   ```bash
   git clone <repository-url>
   cd claude-code-settings
   ```

2. セットアップスクリプトを実行
   ```bash
   ./setup.sh
   ```

   スクリプトは以下の処理を自動で行います：
   - `~/.claude`ディレクトリが存在しない場合は作成
   - 既存のファイル/ディレクトリがある場合はバックアップを作成
   - 以下のシンボリックリンクを作成：
     - `settings.json` → `~/.claude/settings.json`
     - `agents/` → `~/.claude/agents/`
     - `skills/` → `~/.claude/skills/`
     - `commands/` → `~/.claude/commands/`
     - `hooks/` → `~/.claude/hooks/`

3. 設定の確認
   ```bash
   ls -la ~/.claude/
   ```

## 設定の変更

このリポジトリ内のファイルを編集すると、Claude Codeの設定に即座に反映されます（シンボリックリンク経由）。

```bash
# 設定ファイルを編集
vim settings.json

# エージェントを編集
vim agents/project-manager/agent.md

# 新しいスキルを追加
mkdir -p skills/my-skill
vim skills/my-skill/SKILL.md

# 変更をコミット
git add .
git commit -m "Update Claude Code settings"
git push
```

### エージェントのテスト

エージェントを変更した後、Claude Codeセッション内で以下を実行して確認：

```bash
# エージェント一覧を表示
/agents

# エージェントを呼び出し（自動委譲）
"プロジェクト管理タスクを実行してください"

# エージェントを呼び出し（明示的指定）
"Use the project-manager agent to analyze the requirements"
```
