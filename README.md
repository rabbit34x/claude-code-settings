# claude-code-settings
Claude Codeで利用するグローバル設定をまとめたリポジトリ。

## ディレクトリ構造

```
claude-code-settings/
├── .gitignore          # Git管理対象外ファイルの設定
├── README.md           # このファイル
├── setup.sh            # セットアップスクリプト（シンボリックリンク作成）
└── settings.json       # Claude Codeのグローバル設定ファイル
```

## ファイル説明

- **settings.json**: Claude Codeのグローバル設定を定義するファイル
- **setup.sh**: 設定ファイルのシンボリックリンクを自動作成するスクリプト
- **.gitignore**: OS固有のファイルやエディタの一時ファイルなどを除外
- **README.md**: リポジトリの説明とディレクトリ構造

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
   - 既存の`settings.json`がある場合はバックアップを作成
   - このリポジトリの`settings.json`へのシンボリックリンクを作成

3. 設定の確認
   ```bash
   ls -la ~/.claude/settings.json
   ```

## 設定の変更

このリポジトリの`settings.json`を編集すると、Claude Codeの設定に即座に反映されます。

```bash
# 設定ファイルを編集
vim settings.json  # または好きなエディタで編集

# 変更をコミット
git add settings.json
git commit -m "Update Claude Code settings"
git push
```
