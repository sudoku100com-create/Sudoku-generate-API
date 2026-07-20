# Sudoku API 集成指南

## 直接引用

### 基本用法
```html
<img src="https://www.sudoku100.com/sudoku-img" alt="数独谜题">
```

### 指定难度
```html
<img src="https://www.sudoku100.com/sudoku-img/hard" alt="困难数独">
```

### 自定义尺寸和格式
```html
<img src="https://www.sudoku100.com/img-id/238?width=500&format=png" alt="自定义数独">
```

## 网站集成

### 带解题器链接
```html
<div class="sudoku-container">
  <h3>每日数独挑战</h3>
  <img src="https://www.sudoku100.com/sudoku-img/medium" alt="每日数独">
  <a href="https://www.sudoku100.com/sudoku-solver" target="_blank">
    点击这里解题
  </a>
</div>
```

### 多难度选择
```html
<div class="sudoku-selector">
  <h3>选择难度</h3>
  <div class="difficulty-buttons">
    <button data-difficulty="easy">简单</button>
    <button data-difficulty="medium">中等</button>
    <button data-difficulty="hard">困难</button>
  </div>
  <img id="sudoku-image" src="https://www.sudoku100.com/sudoku-img" alt="数独谜题">
</div>

<script>
  document.querySelectorAll('.difficulty-buttons button').forEach(button => {
    button.addEventListener('click', function() {
      const difficulty = this.getAttribute('data-difficulty');
      document.getElementById('sudoku-image').src = `https://www.sudoku100.com/sudoku-img/${difficulty}`;
    });
  });
</script>
```

## iframe 嵌入

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

**说明：**
- 可以直接将数独图片嵌入到您的网页中
- 支持自定义尺寸和格式参数（例如 `?width=500&format=png`）
- 适用于博客、文档、教育平台等场景

### 交互式游戏嵌入
```html
<iframe
  src="https://www.sudoku100.com/embed/interactive"
  width="800"
  height="600"
  style="border: none; overflow: hidden; border-radius: 6px;"
>
</iframe>
```

**说明：**
- 嵌入完整的可交互数独游戏
- 用户可以直接在您的网站上玩数独
- 支持难度选择、数字输入、提示等功能

### 响应式嵌入
```html
<div style="position: relative; padding-bottom: 75%; height: 0;">
  <iframe
    src="https://www.sudoku100.com/embed/interactive"
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;"
  >
  </iframe>
</div>
```

## 大语言模型集成

### 使用 Skill
```javascript
const SudokuApiSkill = require('./skill/sudoku-api-skill');

// 生成数独谜题
async function generateSudoku(difficulty = 'medium') {
  const result = await SudokuApiSkill.execute({ difficulty });
  return result.data.url;
}

// 示例使用
generateSudoku('hard').then(url => {
  console.log('Sudoku URL:', url);
});
```

### Using MCP
```javascript
const SudokuApiMCP = require('./mcp/sudoku-api-mcp');

// 处理用户请求
function handleSudokuRequest(prompt) {
  const request = { prompt };
  const response = SudokuApiMCP.process(request);

  // 根据响应生成 API URL
    let url = 'https://www.sudoku100.com/sudoku-img';

    if (response.action === 'generate_sudoku' && response.parameters.difficulty && response.parameters.difficulty !== 'random') {
      url += `/${response.parameters.difficulty}`;
    } else if (response.action === 'get_sudoku_by_id' && response.parameters.id) {
      url = `https://www.sudoku100.com/img-id/${response.parameters.id}`;
    } else if (response.action === 'customize_sudoku') {
      const width = response.parameters.width || 500;
      const format = response.parameters.format || 'png';
      url = `https://www.sudoku100.com/sudoku-img?width=${width}&format=${format}`;
    }

  return url;
}

// 示例使用
const prompt = "生成一个专家级难度的数独谜题图片";
const url = handleSudokuRequest(prompt);
console.log('Sudoku URL:', url);
```

## 移动应用集成

### iOS 示例
```swift
import UIKit

class SudokuViewController: UIViewController {
    @IBOutlet weak var sudokuImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSudoku()
    }

    func loadSudoku() {
        let url = URL(string: "https://www.sudoku100.com/sudoku-img/hard")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.sudokuImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
```

### Android 示例
```java
import android.os.AsyncTask;
import android.widget.ImageView;
import com.squareup.picasso.Picasso;

public class SudokuActivity extends AppCompatActivity {
    private ImageView sudokuImageView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sudoku);

        sudokuImageView = findViewById(R.id.sudoku_image);
        loadSudoku();
    }

    private void loadSudoku() {
        String url = "https://www.sudoku100.com/sudoku-img/medium";
        Picasso.get().load(url).into(sudokuImageView);
    }
}
```

## 最佳实践

1. **缓存策略** - 对于频繁使用的数独，考虑本地缓存
2. **错误处理** - 实现适当的错误处理，处理网络问题
3. **响应式设计** - 确保在不同设备上都能正常显示
4. **用户体验** - 添加加载状态和错误提示
5. **合理使用** - 避免过度请求，尊重 API 资源

## 故障排除

### 常见问题

1. **图片不显示**
   - 检查网络连接
   - 验证 URL 格式是否正确
   - 确保图片尺寸在 100-1000px 之间

2. **API 响应缓慢**
   - 考虑使用缓存
   - 减少请求频率
   - 优化图片尺寸和格式

3. **格式不支持**
   - 确保使用支持的格式：png, webp, svg, jpg
   - 检查格式参数是否正确

4. **难度级别无效**
   - 确保使用有效的难度级别：beginner, easy, medium, hard, expert, extreme

## URL 模式

### 动态生成
```
https://www.sudoku100.com/sudoku-img
```
每次请求生成一个新的数独谜题。

### 按 ID 获取
```
https://www.sudoku100.com/img-id/{id}?width={width}&format={format}
```

### 示例：
- `https://www.sudoku100.com/sudoku-img?difficulty=easy`
- `https://www.sudoku100.com/img-id/500?width=800&format=png`
- `https://www.sudoku100.com/sudoku-img?difficulty=medium&width=600&format=webp`

## 难度级别

| 级别 | 描述 | 提示数量 |
|-------|-------------|------------|
| beginner | 初学者 | 45-50 |
| easy | 简单 | 38-44 |
| medium | 中等 | 32-37 |
| hard | 困难 | 26-31 |
| expert | 专家 | 20-25 |
| extreme | 极端 | 17-19 |

## 支持

如需集成支持，请通过以下方式联系我们：
- 邮箱：support@sudoku100.com
- 网站：https://www.sudoku100.com
- GitHub Issues：https://github.com/sudoku100com-create/Sudoku-generate-API/issues