#!/bin/bash
# -*- coding: utf-8 -*-
# build-cf-pages.sh - 构建 cf-pages 发布产物
#
# 将 _worker.js、wrangler.toml 拷贝到 dist/ 目录，
# 并将 wrangler.toml 中的 name 改为 cf-usage-panel。
# 不修改 _worker.js 内容。
#
# 用法: bash scripts/build-cf-pages.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
DIST_DIR="${ROOT}/dist"

# ---------------------------------------------------------------------------
# 1. 准备 dist 目录
# ---------------------------------------------------------------------------

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

# ---------------------------------------------------------------------------
# 2. 拷贝核心文件
# ---------------------------------------------------------------------------

cp "${ROOT}/_worker.js" "${DIST_DIR}/_worker.js"
echo "Copied: _worker.js"

cp "${ROOT}/wrangler.toml" "${DIST_DIR}/wrangler.toml"
echo "Copied: wrangler.toml"

# ---------------------------------------------------------------------------
# 3. 修改 wrangler.toml 中的 Worker name
# ---------------------------------------------------------------------------

sed 's/^name = "usage-panel"/name = "cf-usage-panel"/' "${DIST_DIR}/wrangler.toml" > "${DIST_DIR}/wrangler.toml.tmp" \
    && mv "${DIST_DIR}/wrangler.toml.tmp" "${DIST_DIR}/wrangler.toml"
echo "Renamed: usage-panel → cf-usage-panel (in wrangler.toml)"

# ---------------------------------------------------------------------------
# 4. 输出摘要
# ---------------------------------------------------------------------------

BUILD_VERSION="${BUILD_VERSION:-2026-07-19 07:19:00}"

echo ""
echo "Build complete → dist/"
echo "  Version: ${BUILD_VERSION}"

DIST_FILES=$(ls "$DIST_DIR" | tr '\n' ' ')
echo "  Files: ${DIST_FILES}"
