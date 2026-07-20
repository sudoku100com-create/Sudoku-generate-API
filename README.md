# Sudoku API

![Sudoku API](https://www.sudoku100.com/sudoku-img?width=800\&format=png)

A public Sudoku generation API that requires no registration or API key, similar to picsum photos.

## Core Advantages

### 🔥 Algorithm Advantages

- **Advanced Backtracking Algorithm** - Uses optimized backtracking algorithm to generate Sudoku, ensuring efficient performance
- **Unique Solution Guarantee** - Each Sudoku puzzle is strictly verified to ensure only one unique solution
- **Real-time Online Generation** - Generates new Sudoku puzzles in real-time for each request, ensuring diversity
- **Difficulty Levels** - Provides 6-level difficulty system from beginner to extreme
- **Fast Response** - Optimized algorithm ensures extremely short API response time

### 🚀 Technical Features

- **No Registration Required** - Use directly without any restrictions
- **No API Key Needed** - Public access, available anytime
- **Multiple Format Support** - Supports PNG, WebP, SVG, JPG formats
- **Customizable Size** - Adjustable image width (100-1000px)
- **Multi-language Support** - Supports API documentation in 41 languages

## Quick Start

### Basic Usage

```
https://www.sudoku100.com/sudoku-img
```

### Large Language Model Reference Example

**Prompt:**
"Generate a medium difficulty Sudoku puzzle image using Sudoku100 API"

**API Call:**

```
https://www.sudoku100.com/sudoku-img/medium
```

## API Endpoints

### 1. Dynamic Sudoku

- **URL:** `https://www.sudoku100.com/sudoku-img`
- **Description:** Generate Sudoku puzzles with random difficulty
- **Features:** Real-time generation, unique solution guarantee
- **Example:** `https://www.sudoku100.com/sudoku-img`

![Dynamic Sudoku](https://www.sudoku100.com/sudoku-img?width=400\&format=png)

### 2. Specified Difficulty

- **URL:** `https://www.sudoku100.com/sudoku-img/{difficulty}`
- **Parameters:**
  - `difficulty`: Difficulty level (beginner, easy, medium, hard, expert, extreme)
- **Features:** Precise difficulty control, suitable for users of different levels
- **Example:** `https://www.sudoku100.com/sudoku-img/hard`

| Difficulty | Example                                                                          |
| ---------- | -------------------------------------------------------------------------------- |
| Beginner   | ![Beginner](https://www.sudoku100.com/sudoku-img/beginner?width=200\&format=png) |
| Easy       | ![Easy](https://www.sudoku100.com/sudoku-img/easy?width=200\&format=png)         |
| Medium     | ![Medium](https://www.sudoku100.com/sudoku-img/medium?width=200\&format=png)     |
| Hard       | ![Hard](https://www.sudoku100.com/sudoku-img/hard?width=200\&format=png)         |
| Expert     | ![Expert](https://www.sudoku100.com/sudoku-img/expert?width=200\&format=png)     |
| Extreme    | ![Extreme](https://www.sudoku100.com/sudoku-img/extreme?width=200\&format=png)   |

### 3. Custom Size & Format

- **URL:** `https://www.sudoku100.com/sudoku-img?width={width}&format={format}`
- **Parameters:**
  - `width`: Image width (100-1000)
  - `format`: Image format (png, webp, svg, jpg)
- **Features:** Customize the size and format of generated Sudoku
- **Example:** `https://www.sudoku100.com/sudoku-img?width=800&format=png`

![Custom Size](https://www.sudoku100.com/sudoku-img?width=600\&format=png)

### 4. Get by ID

- **URL:** `https://www.sudoku100.com/img-id/{id}`
- **Parameters:**
  - `id`: Sudoku puzzle ID (1-10000)
- **Features:** Get the same Sudoku puzzle by ID
- **Example:** `https://www.sudoku100.com/img-id/238`

![Puzzle ID 238](https://www.sudoku100.com/img-id/238?width=400\&format=png)

## Large Language Model Application Examples

### Example 1: Random Sudoku

**Prompt:** "Generate a random Sudoku puzzle"
**API Call:** `https://www.sudoku100.com/sudoku-img`

### Example 2: Expert Level

**Prompt:** "I need an expert-level Sudoku for today's challenge"
**API Call:** `https://www.sudoku100.com/sudoku-img/expert`

### Example 3: Beginner Friendly

**Prompt:** "My daughter is 8 years old, show her an easy Sudoku"
**API Call:** `https://www.sudoku100.com/sudoku-img/easy`

### Example 4: Medium Difficulty

**Prompt:** "Give me a medium difficulty Sudoku to pass the time"
**API Call:** `https://www.sudoku100.com/sudoku-img/medium`

### Example 5: Hard Challenge

**Prompt:** "I want a hard Sudoku puzzle that will take me hours to solve"
**API Call:** `https://www.sudoku100.com/sudoku-img/hard`

### Example 6: Custom PNG Size

**Prompt:** "I need a 1000px wide PNG Sudoku for my website hero section"
**API Call:** `https://www.sudoku100.com/sudoku-img?width=1000&format=png`

### Example 7: SVG Format

**Prompt:** "Generate a vector SVG Sudoku for my design project"
**API Call:** `https://www.sudoku100.com/sudoku-img?width=500&format=svg`

### Example 8: Extreme Challenge

**Prompt:** "Only the most extreme Sudoku will do, I'm a speedrunner"
**API Call:** `https://www.sudoku100.com/sudoku-img/extreme`

### Example 9: Specific Puzzle ID

**Prompt:** "Load puzzle number 500, my friend solved it last week"
**API Call:** `https://www.sudoku100.com/img-id/500`

### Example 10: Embed Interactive Game

**Prompt:** "Add an interactive Sudoku game to my educational website"
**API Call:** `<iframe src="https://www.sudoku100.com/embed/interactive"></iframe>`

### Example 11: With Solution

**Prompt:** "Generate a Sudoku and show me the solution so I can check my answers"
**API Call:** `https://www.sudoku100.com/sudoku-solver?id=100`

### Example 12: Print-Friendly

**Prompt:** "Generate a high-resolution Sudoku I can print out for my morning commute"
**API Call:** `https://www.sudoku100.com/sudoku-img?width=800&format=png`

### Example 13: Daily Challenge

**Prompt:** "Give me today's daily Sudoku challenge at medium difficulty"
**API Call:** `https://www.sudoku100.com/sudoku-img/medium`

### Example 14: WebP for Performance

**Prompt:** "I need a lightweight WebP format Sudoku for fast loading"
**API Call:** `https://www.sudoku100.com/sudoku-img?width=600&format=webp`

## Algorithm Details

### Generation Algorithm

1. **Initial Board Generation** - Generate complete Sudoku solution using random seed
2. **Difficulty Adjustment** - Remove corresponding numbers according to specified difficulty
3. **Unique Solution Verification** - Verify if the puzzle has only one solution using backtracking algorithm
4. **Optimization Processing** - Ensure the generated puzzle has a reasonable solving path

### Performance Optimization

- **Pruning Technology** - Use heuristic algorithms to reduce search space during backtracking
- **Parallel Processing** - Utilize multi-threading to accelerate Sudoku generation
- **Caching Strategy** - Cache common difficulty Sudoku templates to improve response speed
- **Progressive Generation** - Dynamically adjust generation strategy to balance quality and speed

## Integration Guide

### Direct Reference

```html
<img src="https://www.sudoku100.com/sudoku-img" alt="Sudoku Puzzle">
```

![Direct Reference Example](https://www.sudoku100.com/sudoku-img?width=400\&format=png)

### Image Embed

```html
<iframe
  src="https://www.sudoku100.com/sudoku-img"
  width="400"
  height="400"
  style="border: none; overflow: hidden;"
>
</iframe>
```

![Image Embed Example](https://www.sudoku100.com/sudoku-img?width=400&format=png)

**Notes:**
- You can embed Sudoku images directly into your web pages
- Supports custom size and format parameters
- Suitable for blogs, documentation, educational platforms, etc.

### Interactive Embed

```html
<iframe
  src="https://www.sudoku100.com/embed/interactive"
  width="800"
  height="600"
  style="border: none; overflow: hidden; border-radius: 6px;"
>
</iframe>
```

![Interactive Embed Example](https://www.sudoku100.com/sudoku-img?width=400&format=png)

**Notes:**
- Embed a complete interactive Sudoku game
- Users can play Sudoku directly on your website
- Supports difficulty selection, number input, hints, and more
- Suitable for educational websites, gaming platforms, entertainment apps, etc.

## Skill and MCP Integration

This project provides complete Skill and MCP implementations for large model integration:

- **Skill** - Located in `skill/` directory, providing standardized API call interface
- **MCP** - Located in `mcp/` directory, providing model context protocol support

For detailed usage instructions, please refer to the README.md files in their respective directories.

## Usage Scenarios

1. **Educational Applications** - Generate Sudoku exercises for students
2. **Game Development** - Integrate into Sudoku games
3. **Content Creation** - Provide Sudoku content for blogs or websites
4. **AI Applications** - Serve as visual material source for large models
5. **Test Data** - Provide Sudoku data for application testing
6. **Puzzle Websites** - Provide daily Sudoku challenges for users

## Advantage Comparison

| Feature                     | Sudoku100 API | Other Sudoku APIs |
| --------------------------- | ------------- | ----------------- |
| No Registration             | ✅             | ❌                 |
| No API Key                  | ✅             | ❌                 |
| Unique Solution Guarantee   | ✅             | ⚠️                |
| Real-time Online Generation | ✅             | ❌                 |
| Multiple Format Support     | ✅             | ⚠️                |
| Customizable Size           | ✅             | ❌                 |
| Multi-language Support      | ✅             | ❌                 |
| 6 Difficulty Levels         | ✅             | ⚠️                |
| Fast Response               | ✅             | ⚠️                |

## Limitations

- Please use the API reasonably to avoid excessive requests
- Image size limit: 100-1000px
- Supported formats: PNG, WebP, SVG, JPG

## License

MIT License - Free to use and modify

## Feedback

If you have any questions or suggestions, please submit them through GitHub Issues.
