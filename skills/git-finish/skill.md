# Git Finish

タスク完了時のPR作成およびマージ後のクリーンアップを行うスキル。

## 動作モード

### モード1: PR作成（PRがまだ存在しない場合）
1. 現在のブランチでPRを作成
2. PR URLを表示

### モード2: クリーンアップ（PRがマージ済みの場合）
1. mainブランチに切り替え
2. 最新の変更をプル
3. マージ済みの作業ブランチを削除

## 使用方法

```
/git-finish              # PR作成またはクリーンアップを自動判定
/git-finish --pr         # PR作成のみ
/git-finish --cleanup    # クリーンアップのみ
```

## フロー

```
タスク完了
    ↓
/git-finish
    ↓
┌─ PRが存在しない → PR作成 → URL表示 → 終了
│
├─ PRが存在＆未マージ → 「PRがマージされるのを待っています」と報告
│
└─ PRがマージ済み → クリーンアップ実行
    ├─ git checkout main
    ├─ git pull origin main
    └─ git branch -d <branch-name>
```

---

<command-name>git-finish</command-name>

<prompt>
タスク完了時のGitワークフローを自動化します。現在のブランチ状態とPR状態を確認して、適切な処理を実行します。

## 手順

### 1. 状態確認
```bash
# 現在のブランチを取得
git branch --show-current

# mainブランチでないことを確認（mainなら何もしない）
# PRの状態を確認
gh pr status
```

### 2. 状態に応じた処理

#### PRが存在しない場合 → PR作成
1. 未コミットの変更がある場合は警告
2. リモートにプッシュ: `git push -u origin <current-branch>`
3. PRを作成:
```bash
gh pr create --title "<ブランチ名から推測したタイトル>" --body "$(cat <<'EOF'
## Summary
- 変更内容の要約

## Test plan
- [ ] テスト項目

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```
4. PR URLを表示して終了

#### PRが存在するがマージされていない場合
- 「PRがマージされるのを待っています。マージ後に再度 /git-finish を実行してください」と報告
- PR URLを表示

#### PRがマージ済みの場合 → クリーンアップ
1. mainブランチに切り替え: `git checkout main`
2. 最新を取得: `git pull origin main`
3. 作業ブランチを削除: `git branch -d <branch-name>`
4. リモートブランチも削除されているか確認
5. 完了メッセージを表示

## オプション引数

- `--pr`: PR作成のみを実行（クリーンアップをスキップ）
- `--cleanup`: クリーンアップのみを実行（PRは作成しない）

## 注意事項

- mainブランチにいる場合は「作業ブランチではありません」と警告
- マージされていないブランチは `-d` で削除（強制削除は避ける）
- 削除に失敗した場合はユーザーに確認を求める
</prompt>
