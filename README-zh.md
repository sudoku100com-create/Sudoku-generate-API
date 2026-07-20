# Sudoku API

![Sudoku API](https://www.sudoku100.com/sudoku-img?width=800\&format=png)

一个无需注册、无需 API 密钥的公共数独生成 API，类似于 picsum photos。

## 核心优势

### 🔥 算法优势

- **先进的回溯算法** - 使用优化的回溯算法生成数独，确保高效性能
- **唯一解保证** - 每道数独题都经过严格验证，确保只有一个唯一解
- **在线实时生成** - 每次请求都实时生成新的数独题，确保多样性
- **难度分级** - 提供从初学者到极端的 6 级难度系统
- **快速响应** - 优化的算法确保 API 响应时间极短

### 🚀 技术特点

- **无需注册** - 直接使用，无任何限制
- **无需 API 密钥** - 公开访问，随时可用
- **多格式支持** - 支持 PNG、WebP、SVG、JPG 格式
- **自定义尺寸** - 可调整图片宽度（100-1000px）
- **多语言支持** - 支持 41 种语言的 API 文档

## 快速开始

### 基本用法

```
https://www.sudoku100.com/sudoku-img
```

### 大模型引用示例

**提示词：**
"生成一个中等难度的数独谜题图片，使用 Sudoku100 API"

**API 调用：**

```
https://www.sudoku100.com/sudoku-img/medium
```

## API 端点

### 1. 动态数独

- **URL:** `https://www.sudoku100.com/sudoku-img`
- **描述:** 生成随机难度的数独谜题
- **特点:** 实时生成，唯一解保证
- **示例:** `https://www.sudoku100.com/sudoku-img`

![动态数独](https://www.sudoku100.com/sudoku-img?width=400\&format=png)

### 2. 指定难度

- **URL:** `https://www.sudoku100.com/sudoku-img/{difficulty}`
- **参数:**
  - `difficulty`: 难度级别 (beginner, easy, medium, hard, expert, extreme)
- **特点:** 精确控制难度，适合不同水平的用户
- **示例:** `https://www.sudoku100.com/sudoku-img/hard`

| 难度  | 示例                                                                          |
| --- | --------------------------------------------------------------------------- |
| 初学者 | ![初学者](https://www.sudoku100.com/sudoku-img/beginner?width=200\&format=png) |
| 简单  | ![简单](https://www.sudoku100.com/sudoku-img/easy?width=200\&format=png)      |
| 中等  | ![中等](https://www.sudoku100.com/sudoku-img/medium?width=200\&format=png)    |
| 困难  | ![困难](https://www.sudoku100.com/sudoku-img/hard?width=200\&format=png)      |
| 专家  | ![专家](https://www.sudoku100.com/sudoku-img/expert?width=200\&format=png)    |
| 极端  | ![极端](https://www.sudoku100.com/sudoku-img/extreme?width=200\&format=png)   |

### 3. 自定义尺寸和格式

- **URL:** `https://www.sudoku100.com/sudoku-img?width={width}&format={format}`
- **参数:**
  - `width`: 图片宽度 (100-1000)
  - `format`: 图片格式 (png, webp, svg, jpg)
- **特点:** 自定义生成数独的尺寸和格式
- **示例:** `https://www.sudoku100.com/sudoku-img?width=800&format=png`

![自定义尺寸](https://www.sudoku100.com/sudoku-img?width=600\&format=png)

### 4. 按 ID 获取

- **URL:** `https://www.sudoku100.com/img-id/{id}`
- **参数:**
  - `id`: 数独谜题 ID (1-10000)
- **特点:** 通过 ID 获取相同的数独谜题
- **示例:** `https://www.sudoku100.com/img-id/238`

![谜题编号 238](https://www.sudoku100.com/img-id/238?width=400\&format=png)

## 大模型应用示例

### 示例 1: 随机数独

**提示词:** "生成一个随机数独谜题"
**API 调用:** `https://www.sudoku100.com/sudoku-img`

### 示例 2: 专家级

**提示词:** "我需要今天的专家级难度数独挑战"
**API 调用:** `https://www.sudoku100.com/sudoku-img/expert`

### 示例 3: 入门级

**提示词:** "我女儿8岁，给她看一个简单的数独"
**API 调用:** `https://www.sudoku100.com/sudoku-img/easy`

### 示例 4: 中等难度

**提示词:** "给我一个中等难度的数独来打发时间"
**API 调用:** `https://www.sudoku100.com/sudoku-img/medium`

### 示例 5: 困难挑战

**提示词:** "我想要一个需要花几小时才能解的困难数独"
**API 调用:** `https://www.sudoku100.com/sudoku-img/hard`

### 示例 6: 自定义 PNG 尺寸

**提示词:** "我需要一个1000px宽的PNG数独作为网站英雄区"
**API 调用:** `https://www.sudoku100.com/sudoku-img?width=1000&format=png`

### 示例 7: SVG 格式

**提示词:** "为我的设计项目生成一个矢量SVG数独"
**API 调用:** `https://www.sudoku100.com/sudoku-img?width=500&format=svg`

### 示例 8: 极限挑战

**提示词:** "只有最极限的数独才够，我是速解选手"
**API 调用:** `https://www.sudoku100.com/sudoku-img/extreme`

### 示例 9: 特定谜题 ID

**提示词:** "加载编号500的谜题，我朋友上周解过"
**API 调用:** `https://www.sudoku100.com/img-id/500`

### 示例 10: 嵌入互动游戏

**提示词:** "在我的教育网站上添加一个互动数独游戏"
**API 调用:** `<iframe src="https://www.sudoku100.com/embed/interactive"></iframe>`

### 示例 11: 带解题方案

**提示词:** "生成一个数独并显示答案，以便我检查"
**API 调用:** `https://www.sudoku100.com/sudoku-solver?id=100`

### 示例 12: 打印友好

**提示词:** "生成一个高分辨率数独，我可以打印出来在上班路上解"
**API 调用:** `https://www.sudoku100.com/sudoku-img?width=800&format=png`

### 示例 13: 每日挑战

**提示词:** "给我今天的中等难度每日数独挑战"
**API 调用:** `https://www.sudoku100.com/sudoku-img/medium`

### 示例 14: WebP 格式优化性能

**提示词:** "我需要一个轻量级的WebP格式数独以实现快速加载"
**API 调用:** `https://www.sudoku100.com/sudoku-img?width=600&format=webp`

## 算法详解

### 生成算法

1. **初始棋盘生成** - 使用随机种子生成完整的数独解决方案
2. **难度调整** - 根据指定难度移除相应数量的数字
3. **唯一解验证** - 使用回溯算法验证谜题是否只有一个解
4. **优化处理** - 确保生成的谜题具有合理的解题路径

### 性能优化

- **剪枝技术** - 在回溯过程中使用启发式算法减少搜索空间
- **并行处理** - 利用多线程加速数独生成
- **缓存策略** - 缓存常见难度的数独模板，提高响应速度
- **渐进式生成** - 动态调整生成策略，确保质量和速度的平衡

## 集成指南

### 直接引用

```html
<img src="https://www.sudoku100.com/sudoku-img" alt="数独谜题">
```

![直接引用示例](https://www.sudoku100.com/sudoku-img?width=400\&format=png)

### 图片嵌入

```html
<iframe
  src="https://www.sudoku100.com/sudoku-img"
  width="400"
  height="400"
  style="border: none; overflow: hidden;"
>
</iframe>
```

![图片嵌入示例](https://www.sudoku100.com/sudoku-img?width=400&format=png)

**说明：**
- 可以直接嵌入数独图片到您的网页中
- 支持自定义尺寸和格式参数
- 适用于博客、文档、教育平台等场景

### 交互嵌入

```html
<iframe
  src="https://www.sudoku100.com/embed/interactive"
  width="800"
  height="600"
  style="border: none; overflow: hidden; border-radius: 6px;"
>
</iframe>
```

![交互嵌入示例](https://www.sudoku100.com/sudoku-img?width=400&format=png)

**说明：**
- 嵌入完整的可交互数独游戏
- 用户可以直接在您的网页上玩数独
- 支持难度选择、数字输入、提示等功能
- 适用于教育网站、游戏平台、娱乐应用等场景

## Skill 和 MCP 集成

本项目提供了完整的 Skill 和 MCP 实现，便于大模型集成：

- **Skill** - 位于 `skill/` 目录，提供标准化的 API 调用接口
- **MCP** - 位于 `mcp/` 目录，提供模型上下文协议支持

详细使用说明请参考各自目录下的 README.md 文件。

## 使用场景

1. **教育应用** - 为学生生成数独练习
2. **游戏开发** - 集成到数独游戏中
3. **内容创作** - 为博客或网站提供数独内容
4. **AI 应用** - 作为大模型的视觉素材来源
5. **测试数据** - 为应用程序测试提供数独数据
6. **益智网站** - 为用户提供每日数独挑战

## 优势对比

| 特性        | Sudoku100 API | 其他数独 API |
| --------- | ------------- | -------- |
| 无需注册      | ✅             | ❌        |
| 无需 API 密钥 | ✅             | ❌        |
| 唯一解保证     | ✅             | ⚠️       |
| 在线实时生成    | ✅             | ❌        |
| 多格式支持     | ✅             | ⚠️       |
| 自定义尺寸     | ✅             | ❌        |
| 多语言支持     | ✅             | ❌        |
| 6 级难度     | ✅             | ⚠️       |
| 快速响应      | ✅             | ⚠️       |

## 限制

- 请合理使用 API，避免过度请求
- 图片尺寸限制为 100-1000px
- 支持的格式：PNG, WebP, SVG, JPG

## 许可证

MIT 许可证 - 可自由使用和修改

## 反馈

如有问题或建议，请通过 GitHub Issues 提交。

