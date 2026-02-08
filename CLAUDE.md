# Claude Code グローバル設定

## 開発ワークフロー

開発タスクを受けた場合は、Agent Teams機能を使って以下のワークフローを実行すること。

### フロー概要

```
git-init → project-manager → technical-designer → document-reviewer → test-designer
→ implement → [code-reviewer + security-auditor + code-verifier (並列)]
→ quality-fixer → dependency-auditor → integration-tester → ユーザー検証 → git-finish
```

### チーム構成

チームリーダーはメインのClaude Code（ユーザーとの対話を担当）。
各ステップのエージェントは `Task` ツールで `team_name` 付きで起動するチームメンバーとして動作する。

#### 起動手順

1. **TeamCreate** でチームを作成する（チーム名: タスクの要約をkebab-caseで）
2. **TaskCreate** で全ステップをタスクとして登録する（`addBlockedBy` で依存関係を定義）
3. **Task** ツールで各エージェントを `team_name` + `model` 付きで起動する
4. 各エージェントは完了時に **TaskUpdate** でタスクを `completed` にする
5. チームリーダーは **TaskList** で進捗を確認し、次のタスクを起動する

### モデル使い分け

| モデル | 用途 | 対象ステップ |
|-------|------|-------------|
| **opus** | 設計・思考・レビュー | PM, TD, DR, TestD, CR, SA, CV |
| **sonnet** | コーディング・実行系 | git-init, Impl, QF, DA, IT, git-finish |

### ステップ一覧と依存関係

| # | 名前 | subagent_type | model | 実行方式 | 備考 |
|---|------|--------------|-------|---------|------|
| 1 | Git開始 | `git-init` | sonnet | 順次 | ブランチ作成 |
| 2 | PM | `project-manager` | opus | 順次 | 要件整理・タスク分解 |
| 3 | TD | `technical-designer` | opus | 順次 | PMの出力を入力として設計 |
| 4 | DR | `document-reviewer` | opus | 順次 | TDの設計をレビュー。却下→TDへ戻る |
| 5 | TestD | `test-designer` | opus | 順次 | 承認済み設計からテスト戦略を作成 |
| 6 | Impl | `implement` | sonnet | 順次 | 設計+テスト戦略に基づいて実装 |
| 7 | CR | `code-reviewer` | opus | **並列** | 実装後、CR/SA/CVを同時起動 |
| 8 | SA | `security-auditor` | opus | **並列** | CR と同時に実行 |
| 9 | CV | `code-verifier` | opus | **並列** | CR と同時に実行 |
| 10 | QF | `quality-fixer` | sonnet | 順次 | CR/SA/CV全通過後に実行 |
| 11 | DA | `dependency-auditor` | sonnet | 順次 | QF完了後に実行 |
| 12 | IT | `integration-tester` | sonnet | 順次 | DA完了後に実行 |
| 13 | 検証 | — | — | 手動 | ユーザーに結果を報告し確認を待つ |
| 14 | Git完了 | `git-finish` | sonnet | 順次 | PR作成・クリーンアップ |

### タスク登録テンプレート

TaskCreate で以下の順にタスクを登録する。依存関係は `addBlockedBy` で設定する。

```
タスク1:  git-init       — 依存なし
タスク2:  PM             — blockedBy: [1]
タスク3:  TD             — blockedBy: [2]
タスク4:  DR             — blockedBy: [3]
タスク5:  TestD          — blockedBy: [4]
タスク6:  Impl           — blockedBy: [5]
タスク7:  CR             — blockedBy: [6]
タスク8:  SA             — blockedBy: [6]
タスク9:  CV             — blockedBy: [6]
タスク10: QF             — blockedBy: [7, 8, 9]
タスク11: DA             — blockedBy: [10]
タスク12: IT             — blockedBy: [11]
タスク13: ユーザー検証    — blockedBy: [12]
タスク14: git-finish     — blockedBy: [13]
```

### 実行ルール

#### エージェント起動パターン
```
Task(
  subagent_type="project-manager",
  model="opus",
  team_name="<チーム名>",
  prompt="ユーザーの要求: ..."
)
```

- 各エージェント起動時に必ず `team_name` と `model` を指定する
- エージェントは完了時に `TaskUpdate` でタスクを `completed` にする
- チームリーダーは `TaskList` で進捗を確認し、blockedBy が解消されたタスクから起動する

#### 並列実行パターン（CR + SA + CV）
```
Implの完了後、以下の3つを1つのメッセージで同時に Task ツールで起動する:
- Task(subagent_type="code-reviewer", model="opus", team_name="<チーム名>", ...)
- Task(subagent_type="security-auditor", model="opus", team_name="<チーム名>", ...)
- Task(subagent_type="code-verifier", model="opus", team_name="<チーム名>", ...)
3つ全ての結果を待ってから次のステップへ進む。
```

### フィードバックループ

レビューステップで問題が見つかった場合、**TaskCreate で修正タスクを新規作成**して再実行する。

戻り先:
- **DR（却下）** → TD（technical-designer）を再実行
- **CR（問題あり）** → Impl（implement）を再実行
- **SA（脆弱性あり）** → Impl（implement）を再実行
- **CV（齟齬あり）** → Impl（implement）を再実行
- **DA（問題あり）** → Impl（implement）を再実行
- **IT（失敗）** → Impl（implement）を再実行

再実行時は、レビューで指摘された問題点を prompt に含めること。
修正タスクには元のタスクへの参照と指摘内容を description に記載する。

### コンテキストの受け渡し

各エージェントの `prompt` には以下を含めること:
1. **ユーザーの元の要求** — 最初のタスク内容
2. **前ステップの出力** — 直前のエージェントの結果（要約でもよい）
3. **関連ファイルパス** — 対象のソースコードやドキュメントのパス
4. **プロジェクトのコンテキスト** — 必要に応じてREADMEやpackage.jsonの情報

### チームの終了

全タスク完了後:
1. 起動中の各エージェントに `SendMessage(type: "shutdown_request")` を送信
2. 全エージェントのシャットダウンを確認
3. **TeamDelete** でチームとタスクリストを削除

### 重要なルール

- **開発タスクには必ず TeamCreate を使用する**
- 各ステップの進捗を **TaskUpdate** で管理する
- CR/SA/CV の3ステップは同時に起動する（1つのメッセージで3つの Task を呼ぶ）
- 各ステップのサマリーをユーザーに日本語で報告すること
- IT完了後、ユーザーに検証を依頼し、承認を得てから git-finish を実行する
- 各ステップの完了時に進捗をユーザーに報告する

## 言語

ユーザーとのコミュニケーションは日本語で行うこと。
