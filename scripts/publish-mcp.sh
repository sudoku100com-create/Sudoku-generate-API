#!/bin/bash
set -e

# ============================================================
# Sudoku100 MCP/Skill 一键发布脚本
# 用法:
#   ./scripts/publish-mcp.sh              # 首次发布（逐平台引导）
#   ./scripts/publish-mcp.sh --update     # 更新模式（跳过一次性的平台）
#   ./scripts/publish-mcp.sh --status     # 查看发布状态
#   ./scripts/publish-mcp.sh --open-all   # 打开所有平台提交页面
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

# ===== 配置 =====
GITHUB_REPO="sudoku100com-create/Sudoku-generate-API"
GITHUB_URL="https://github.com/${GITHUB_REPO}"
NPM_PACKAGE="sudoku-api-mcp"
VERSION=$(node -e "console.log(require('./package.json').version)" 2>/dev/null || echo "1.0.0")
SITE_URL="https://www.sudoku100.com"

# ===== 颜色 =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

BANNER="
${CYAN}╔══════════════════════════════════════════════════╗
║       🎯 Sudoku100 MCP/Skill 一键发布工具        ║
║              v${VERSION}  |  ${GITHUB_REPO}  ║
╚══════════════════════════════════════════════════╝${NC}
"

# ===== 平台 URL（bash 3.2 兼容，用函数代替关联数组）=====
platform_url() {
  case "$1" in
    mcp_registry)  echo "https://registry.modelcontextprotocol.io" ;;
    mcp_directory) echo "https://mcp.directory/submit" ;;
    smithery)      echo "https://smithery.ai" ;;
    glama)         echo "https://glama.ai/mcp/servers" ;;
    mcp_so)        echo "https://mcp.so" ;;
    mcp_market)    echo "https://mcpmarket.com/submit" ;;
    mcpservers)    echo "https://mcpservers.org/submit" ;;
    awesome_mcp)   echo "https://github.com/punkpeye/awesome-mcp-servers" ;;
    npm)           echo "https://www.npmjs.com/package/${NPM_PACKAGE}" ;;
    github)        echo "${GITHUB_URL}" ;;
  esac
}

platform_keys="mcp_directory mcp_market mcpservers glama mcp_registry smithery mcp_so awesome_mcp npm github"

# ===== 辅助函数 =====
print_banner() { echo "$BANNER"; }

print_ok()   { echo -e "  ${GREEN}✅ $1${NC}"; }
print_info() { echo -e "  ${BLUE}ℹ️  $1${NC}"; }
print_warn() { echo -e "  ${YELLOW}⚠️  $1${NC}"; }
print_error(){ echo -e "  ${RED}❌ $1${NC}"; }
print_step() { echo -e "\n${BOLD}${CYAN}▸ $1${NC}"; }

open_url() {
  local url="$1"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$url"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$url" 2>/dev/null || echo "  请手动打开: $url"
  else
    echo "  请手动打开: $url"
  fi
}

confirm() {
  local prompt="$1"
  local default="${2:-y}"
  read -p "  ${prompt} [Y/n] " -r answer
  answer=${answer:-$default}
  [[ "$answer" =~ ^[Yy]$ ]]
}

wait_for() {
  local prompt="$1"
  echo -e "\n  ${YELLOW}⏳ $prompt${NC}"
  read -p "  完成后按 Enter 继续..."
}

# ===== 检查前置条件 =====
check_prerequisites() {
  print_step "1. 检查前置条件"

  if command -v git &>/dev/null; then
    print_ok "Git 可用"
  else
    print_error "需要安装 Git"
    exit 1
  fi

  if command -v node &>/dev/null; then
    print_ok "Node.js $(node -v)"
  else
    print_error "需要安装 Node.js >= 16"
    exit 1
  fi

  if command -v npm &>/dev/null; then
    print_ok "npm $(npm -v)"
  else
    print_error "需要安装 npm"
    exit 1
  fi

  for f in package.json server.json mcp/sudoku-api-mcp.js skill/sudoku-api-skill.js README.md; do
    if [ -f "$f" ]; then
      print_ok "文件 $f 存在"
    else
      print_error "缺少文件: $f"
      exit 1
    fi
  done

  print_ok "所有前置条件通过"
}

