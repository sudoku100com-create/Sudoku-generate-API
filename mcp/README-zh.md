# Sudoku API MCP

该 MCP（模型上下文协议）为大型语言模型提供了一种结构化的方式来与 Sudoku100 API 交互。

## 特性

- 数独相关提示的结构化上下文
- 常见用例的预定义示例
- 基于模板的响应生成
- 支持多个 Sudoku API 端点

## 使用方法

### 基本用法
```javascript
const SudokuApiMCP = require("../mcp/sudoku-api-mcp");

const request = {
  prompt: "生成一个困难难度的数独谜题"
};

const response = SudokuApiMCP.process(request);
console.log(response);
```

### 示例输出
```javascript
{
  action: "generate_sudoku",
  parameters: {
    difficulty: "hard"
  }
}
```

## 功能

| 功能 | 描述 |
|------|------|
| generate_sudoku | 生成指定难度的数独谜题 |
| get_sudoku_by_id | 根据 ID 获取特定的数独谜题 |
| customize_sudoku | 生成自定义尺寸和格式的数独谜题 |

## API 模板

- **生成**: `https://www.sudoku100.com/sudoku-img` 或 `https://www.sudoku100.com/sudoku-img/{difficulty}`
- **按 ID**: `https://www.sudoku100.com/img-id/{id}?width={width}&format={format}`
- **自定义**: `https://www.sudoku100.com/sudoku-img?width={width}&format={format}`

## 上下文示例

1. **生成中等难度的数独谜题**
   - 动作: generate_sudoku
   - 参数: { difficulty: "medium" }

2. **获取 ID 为 238 的数独谜题**
   - 动作: get_sudoku_by_id
   - 参数: { id: "238" }

3. **生成宽度为 800px 的 SVG 格式数独谜题**
   - 动作: customize_sudoku
   - 参数: { width: 800, format: "svg" }
