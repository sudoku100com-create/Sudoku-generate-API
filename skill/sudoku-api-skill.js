/**
 * Sudoku API Skill
 * Standard Tool-compatible implementation for all large language models
 * Conforms to OpenAI Tool Calls and MCP Skill specifications
 */

const SudokuApiSkill = {
  name: "sudoku_api",
  version: "1.0.0",
  description: "Generate and retrieve Sudoku puzzles through Sudoku100 API. Supports 6 difficulty levels, multiple image formats, and guaranteed unique solutions.",

  // OpenAI Tool Calls compatible schema
  inputSchema: {
    type: "object",
    properties: {
      action: {
        type: "string",
        description: "Action to perform: generate, get_by_id, or list_difficulties",
        enum: ["generate", "get_by_id", "list_difficulties"],
        default: "generate"
      },
      difficulty: {
        type: "string",
        description: "Difficulty level for generated Sudoku puzzle",
        enum: ["beginner", "easy", "medium", "hard", "expert", "extreme"]
      },
      id: {
        type: "integer",
        description: "Sudoku puzzle ID (1-10000) for retrieving a specific puzzle"
      },
      width: {
        type: "integer",
        description: "Image width in pixels (100-1000)",
        minimum: 100,
        maximum: 1000,
        default: 500
      },
      format: {
        type: "string",
        description: "Image format",
        enum: ["png", "webp", "svg", "jpg"],
        default: "png"
      }
    }
  },

  // Standard invoke method for tool execution
  invoke: async function(input, context) {
    try {
      const { action, difficulty, id, width = 500, format = "png" } = input;

      // Handle list_difficulties action
      if (action === "list_difficulties") {
        return {
          success: true,
          data: {
            difficulties: [
              { level: "beginner", hints: "45-50", description: "For beginners" },
              { level: "easy", hints: "38-44", description: "Simple puzzles" },
              { level: "medium", hints: "32-37", description: "Moderate difficulty" },
              { level: "hard", hints: "26-31", description: "Challenging puzzles" },
              { level: "expert", hints: "20-25", description: "Expert level" },
              { level: "extreme", hints: "17-19", description: "Most challenging" }
            ]
          }
        };
      }

      // Handle get_by_id action
        if (action === "get_by_id") {
            if (!id) {
                throw new Error("Parameter 'id' is required for get_by_id action");
            }
            const diff = difficulty || "easy";
            const url = `https://www.sudoku100.com/img-id/${id}`;
            return {
                success: true,
                data: {
                    url,
                    id,
                    difficulty: diff,
                    width,
                    format,
                    message: "Sudoku puzzle retrieved successfully"
                }
            };
        }

        // Handle generate action (default)
        let url;
        if (id) {
            // Generate with specific ID
            const diff = difficulty || "easy";
            url = `https://www.sudoku100.com/img-id/${id}`;
        } else if (difficulty) {
            // Generate with difficulty
            url = `https://www.sudoku100.com/sudoku-img/${difficulty}`;
        } else {
            // Random generation
            url = `https://www.sudoku100.com/sudoku-img`;
        }

      return {
        success: true,
        data: {
          url,
          difficulty: difficulty || "random",
          width,
          format,
          message: "Sudoku puzzle generated successfully"
        }
      };
    } catch (error) {
      return {
        success: false,
        error: {
          message: error.message || "Unknown error occurred",
          code: error.code || "EXECUTION_ERROR"
        }
      };
    }
  },

  // Legacy execute method for backward compatibility
  execute: async function(params) {
    return this.invoke(params, {});
  },

  // Get tool definition for LLM function calling
  getToolDefinition: function() {
    return {
      type: "function",
      name: this.name,
      description: this.description,
      parameters: this.inputSchema
    };
  },

  // Get available actions
  getAvailableActions: function() {
    return ["generate", "get_by_id", "list_difficulties"];
  }
};

module.exports = SudokuApiSkill;