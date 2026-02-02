#!/bin/bash

set -e

# 色の定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 設定ファイルのパス
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="${SCRIPT_DIR}/settings.json"
TARGET_DIR="${HOME}/.claude"
TARGET_FILE="${TARGET_DIR}/settings.json"

echo "Claude Code設定ファイルのセットアップを開始します..."
echo ""

# .claudeディレクトリが存在しない場合は作成
if [ ! -d "${TARGET_DIR}" ]; then
    echo -e "${YELLOW}~/.claudeディレクトリが存在しないため、作成します${NC}"
    mkdir -p "${TARGET_DIR}"
    echo -e "${GREEN}✓ ~/.claudeディレクトリを作成しました${NC}"
fi

# 既存のsettings.jsonファイルが存在する場合の処理
if [ -e "${TARGET_FILE}" ]; then
    # シンボリックリンクの場合
    if [ -L "${TARGET_FILE}" ]; then
        LINK_TARGET=$(readlink "${TARGET_FILE}")
        if [ "${LINK_TARGET}" = "${SOURCE_FILE}" ]; then
            echo -e "${GREEN}✓ すでに正しいシンボリックリンクが設定されています${NC}"
            exit 0
        else
            echo -e "${YELLOW}既存のシンボリックリンクを削除します: ${LINK_TARGET}${NC}"
            rm "${TARGET_FILE}"
        fi
    # 通常のファイルの場合
    else
        BACKUP_FILE="${TARGET_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}既存のsettings.jsonをバックアップします: ${BACKUP_FILE}${NC}"
        mv "${TARGET_FILE}" "${BACKUP_FILE}"
        echo -e "${GREEN}✓ バックアップを作成しました${NC}"
    fi
fi

# シンボリックリンクを作成
echo "シンボリックリンクを作成しています..."
ln -s "${SOURCE_FILE}" "${TARGET_FILE}"

# 確認
if [ -L "${TARGET_FILE}" ] && [ "$(readlink "${TARGET_FILE}")" = "${SOURCE_FILE}" ]; then
    echo ""
    echo -e "${GREEN}✓ セットアップが完了しました！${NC}"
    echo ""
    echo "設定内容:"
    echo "  元ファイル: ${SOURCE_FILE}"
    echo "  リンク先:   ${TARGET_FILE}"
    echo ""
    echo "設定を変更する場合は、このリポジトリのsettings.jsonを編集してください。"
else
    echo ""
    echo -e "${RED}✗ シンボリックリンクの作成に失敗しました${NC}"
    exit 1
fi