# ===== 自动同步版本号 =====
sync_version() {
  print_step "2. 同步版本号 (v${VERSION})"

  # 更新 server.json
  if [ -f server.json ]; then
    node -e "
      const fs = require('fs');
      const data = JSON.parse(fs.readFileSync('server.json', 'utf8'));
      data.version = '${VERSION}';
      fs.writeFileSync('server.json', JSON.stringify(data, null, 2) + '\n');
    "
    print_ok "server.json 版本已同步"
  fi

  # 更新 mcp JS
  if [ -f mcp/sudoku-api-mcp.js ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' "s/version: \"[0-9.]*\"/version: \"${VERSION}\"/" mcp/sudoku-api-mcp.js
    else
      sed -i "s/version: \"[0-9.]*\"/version: \"${VERSION}\"/" mcp/sudoku-api-mcp.js
    fi
    print_ok "mcp/sudoku-api-mcp.js 版本已同步"
  fi

  # 更新 skill JS
  if [ -f skill/sudoku-api-skill.js ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' "s/version: \"[0-9.]*\"/version: \"${VERSION}\"/" skill/sudoku-api-skill.js
    else
      sed -i "s/version: \"[0-9.]*\"/version: \"${VERSION}\"/" skill/sudoku-api-skill.js
    fi
    print_ok "skill/sudoku-api-skill.js 版本已同步"
  fi
}

# ===== 生成提交内容 =====
generate_submission_content() {
  cat << SUBMISSION_END

🎯 Sudoku100 MCP - 无需注册的公共数独谜题生成服务

## 📦 基本信息
- **名称**: sudoku-api-mcp
- **版本**: v${VERSION}
- **GitHub**: https://github.com/sudoku100com-create/Sudoku-generate-API
- **官网**: https://www.sudoku100.com
- **许可证**: MIT
- **npm**: https://www.npmjs.com/package/sudoku-api-mcp

## 🔧 提供的工具
1. **generate_sudoku** - 生成指定难度的数独谜题（6级难度）
2. **get_sudoku_by_id** - 按 ID 获取特定数独谜题
3. **list_difficulties** - 列出所有可用难度级别

## ✨ 核心特色
- 🔥 无需注册，无需 API Key
- 🎯 先进的回溯算法，唯一解保证
- 🎨 支持 PNG/WebP/SVG/JPG 4种格式
- 📐 自定义尺寸 100-1000px
- 🌐 支持 40+ 语言文档
- ⚡ 在线实时生成，快速响应

## 🚀 安装方式
npm install sudoku-api-mcp

Claude Desktop 配置:
{
  "mcpServers": {
    "sudoku-api": {
      "command": "npx",
      "args": ["-y", "sudoku-api-mcp"]
    }
  }
}

## 🎮 使用示例
"帮我生成一个中等难度的数独" → 调用 generate_sudoku
"获取238号谜题"            → 调用 get_sudoku_by_id
"生成800px宽的SVG数独"     → 调用 generate_sudoku(自定义参数)

📍 分类: AI 工具 / 游戏 / 教育
SUBMISSION_END
}

# ===== GitHub 操作 =====
github_push() {
  print_step "GitHub 推送"

  git add scripts/ package.json server.json .npmignore 2>/dev/null || true
  git add mcp/sudoku-api-mcp.js skill/sudoku-api-skill.js 2>/dev/null || true

  if git diff --cached --quiet 2>/dev/null; then
    print_info "没有需要提交的更改"
    return
  fi

  echo "  待提交的文件:"
  git diff --cached --name-only | while read f; do echo "    - $f"; done

  if confirm "是否提交并推送这些更改？"; then
    read -p "  提交信息: " -r msg
    git commit -m "${msg:-chore: MCP/Skill 发布更新 v${VERSION}}"
    git push origin main
    print_ok "已推送到 GitHub"
  fi
}

# ===== npm 发布 =====
npm_publish() {
  print_step "npm 发布"

  if npm whoami &>/dev/null; then
    print_ok "npm 已登录"
  else
    print_warn "未登录 npm，请先运行: npm login"
    if ! confirm "是否现在登录 npm？"; then
      print_info "跳过 npm 发布"
      return
    fi
    npm login
  fi

  if npm publish --access public 2>&1; then
    print_ok "npm 发布成功: https://www.npmjs.com/package/${NPM_PACKAGE}"
  else
    print_error "npm 发布失败，请检查版本号是否已存在"
  fi
}

# ===== 平台提交引导 =====
submit_platforms() {
  print_step "3. 平台提交引导"
  echo ""
  echo -e "  ${BOLD}将依次引导你提交到以下 ${CYAN}9${NC}${BOLD} 个平台:${NC}"
  echo ""
  echo -e "  ${CYAN}快速通道 (仅需 GitHub 仓库 URL):${NC}"
  echo "    1. MCP.Directory    → $(platform_url mcp_directory)"
  echo "    2. MCP Market        → $(platform_url mcp_market)"
  echo "    3. MCPServers.org    → $(platform_url mcpservers)"
  echo "    4. Glama             → $(platform_url glama)"
  echo ""
  echo -e "  ${CYAN}需要 CLI 工具:${NC}"
  echo "    5. Official Registry → $(platform_url mcp_registry) (需 mcp-publisher)"
  echo "    6. Smithery          → $(platform_url smithery) (需远程 MCP 端点)"
  echo ""
  echo -e "  ${CYAN}需要提交 Issue/PR:${NC}"
  echo "    7. mcp.so            → $(platform_url mcp_so) (提交 Issue)"
  echo "    8. Awesome MCP       → $(platform_url awesome_mcp) (提交 PR)"
  echo ""
  echo -e "  ${CYAN}包发布:${NC}"
  echo "    9. npm               → $(platform_url npm)"
  echo ""

  if ! confirm "是否开始逐平台提交？"; then
    print_info "已取消"
    return
  fi

  # ---- 快速通道 ----
  print_step "快速通道: MCP.Directory / MCP Market / MCPServers.org / Glama"

  echo -e "\n  ${BOLD}以下平台只需粘贴 GitHub 仓库 URL:${NC}"
  echo -e "  ${GREEN}${GITHUB_URL}${NC}"
  echo ""

  local quick_platforms="mcp_directory mcp_market mcpservers glama"
  for key in $quick_platforms; do
    echo -e "  ${YELLOW}▸ 打开 $key${NC}"
    open_url "$(platform_url "$key")"
    echo "     在页面中粘贴仓库 URL 即可"
    wait_for "$key 提交完成"
  done

  # ---- Official Registry ----
  print_step "Official MCP Registry (官方 Registry)"

  echo ""
  echo -e "  ${BOLD}前置要求:${NC} 安装 mcp-publisher CLI"
  echo -e "  ${BLUE}  npm install -g @modelcontextprotocol/mcp-publisher${NC}"
  echo ""
  echo -e "  ${BOLD}发布命令:${NC}"
  echo -e "  ${BLUE}  cd ${PROJECT_DIR}${NC}"
  echo -e "  ${BLUE}  mcp-publisher login github${NC}"
  echo -e "  ${BLUE}  mcp-publisher publish${NC}"
  echo ""

  if confirm "是否已安装 mcp-publisher？打开官方 Registry 页面"; then
    open_url "$(platform_url mcp_registry)"
  fi
  wait_for "Official Registry 提交完成"

  # ---- Smithery ----
  print_step "Smithery (远程 MCP 服务器)"

  echo ""
  echo -e "  ${YELLOW}⚠️  Smithery 需要已部署的远程 MCP 服务器端点${NC}"
  echo -e "  ${BLUE}  smithery mcp publish \"https://your-server.com/mcp\"${NC}"
  echo ""
  echo -e "  如果 MCP 是本地运行的，可以跳过此平台"
  echo ""

  if confirm "是否打开 Smithery？"; then
    open_url "$(platform_url smithery)"
  fi
  wait_for "Smithery 提交完成"

  # ---- mcp.so (GitHub Issue) ----
  print_step "mcp.so (需要创建 GitHub Issue)"

  local issue_title="[Submit] Sudoku100 MCP - Public Sudoku Puzzle Generator"
  local issue_body=$(generate_submission_content | python3 -c "
import sys, urllib.parse
print(urllib.parse.quote(sys.stdin.read()))
")
  local issue_url="https://github.com/mcp-so/mcp.so/issues/new?title=$(python3 -c "import sys,urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$issue_title")&body=${issue_body}"

  echo ""
  echo -e "  ${BOLD}Issue 内容已生成，将打开 GitHub Issue 页面${NC}"
  open_url "$issue_url"
  echo -e "  ${YELLOW}请确认 title 和 body 已正确填充后提交${NC}"
  wait_for "mcp.so Issue 提交完成"

  # ---- Awesome MCP Servers (PR) ----
  print_step "Awesome MCP Servers (需要 Fork + PR)"

  local awesome_entry="- [Sudoku100 MCP](${GITHUB_URL}) - 无需注册的公共数独谜题生成服务，支持6级难度和4种图片格式"
  echo ""
  echo -e "  ${BOLD}操作步骤:${NC}"
  echo -e "  1. Fork 仓库: https://github.com/punkpeye/awesome-mcp-servers/fork"
  echo -e "  2. 在 README.md 的合适分类下添加:"
  echo -e "     ${GREEN}${awesome_entry}${NC}"
  echo -e "  3. 提交 Pull Request"
  echo ""

  open_url "$(platform_url awesome_mcp)"
  echo "$awesome_entry" | pbcopy 2>/dev/null || true
  echo -e "  ${BLUE}已尝试复制条目到剪贴板${NC}"
  wait_for "Awesome MCP PR 提交完成"

  # ---- npm ----
  print_step "npm 发布"
  npm_publish
}

# ===== 更新模式 =====
update_mode() {
  print_banner
  check_prerequisites
  sync_version
  github_push

  print_step "更新模式：推送到 GitHub + npm"

  if confirm "是否同时发布到 npm？"; then
    npm_publish
  fi

  echo ""
  print_ok "更新完成！各平台会自动同步 GitHub 仓库的最新版本"
}

# ===== 状态检查 =====
check_status() {
  print_banner
  echo ""
  echo -e "  ${BOLD}📊 Sudoku100 MCP 发布状态${NC}"
  echo ""
  echo -e "  ${CYAN}版本:${NC} v${VERSION}"
  echo -e "  ${CYAN}GitHub:${NC} ${GITHUB_URL}"
  echo ""

  echo -e "  ${BOLD}配置文件:${NC}"
  for f in package.json server.json mcp/sudoku-api-mcp.js skill/sudoku-api-skill.js; do
    if [ -f "$f" ]; then
      echo -e "    ✅ $f"
    else
      echo -e "    ❌ $f 不存在"
    fi
  done

  echo ""
  echo -e "  ${BOLD}Git 状态:${NC}"
  if [ -d .git ]; then
    git status --short 2>/dev/null || echo "    Git 状态获取失败"
  else
    echo "    未初始化 Git"
  fi

  echo ""
  echo -e "  ${BOLD}npm:${NC}"
  if npm whoami &>/dev/null 2>&1; then
    echo -e "    ✅ 已登录: $(npm whoami)"
  else
    echo -e "    ⚠️  未登录 npm"
  fi

  echo ""
  echo -e "  ${BOLD}平台 URL:${NC}"
  for key in $platform_keys; do
    echo -e "    🔗 ${key}: $(platform_url "$key")"
  done
}

# ===== 打开所有平台 =====
open_all_platforms() {
  print_step "打开所有平台提交页面"
  for key in $platform_keys; do
    echo -e "  ▸ ${key}"
    open_url "$(platform_url "$key")"
  done
  echo ""
  print_ok "已打开所有平台页面"
}

# ===== 完整发布流程 =====
full_publish() {
  print_banner
  check_prerequisites
  sync_version

  echo ""
  echo -e "  ${BOLD}📋 发布清单预览:${NC}"
  echo ""
  echo -e "  ${GREEN}自动化:${NC}"
  echo "    ✅ 版本号同步"
  echo "    ✅ Git 推送到 GitHub"
  echo ""
  echo -e "  ${YELLOW}半自动 (打开浏览器 + 粘贴仓库 URL):${NC}"
  echo "    🔗 MCP.Directory"
  echo "    🔗 MCP Market"
  echo "    🔗 MCPServers.org"
  echo "    🔗 Glama"
  echo ""
  echo -e "  ${YELLOW}需要手动操作:${NC}"
  echo "    📝 mcp.so (GitHub Issue)"
  echo "    🔀 Awesome MCP Servers (Fork + PR)"
  echo "    📦 npm publish"
  echo ""

  if ! confirm "是否开始发布？"; then
    print_info "已取消"
    exit 0
  fi

  github_push
  submit_platforms

  echo ""
  echo -e "${GREEN}╔══════════════════════════════════════════════════╗"
  echo -e "║  🎉 全部发布流程已完成！                        ║"
  echo -e "║                                                  ║"
  echo -e "║  下次更新只需运行:                               ║"
  echo -e "║  ${CYAN}./scripts/publish-mcp.sh --update${GREEN}                  ║"
  echo -e "╚══════════════════════════════════════════════════╝${NC}"
  echo ""
}

# ===== 主入口 =====
case "${1:-}" in
  --update)
    update_mode
    ;;
  --status)
    check_status
    ;;
  --open-all)
    check_prerequisites
    sync_version
    open_all_platforms
    ;;
  --help|-h)
    print_banner
    echo "用法: ./scripts/publish-mcp.sh [选项]"
    echo ""
    echo "选项:"
    echo "  无参数       完整发布流程（首次发布，逐平台引导）"
    echo "  --update     更新模式（推送 GitHub + npm，平台自动同步）"
    echo "  --status     查看当前发布状态"
    echo "  --open-all   一键打开所有平台提交页面"
    echo "  --help       显示此帮助"
    echo ""
    echo "示例:"
    echo "  ./scripts/publish-mcp.sh           # 首次发布"
    echo "  ./scripts/publish-mcp.sh --update  # 更新已发布的 MCP/Skill"
    echo "  ./scripts/publish-mcp.sh --status  # 查看状态"
    ;;
  *)
    full_publish
    ;;
esac
