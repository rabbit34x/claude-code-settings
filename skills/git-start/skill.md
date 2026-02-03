# Git Start

新しいタスクを開始するためのGitブランチセットアップスキル。

## 動作

1. 現在のブランチ状態を確認
2. 未コミットの変更がある場合は警告
3. mainブランチに切り替え
4. 最新の変更をプル
5. 新しい開発ブランチを作成

## 使用方法

```
/git-start feature/新機能名
/git-start fix/バグ修正名
```

## 実行内容

```bash
# 1. 現在の状態を確認
git status

# 2. mainブランチに切り替え
git checkout main

# 3. 最新を取得
git pull origin main

# 4. 新しいブランチを作成して切り替え
git checkout -b <branch-name>
```

---

<command-name>git-start</command-name>

<prompt>
ユーザーが新しいタスクを開始するためのGitブランチをセットアップします。

## 手順

1. まず `git status` で現在の状態を確認
2. 未コミットの変更がある場合は、ユーザーに警告してスタッシュするか確認
3. mainブランチに切り替え: `git checkout main`
4. 最新を取得: `git pull origin main`
5. 引数で指定されたブランチ名で新しいブランチを作成: `git checkout -b <branch-name>`

## 注意

- ブランチ名が指定されていない場合は、ユーザーにブランチ名を尋ねる
- ブランチ名の推奨形式: `feature/機能名`, `fix/バグ名`, `refactor/対象名`
- 同名のブランチが既に存在する場合はエラーを報告
</prompt>
