# Sudoku API MCP

This MCP (Model Context Protocol) provides a structured way for large language models to interact with the Sudoku100 API.

## Features

- Structured context for Sudoku-related prompts
- Pre-defined examples for common use cases
- Template-based response generation
- Support for multiple Sudoku API endpoints

## Usage

### Basic Usage
```javascript
const SudokuApiMCP = require("../mcp/sudoku-api-mcp");

const request = {
  prompt: "Generate a hard difficulty Sudoku puzzle"
};

const response = SudokuApiMCP.process(request);
console.log(response);
```

### Example Output
```javascript
{
  action: "generate_sudoku",
  parameters: {
    difficulty: "hard"
  }
}
```

## Capabilities

| Capability | Description |
|------------|-------------|
| generate_sudoku | Generate a Sudoku puzzle with specified difficulty |
| get_sudoku_by_id | Get a specific Sudoku puzzle by ID |
| customize_sudoku | Generate a Sudoku puzzle with custom size and format |

## API Templates

- **Generate**: `https://www.sudoku100.com/sudoku-img` or `https://www.sudoku100.com/sudoku-img/{difficulty}`
- **By ID**: `https://www.sudoku100.com/img-id/{id}?width={width}&format={format}`
- **Custom**: `https://www.sudoku100.com/sudoku-img?width={width}&format={format}`

## Context Examples

1. **Generate a medium difficulty Sudoku puzzle**
   - Action: generate_sudoku
   - Parameters: { difficulty: "medium" }

2. **Get Sudoku puzzle with ID 238**
   - Action: get_sudoku_by_id
   - Parameters: { id: "238" }

3. **Generate a Sudoku puzzle with width 800px in SVG format**
   - Action: customize_sudoku
   - Parameters: { width: 800, format: "svg" }
