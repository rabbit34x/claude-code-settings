# 実装メモ: 新規ワークフローエージェント（v2.0）

## 概要
Document Reviewerから承認された設計に基づき、4つの新規ワークフローエージェント（Test Designer, Security Auditor, Dependency Auditor, Integration Tester）のエージェント定義を実装しました。

## 関連ドキュメント
- 設計書: `docs/designs/new-workflow-agents-design.md`
- 要件定義書: `docs/requirements/new-workflow-agents-requirements.md`

## 実装したファイル

### 新規作成
| ファイル | 説明 |
|---------|------|
| agents/test-designer/agent.md | Test Designer エージェント定義（891行） |
| agents/security-auditor/agent.md | Security Auditor エージェント定義（744行） |
| agents/dependency-auditor/agent.md | Dependency Auditor エージェント定義（727行） |
| agents/integration-tester/agent.md | Integration Tester エージェント定義（846行） |

### 変更
すべて新規作成のため、既存ファイルの変更はありません。

## エージェント定義の詳細

### 1. Test Designer (agents/test-designer/agent.md)

**フロントマター:**
```yaml
name: test-designer
description: Expert test designer for creating comprehensive test strategies and test cases. Use after Document Reviewer to design tests before implementation.
tools: Read, Grep, Glob
model: sonnet
permissionMode: default
```

**主要機能:**
- テスト戦略の策定（ユニット・統合・E2E）
- テストケースの設計（正常系・異常系・境界値・エッジケース）
- 受け入れテスト基準の明確化
- テストドキュメントの作成（`docs/tests/<feature-name>-test-design.md`）

**テスト設計手法:**
- 同値分割法（Equivalence Partitioning）
- 境界値分析（Boundary Value Analysis）
- デシジョンテーブル（Decision Table）
- 状態遷移テスト（State Transition Testing）

**言語/フレームワーク別ガイド:**
- JavaScript/TypeScript: Jest, Vitest, Playwright, Cypress, Supertest
- Python: pytest, unittest, Selenium, Playwright
- Go: testing, testify, httptest
- Ruby: RSpec, Minitest, Capybara

### 2. Security Auditor (agents/security-auditor/agent.md)

**フロントマター:**
```yaml
name: security-auditor
description: Expert security auditor for identifying security vulnerabilities based on OWASP Top 10. Use after Code Reviewer to perform specialized security checks before Code Verifier.
tools: Read, Grep, Glob
model: sonnet
permissionMode: default
```

**主要機能:**
- OWASP Top 10 (2021) に基づく脆弱性チェック
- 機密情報のハードコード検出（APIキー、パスワード、トークン等）
- 認証・認可ロジックの検証
- セキュリティベストプラクティスの確認

**OWASP Top 10 チェック項目:**
1. Broken Access Control（アクセス制御の不備）
2. Cryptographic Failures（暗号化の失敗）
3. Injection（インジェクション）
4. Insecure Design（安全でない設計）
5. Security Misconfiguration（セキュリティ設定ミス）
6. Vulnerable and Outdated Components（脆弱で古いコンポーネント）
7. Identification and Authentication Failures（認証の失敗）
8. Software and Data Integrity Failures（ソフトウェアとデータ整合性の失敗）
9. Security Logging and Monitoring Failures（ログとモニタリングの失敗）
10. Server-Side Request Forgery (SSRF)

**判定基準:**
- Critical脆弱性: 0件（差し戻し基準）
- High脆弱性: 0件（差し戻し基準）
- Medium/Low脆弱性: 警告として記録

### 3. Dependency Auditor (agents/dependency-auditor/agent.md)

**フロントマター:**
```yaml
name: dependency-auditor
description: Expert dependency auditor for checking package vulnerabilities and license compatibility. Use after Quality Fixer to audit dependencies before Integration Tester.
tools: Read, Grep, Glob, Bash
model: sonnet
permissionMode: default
```

**主要機能:**
- 依存パッケージの脆弱性チェック（CVE、セキュリティアドバイザリ）
- ライセンス互換性の確認
- 非推奨パッケージの検出
- 修正提案の作成

