## 📦 基本信息
- **名称**: sudoku-api-mcp
- **版本**: {VERSION}
- **GitHub**: https://github.com/sudoku100com-create/Sudoku-generate-API
- **官网**: https://www.sudoku100.com
- **许可证**: MIT
- **npm**: https://www.npmjs.com/package/sudoku-api-mcp

## 🔧 提供的工具
1. **generate_sudoku** - 生成指定难度的数独谜题（6级难度：beginner/easy/medium/hard/expert/extreme）
2. **get_sudoku_by_id** - 按 ID 获取特定数独谜题（1-10000）
3. **list_difficulties** - 列出所有可用难度级别及提示数范围

## ✨ 核心特色
- 🔥 无需注册，无需 API Key，完全免费
- 🎯 先进的回溯算法，唯一解保证
- 🎨 支持 PNG/WebP/SVG/JPG 4种输出格式
- 📐 自定义图片尺寸 100-1000px
- 🌐 支持 40+ 语言的多语言文档
- ⚡ 在线实时生成，毫秒级响应

## 🚀 安装方式

### Claude Desktop
在 `claude_desktop_config.json` 中添加:
```json
{
  "mcpServers": {
    "sudoku-api": {
      "command": "npx",
      "args": ["-y", "sudoku-api-mcp"]
    }
  }
}
```

### Cursor / Codex
通过 npm 安装后直接作为 MCP Server 使用

### npm
```bash
npm install sudoku-api-mcp
```

## 🎮 使用示例
- "帮我生成一个中等难度的数独" → 调用 `generate_sudoku(difficulty: "medium")`
- "获取238号谜题" → 调用 `get_sudoku_by_id(id: 238)`
- "生成800px宽的SVG数独" → 调用 `generate_sudoku(width: 800, format: "svg")`
- "列出所有可用难度" → 调用 `list_difficulties()`

## 📍 分类
AI 工具 / 游戏 / 教育 / 图片生成
