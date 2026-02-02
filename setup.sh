#!/bin/bash

set -e

# 色の定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 設定ファイルとディレクトリのパス
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.claude"

echo "Claude Code設定のセットアップを開始します..."
echo ""

# .claudeディレクトリが存在しない場合は作成
if [ ! -d "${TARGET_DIR}" ]; then
    echo -e "${YELLOW}~/.claudeディレクトリが存在しないため、作成します${NC}"
    mkdir -p "${TARGET_DIR}"
    echo -e "${GREEN}✓ ~/.claudeディレクトリを作成しました${NC}"
    echo ""
fi

# シンボリックリンクを作成する関数
create_symlink() {
    local SOURCE="$1"
    local TARGET="$2"
    local NAME="$3"

    # ソースが存在しない場合はスキップ
    if [ ! -e "${SOURCE}" ]; then
        echo -e "${YELLOW}⊘ ${NAME} が見つかりません（スキップ）${NC}"
        return 0
    fi

    # 既存のターゲットが存在する場合の処理
    if [ -e "${TARGET}" ]; then
        # シンボリックリンクの場合
        if [ -L "${TARGET}" ]; then
            LINK_TARGET=$(readlink "${TARGET}")
            if [ "${LINK_TARGET}" = "${SOURCE}" ]; then
                echo -e "${GREEN}✓ ${NAME}: すでに正しいシンボリックリンクが設定されています${NC}"
                return 0
            else
                echo -e "${YELLOW}${NAME}: 既存のシンボリックリンクを削除します${NC}"
                rm "${TARGET}"
            fi
        # 通常のファイル/ディレクトリの場合
        else
            BACKUP="${TARGET}.backup.$(date +%Y%m%d_%H%M%S)"
            echo -e "${YELLOW}${NAME}: 既存のファイル/ディレクトリをバックアップします${NC}"
            mv "${TARGET}" "${BACKUP}"
            echo -e "${GREEN}✓ バックアップを作成しました: ${BACKUP}${NC}"
        fi
    fi

    # シンボリックリンクを作成
    ln -s "${SOURCE}" "${TARGET}"

    # 確認
    if [ -L "${TARGET}" ] && [ "$(readlink "${TARGET}")" = "${SOURCE}" ]; then
        echo -e "${GREEN}✓ ${NAME}: シンボリックリンクを作成しました${NC}"
        return 0
    else
        echo -e "${RED}✗ ${NAME}: シンボリックリンクの作成に失敗しました${NC}"
        return 1
    fi
}

# セットアップ対象のリスト
echo "シンボリックリンクを作成しています..."
echo ""

# settings.json
create_symlink "${SCRIPT_DIR}/settings.json" "${TARGET_DIR}/settings.json" "settings.json"

# agents/
create_symlink "${SCRIPT_DIR}/agents" "${TARGET_DIR}/agents" "agents/"

# skills/
create_symlink "${SCRIPT_DIR}/skills" "${TARGET_DIR}/skills" "skills/"

# commands/
create_symlink "${SCRIPT_DIR}/commands" "${TARGET_DIR}/commands" "commands/"

# hooks/
create_symlink "${SCRIPT_DIR}/hooks" "${TARGET_DIR}/hooks" "hooks/"

# 完了メッセージ
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ セットアップが完了しました！${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "設定内容:"
echo "  リポジトリ: ${SCRIPT_DIR}"
echo "  リンク先:   ${TARGET_DIR}"
echo ""
echo "作成されたシンボリックリンク:"
echo "  - settings.json"
echo "  - agents/"
echo "  - skills/"
echo "  - commands/"
echo "  - hooks/"
echo ""
echo "設定を変更する場合は、このリポジトリ内のファイルを編集してください。"