**言語/環境別監査ツール:**
- JavaScript/TypeScript: npm audit, yarn audit, pnpm audit, license-checker
- Python: pip-audit, safety, pip-licenses
- Ruby: bundler-audit, license_finder
- Go: govulncheck, go-licenses
- Rust: cargo-audit, cargo-license
- PHP: composer audit
- Java/Kotlin: OWASP Dependency-Check

**ライセンス互換性:**
- Permissive（MIT, Apache 2.0, BSD, ISC）: ほぼすべてと互換
- Copyleft（GPL, AGPL）: プロプライエタリと非互換
- Weak Copyleft（LGPL）: 条件付きで互換

**判定基準:**
- Critical脆弱性: 0件（差し戻し基準）
- High脆弱性: 0件（差し戻し基準）
- ライセンス非互換: なし（差し戻し基準）
- Moderate/Low脆弱性: 警告として記録

### 4. Integration Tester (agents/integration-tester/agent.md)

**フロントマター:**
```yaml
name: integration-tester
description: Expert integration tester for executing E2E tests and API integration tests. Use after Dependency Auditor to verify system integration before user validation.
tools: Read, Grep, Glob, Bash
model: sonnet
permissionMode: default
```

**主要機能:**
- E2Eテストの実行（ブラウザベース、ユーザーシナリオ検証）
- API統合テストの実行（RESTful API、リクエスト/レスポンス検証）
- システム統合テストの実行（DB統合、外部サービス統合）
- テスト結果の詳細報告（ログ、スクリーンショット、再現手順）

**テスト実行順序:**
1. API統合テスト（依存関係最小）
2. データベース統合テスト
3. システム統合テスト
4. E2Eテスト（全体統合）

**言語/フレームワーク別テストツール:**
- JavaScript/TypeScript: Jest, Vitest, Playwright, Cypress, Supertest
- Python: pytest, Selenium, Playwright Python, Django Test, Flask Test
- Go: go test (integration tag)
- Ruby: RSpec, Rails System Test
- Rust: cargo test

**判定基準:**
- すべてのAPI統合テストがパス
- すべてのデータベース統合テストがパス
- すべてのE2Eテストがパス
- タイムアウトや不安定なテストがない

**注意**: ユニットテストは実行しない（ユーザー検証フェーズで実行）

## 設計からの変更点

設計通りに実装しました。変更点はありません。

## 既知の制限事項

なし

## テスト情報

### テスト対象
エージェント定義ファイルの形式と内容の妥当性を確認しました。

### 確認項目
- [x] フロントマターの形式（YAML front matter）
- [x] 必須フィールド（name, description, tools, model, permissionMode）
- [x] 日本語ドキュメントの充実度
- [x] 実行プロセスの明確さ
- [x] 成果物テンプレートの提供
- [x] 判断基準の明確化
- [x] 次のステップへの条件の定義

### 検証コマンド
```bash
# エージェント定義ファイルの存在確認
ls -la agents/test-designer/agent.md
ls -la agents/security-auditor/agent.md
ls -la agents/dependency-auditor/agent.md
ls -la agents/integration-tester/agent.md

# フロントマターの確認
head -n 7 agents/test-designer/agent.md
head -n 7 agents/security-auditor/agent.md
head -n 7 agents/dependency-auditor/agent.md
head -n 7 agents/integration-tester/agent.md
```

## 実装メトリクス

| エージェント | 行数 | セクション数 | テンプレート提供 |
|------------|------|-------------|----------------|
| Test Designer | 891 | 12 | テスト設計書 |
| Security Auditor | 744 | 11 | セキュリティ監査レポート |
| Dependency Auditor | 727 | 10 | 依存関係監査レポート |
| Integration Tester | 846 | 11 | 統合テスト結果レポート |
| **合計** | **3,208** | **44** | **4ドキュメント** |

## 今後の改善点（Optional）

- 各エージェントの実践的な使用例の追加（将来的に）
- エージェント間の連携フローの図解（WORKFLOW.mdに追加済み）
- トラブルシューティングセクションの拡充（使用実績に基づく）

---
実装日: 2026-02-03
実装者: Implement Agent
