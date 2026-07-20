# Sudoku API Skill

Standard Tool-compatible implementation for all large language models. Conforms to OpenAI Tool Calls and MCP Skill specifications.

## Features

- **Universal Compatibility** - Works with OpenAI, Claude, Gemini, and other LLMs
- **Multiple Actions** - Generate random puzzles, get specific puzzles by ID, list difficulty levels
- **6 Difficulty Levels** - From beginner to extreme
- **Customizable Output** - Adjustable image size (100-1000px) and format (PNG, WebP, SVG, JPG)
- **No API Key Required** - Public access, real-time generation with guaranteed unique solutions

## Installation

```bash
npm install sudoku-api-skill
```

Or copy the `sudoku-api-skill.js` file directly into your project.

## Quick Start

### OpenAI Tool Calls Format

```javascript
const SudokuApiSkill = require("./sudoku-api-skill");

// Get tool definition for OpenAI
const tool = SudokuApiSkill.getToolDefinition();
// Use this in your OpenAI API call's tools parameter
```

### Direct Invocation

```javascript
const SudokuApiSkill = require("./sudoku-api-skill");

// Generate a random Sudoku puzzle
const result = await SudokuApiSkill.invoke({ action: "generate" });
console.log(result.data.url);

// Generate with specific difficulty
const hardResult = await SudokuApiSkill.invoke({
  action: "generate",
  difficulty: "hard",
  width: 800,
  format: "png"
});
console.log(hardResult.data.url);

// Get specific puzzle by ID
const specificResult = await SudokuApiSkill.invoke({
  action: "get_by_id",
  id: 238,
  difficulty: "easy",
  width: 720,
  format: "png"
});
console.log(specificResult.data.url);

// List all difficulty levels
const difficulties = await SudokuApiSkill.invoke({ action: "list_difficulties" });
console.log(difficulties.data.difficulties);
```

## Actions

### 1. generate (Default)

Generate a new Sudoku puzzle with optional difficulty and format settings.

```javascript
// Random puzzle
await SudokuApiSkill.invoke({ action: "generate" });

// Specific difficulty
await SudokuApiSkill.invoke({
  action: "generate",
  difficulty: "medium"
});

// With custom size and format
await SudokuApiSkill.invoke({
  action: "generate",
  difficulty: "hard",
  width: 600,
  format: "svg"
});
```

### 2. get_by_id

Retrieve a specific Sudoku puzzle by its ID.

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

Get information about all available difficulty levels.

```javascript
await SudokuApiSkill.invoke({ action: "list_difficulties" });
```

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| action | string | No | generate | Action to perform: generate, get_by_id, or list_difficulties |
| difficulty | string | No | - | Difficulty level: beginner, easy, medium, hard, expert, extreme |
| id | integer | No | - | Sudoku puzzle ID (1-10000) |
| width | integer | No | 500 | Image width in pixels (100-1000) |
| format | string | No | png | Image format: png, webp, svg, jpg |

## Return Value

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

## Error Handling

```javascript
const result = await SudokuApiSkill.invoke({
  action: "get_by_id"
  // missing required 'id' parameter
});

if (!result.success) {
  console.error(result.error.message);
  // Output: "Parameter 'id' is required for get_by_id action"
}
```

## Integration Examples

### OpenAI

```javascript
const response = await openai.chat.completions.create({
  model: "gpt-4",
  messages: [{ role: "user", content: "Generate a hard Sudoku puzzle" }],
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
  messages: [{ role: "user", content: "Generate a hard Sudoku puzzle" }],
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

## URL Patterns

- Random: `https://www.sudoku100.com/sudoku-img`
- By difficulty: `https://www.sudoku100.com/sudoku-img/{difficulty}`
- By ID: `https://www.sudoku100.com/img-id/{id}?width={width}&format={format}`

## Difficulty Levels

| Level | Hints | Description |
|-------|-------|-------------|
| beginner | 45-50 | For beginners |
| easy | 38-44 | Simple puzzles |
| medium | 32-37 | Moderate difficulty |
| hard | 26-31 | Challenging puzzles |
| expert | 20-25 | Expert level |
| extreme | 17-19 | Most challenging |

## License

MIT License