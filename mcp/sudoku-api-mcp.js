/**
 * Sudoku API MCP (Model Context Protocol)
 * For interacting with large language model contexts to provide Sudoku-related functionality
 */

const SudokuApiMCP = {
  name: "sudoku-api-mcp",
  version: "1.0.0",
  description: "Sudoku API Model Context Protocol for large language models",
  capabilities: [
    "generate_sudoku",
    "get_sudoku_by_id",
    "customize_sudoku"
  ],
  context: {
    examples: [
      {
        prompt: "Generate a medium difficulty Sudoku puzzle",
        response: {
          action: "generate_sudoku",
          parameters: {
            difficulty: "medium"
          }
        }
      },
      {
        prompt: "Get Sudoku puzzle with ID 238",
        response: {
          action: "get_sudoku_by_id",
          parameters: {
            id: "238"
          }
        }
      },
      {
        prompt: "Generate a Sudoku puzzle with width 800px in SVG format",
        response: {
          action: "customize_sudoku",
          parameters: {
            width: 800,
            format: "svg"
          }
        }
      }
    ],
    templates: {
      generate_sudoku: "To generate a Sudoku puzzle, use: https://www.sudoku100.com/sudoku-img/{difficulty} or https://www.sudoku100.com/sudoku-img for random",
      get_sudoku_by_id: "To get a specific Sudoku puzzle, use: https://www.sudoku100.com/img-id/{id}",
      customize_sudoku: "To customize a Sudoku puzzle, use: https://www.sudoku100.com/sudoku-img?width={width}&format={format}"
    }
  },
  process: (request) => {
    const { prompt } = request;
    
    if (prompt.includes("generate") && prompt.includes("sudoku")) {
      let difficulty = "random";
      if (prompt.includes("beginner")) difficulty = "beginner";
      else if (prompt.includes("easy")) difficulty = "easy";
      else if (prompt.includes("medium")) difficulty = "medium";
      else if (prompt.includes("hard")) difficulty = "hard";
      else if (prompt.includes("expert")) difficulty = "expert";
      else if (prompt.includes("extreme")) difficulty = "extreme";
      
      return {
        action: "generate_sudoku",
        parameters: { difficulty }
      };
    } else if (prompt.includes("id") && prompt.includes("sudoku")) {
      const idMatch = prompt.match(/id\s*(\d+)/i);
      const id = idMatch ? idMatch[1] : "238";
      
      return {
        action: "get_sudoku_by_id",
        parameters: { id }
      };
    } else if (prompt.includes("width") || prompt.includes("format")) {
      let width = 500;
      let format = "png";
      
      const widthMatch = prompt.match(/width\s*(\d+)/i);
      if (widthMatch) width = parseInt(widthMatch[1]);
      
      const formatMatch = prompt.match(/format\s*(\w+)/i);
      if (formatMatch) format = formatMatch[1].toLowerCase();
      
      return {
        action: "customize_sudoku",
        parameters: { width, format }
      };
    }
    
    return {
      action: "generate_sudoku",
      parameters: {}
    };
  }
};

module.exports = SudokuApiMCP;
