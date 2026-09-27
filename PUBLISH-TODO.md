# 发布待办与阻塞项（2026-09-27）

> 本文件记录 Skill/MCP 平台发布的当前状态、未完成事项及解锁路径。
> 已生效进展同步记录在 `../operations/seo-automation/SEO-优化与外链行动计划.md`。

## 一、已完成（本轮）

| 事项 | 结果 |
|------|------|
| 仓库重构推送 GitHub | ✅ `0933985`（skill 重构 SKILL.md 结构、删落地页、v1.1.0）+ `3a18282`（skill 脚本 CLI 入口）均已推送到 main |
| 版本号对齐 | ✅ package.json / server.json / skill JS 统一 1.1.0 |
| awesome-claude-skills PR | ✅ [PR #2017](https://github.com/ComposioHQ/awesome-claude-skills/pull/2017) 已创建（75.7k Star，「Creative & Media」分类），待审核 |
| PulseMCP 状态核实 | ✅ 官方暂停收稿（2026-09-03 起），恢复后自动抓取 Official Registry |

## 二、待审核中的 PR（无需操作，等结果）

| PR | 仓库 | 提交日 | 状态 | 备注 |
|----|------|--------|------|------|
| [#2017](https://github.com/ComposioHQ/awesome-claude-skills/pull/2017) | ComposioHQ/awesome-claude-skills | 2026-09-27 | OPEN | 本轮新提交 |
| [#14743](https://github.com/punkpeye/awesome-mcp-servers/pull/14743) | punkpeye/awesome-mcp-servers | 2026-09-20 | OPEN | 维护者要求先在 glama.ai 提交并加 badge（见下 Glama 条目） |
| [#258](https://github.com/Prat011/awesome-llm-skills/pull/258) | Prat011/awesome-llm-skills | 2026-09-22 | OPEN | 「Skills with MCP」分类 |

## 三、未搞定（按解锁顺序排列）

### 🚨 阻塞项 1：MCP Server 不是真实现（最优先）

`mcp/sudoku-api-mcp.js` 只是一个导出普通对象的 JS 模块，**没有 stdio JSON-RPC 协议实现**，`package.json` 也没有 `bin` 字段。任何「真实可运行」的平台收录检测都会失败。

**解锁路径**：
1. 用官方 SDK 重写：`npm install @modelcontextprotocol/sdk zod`
2. 实现 stdio server，注册 3 个工具（generate_sudoku / get_sudoku_by_id / list_difficulties），可直接复用 `skill/scripts/sudoku-api-skill.js` 的校验与 URL 构造逻辑
3. `package.json` 增加 `"bin": { "sudoku-api-mcp": "./mcp/sudoku-api-mcp.js" }`
4. 本地验证：`npx @modelcontextprotocol/inspector node mcp/sudoku-api-mcp.js`

### 🚨 阻塞项 2：npm 包从未发布

`sudoku-api-mcp` 在 npmjs.com 上是 404，`server.json` 里写的 `npx -y sudoku-api-mcp` 目前不可用。

**解锁路径**（需人工）：
1. 完成 MCP Server 真实现（阻塞项 1）
2. `npm login`（需要人工浏览器授权，AI 无法代办）
3. `npm publish --access public`
4. 验证：`npx -y sudoku-api-mcp` 能启动

### ⏸ 阻塞项 3：Glama 提交（卡着 PR #14743 的合并条件）

提交入口 https://glama.ai/mcp/servers → "Add Server" 需要 Glama 账号登录，浏览器无已有会话。

**解锁路径**（需人工）：注册/登录 Glama → Add Server → 提交 GitHub 仓库 URL → 收录后把 badge 加回 awesome-mcp-servers PR #14743 → 催维护者合并。

### ⏸ 阻塞项 4：Official MCP Registry

前置条件：npm 包已发布（阻塞项 2）。

**解锁路径**：
1. `npm install -g @modelcontextprotocol/mcp-publisher`
2. `mcp-publisher login github`
3. `mcp-publisher publish`
4. PulseMCP 恢复收稿后会自动抓取此 Registry

### ⏸ 阻塞项 5：Smithery

要求已部署的**远程** MCP 端点（非本地 stdio）。需先把 MCP server 部署成 HTTP 服务（可考虑 Cloudflare Workers / Vercel），再 `smithery mcp publish "https://<endpoint>/mcp"`。优先级最低。

### ✗ 已排除的路线（无需再尝试）

| 平台 | 结论 |
|------|------|
| openai/skills | 仓库已废弃，官方迁移至 openai/plugins（Codex plugin 格式，需 `.codex-plugin/plugin.json`）——如要做 OpenAI 官方生态，需按 plugin 格式另起，暂缓 |
| anthropics/skills | 官方演示库，不收第三方 skill；社区入口已走 awesome-claude-skills（PR #2017） |
| PulseMCP | 官方暂停收稿（2026-09-03），恢复后自动抓取 Official Registry，无需主动提交 |
| mcp.so | 提交入口走 GitHub Issue（publish-mcp.sh 有引导）；线上尚无 sudoku 条目，可等 npm 包发布后再提 |

## 四、网络备注

本机访问 github.com（443/git 协议）频繁超时（HTTP2 framing 错误），本轮推送多次失败后用 `git -c http.version=HTTP/1.1 push` 成功。后续推送失败时优先尝试此参数。
