# Sudoku API Skill

符合国际标准工具调用规范的实现，兼容所有大语言模型。符合 OpenAI Tool Calls 和 MCP Skill 规范。

## 特性

- **通用兼容性** - 支持 OpenAI、Claude、Gemini 等所有大语言模型
- **多种操作** - 生成随机谜题、按 ID 获取特定谜题、列出难度级别
- **6 级难度** - 从初学者到极端
- **可定制输出** - 可调整图片尺寸（100-1000px）和格式（PNG、WebP、SVG、JPG）
- **无需 API 密钥** - 公开访问，实时生成，唯一解保证

## 安装

```bash
npm install sudoku-api-skill
```

或直接将 `sudoku-api-skill.js` 文件复制到您的项目中。

## 快速开始

### OpenAI Tool Calls 格式

```javascript
const SudokuApiSkill = require("./sudoku-api-skill");

// 获取 OpenAI 工具定义
const tool = SudokuApiSkill.getToolDefinition();
// 在 OpenAI API 调用的 tools 参数中使用
```

### 直接调用

```javascript
const SudokuApiSkill = require("./sudoku-api-skill");

// 生成随机数独谜题
const result = await SudokuApiSkill.invoke({ action: "generate" });
console.log(result.data.url);

// 生成指定难度的谜题
const hardResult = await SudokuApiSkill.invoke({
  action: "generate",
  difficulty: "hard",
  width: 800,
  format: "png"
});
console.log(hardResult.data.url);

// 按 ID 获取特定谜题
const specificResult = await SudokuApiSkill.invoke({
  action: "get_by_id",
  id: 238,
  difficulty: "easy",
  width: 720,
  format: "png"
});
console.log(specificResult.data.url);

// 列出所有难度级别
const difficulties = await SudokuApiSkill.invoke({ action: "list_difficulties" });
console.log(difficulties.data.difficulties);
```

## 操作

### 1. generate (默认)

生成带有可选难度和格式设置的新数独谜题。

```javascript
// 随机谜题
await SudokuApiSkill.invoke({ action: "generate" });

// 指定难度
await SudokuApiSkill.invoke({
  action: "generate",
  difficulty: "medium"
});

// 自定义尺寸和格式
await SudokuApiSkill.invoke({
  action: "generate",
  difficulty: "hard",
  width: 600,
  format: "svg"
});
```

### 2. get_by_id

通过 ID 获取特定的数独谜题。

```javascript
await SudokuApiSkill.invoke({
  action: "get_by_id",
  id: 238,
  difficulty: "easy",
  width: 720,
  format: "png"
});
```

### 3. list_difficulties

获取所有可用难度级别的信息。

```javascript
await SudokuApiSkill.invoke({ action: "list_difficulties" });
```

## 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| action | string | 否 | generate | 执行的操作：generate、get_by_id 或 list_difficulties |
| difficulty | string | 否 | - | 难度级别：beginner、easy、medium、hard、expert、extreme |
| id | integer | 否 | - | 数独谜题 ID（1-10000）|
| width | integer | 否 | 500 | 图片宽度（100-1000）|
| format | string | 否 | png | 图片格式：png、webp、svg、jpg |

## 返回值

```javascript
{
  success: true,
  data: {
    url: "https://www.sudoku100.com/sudoku-img/hard",
    id: 238,
    difficulty: "hard",
    width: 800,
    format: "png",
    message: "Sudoku puzzle generated successfully"
  }
}
```

## 错误处理

```javascript
const result = await SudokuApiSkill.invoke({
  action: "get_by_id"
  // 缺少必需的 'id' 参数
});

if (!result.success) {
  console.error(result.error.message);
  // 输出: "Parameter 'id' is required for get_by_id action"
}
```

## 集成示例

### OpenAI

```javascript
const response = await openai.chat.completions.create({
  model: "gpt-4",
  messages: [{ role: "user", content: "生成一个困难难度的数独谜题" }],
  tools: [
    {
      type: "function",
      function: SudokuApiSkill.getToolDefinition()
    }
  ],
  tool_choice: { type: "function", function: { name: "sudoku_api" } }
});

const toolResult = await SudokuApiSkill.invoke(response.tool_calls[0].function.arguments);
```

### Claude (Anthropic)

```javascript
const response = await claude.messages.create({
  model: "claude-3-opus",
  messages: [{ role: "user", content: "生成一个困难难度的数独谜题" }],
  tools: [SudokuApiSkill.getToolDefinition()]
});

const toolResult = await SudokuApiSkill.invoke(response.content[0].input);
```

### LangChain

```javascript
const tool = new langchain.tools.Tool({
  name: "sudoku_api",
  description: SudokuApiSkill.description,
  inputSchema: SudokuApiSkill.inputSchema,
  func: async (input) => JSON.stringify(await SudokuApiSkill.invoke(input))
});
```

## URL 模式

- 随机: `https://www.sudoku100.com/sudoku-img`
- 按难度: `https://www.sudoku100.com/sudoku-img/{difficulty}`
- 按 ID: `https://www.sudoku100.com/img-id/{id}?width={width}&format={format}`

## 难度级别

| 级别 | 提示数 | 描述 |
|------|--------|------|
| beginner | 45-50 | 适合初学者 |
| easy | 38-44 | 简单谜题 |
| medium | 32-37 | 中等难度 |
| hard | 26-31 | 具有挑战性的谜题 |
| expert | 20-25 | 专家级别 |
| extreme | 17-19 | 最具挑战性 |

## 许可证

MIT 许可证