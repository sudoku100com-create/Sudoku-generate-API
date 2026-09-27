---
name: sudoku-api
description: This skill should be used when the user wants to generate or retrieve Sudoku puzzle images, such as "generate a hard Sudoku puzzle", "give me Sudoku puzzle #500", or "list Sudoku difficulty levels". It provides a ready-to-use tool module that integrates the Sudoku100 API into external LLM tool calling (OpenAI Tool Calls, Anthropic Tool Use, or generic JSON Schema tools), supporting 6 difficulty levels, puzzle retrieval by ID (1-10000), custom image width (100-1000px) and formats (png, webp, svg, jpg), with no API key required.
---

# Sudoku API Skill

Provide Sudoku puzzle generation and retrieval as an LLM tool through the Sudoku100 API (`https://www.sudoku100.com`). Use the bundled module `scripts/sudoku-api-skill.js` — do not rewrite the tool-call logic from scratch.

## Usage

Load the module and call `invoke` with a parameters object (or an OpenAI-style JSON string):

```javascript
const SudokuApiSkill = require("./scripts/sudoku-api-skill");

// Generate a random puzzle
const result = await SudokuApiSkill.invoke({ action: "generate" });
// result.data.url -> https://www.sudoku100.com/sudoku-img?width=500&format=png

// Generate with difficulty and output settings
await SudokuApiSkill.invoke({ action: "generate", difficulty: "hard", width: 800, format: "png" });
// -> https://www.sudoku100.com/sudoku-img/hard?width=800&format=png

// Retrieve a specific puzzle
await SudokuApiSkill.invoke({ action: "get_by_id", id: 238, width: 720, format: "png" });
// -> https://www.sudoku100.com/img-id/238?width=720&format=png

// List difficulty levels
await SudokuApiSkill.invoke({ action: "list_difficulties" });
```

## Actions

| Action | Description | Required params |
|--------|-------------|-----------------|
| `generate` (default) | Generate a new Sudoku puzzle | none |
| `get_by_id` | Retrieve a specific puzzle by ID | `id` (1-10000) |
| `list_difficulties` | List all difficulty levels | none |

## Parameters

| Parameter | Type | Constraint |
|-----------|------|-----------|
| `action` | string | `generate`, `get_by_id`, `list_difficulties` |
| `difficulty` | string | `beginner`, `easy`, `medium`, `hard`, `expert`, `extreme` |
| `id` | integer | 1-10000 |
| `width` | integer | 100-1000 (default 500) |
| `format` | string | `png`, `webp`, `svg`, `jpg` (default `png`) |

## Tool Definitions for LLM Providers

Get a provider-specific tool definition instead of hand-writing the schema:

```javascript
SudokuApiSkill.getToolDefinition("openai");     // { type: "function", function: { name, description, parameters } }
SudokuApiSkill.getToolDefinition("anthropic"); // { name, description, input_schema }
SudokuApiSkill.getToolDefinition("generic");   // { name, description, parameters }
```

When handling tool-call responses:

- OpenAI delivers `function.arguments` as a JSON string — pass it to `invoke` directly; it parses internally.
- Anthropic `tool_use` blocks deliver `input` as an object — pass it to `invoke` directly.

## Result Handling

Success:

```javascript
{ success: true, data: { url, id?, difficulty, width, format, message } }
```

Failure (all parameters are validated):

```javascript
{ success: false, error: { message, code } }
```

Error codes: `INVALID_ACTION`, `INVALID_DIFFICULTY`, `INVALID_ID`, `INVALID_WIDTH`, `INVALID_FORMAT`, `MISSING_ID`, `EXECUTION_ERROR`. Surface `error.message` to the caller.

## Notes

- No API key is required; the endpoints are public and every puzzle has a guaranteed unique solution.
- The returned `url` serves a puzzle image directly; embed it in Markdown/HTML or hand it to the user as-is.
- See `../docs/integration.md` for raw URL patterns and non-LLM integration examples.
