---
name: warp-uu-split-tunnel
description: 自动检测网易 UU 远程 (GameViewer.exe) 使用的目标 IP，并将其添加到 Cloudflare WARP 的排除名单中，以解决开启 WARP 后 UU 远程卡顿的问题。
---

# WARP UU Remote Split Tunnel Skill

This skill is designed to solve the issue of NetEase UU Remote (GameViewer) running slowly when Cloudflare WARP is enabled on Windows.

## 给 AI 助手的指令 (Instructions for AI)

当用户抱怨“开启 Cloudflare WARP 后，UU 远程/网易 UU/GameViewer 变得很卡或速度很慢”时，请按照以下步骤执行：

1. **背景解释**：向用户简要解释 Windows 消费者版的 Cloudflare WARP 不支持“基于应用名称的分流”，但你可以通过动态提取 IP 的方式帮他们解决。
2. **前置检查**：提醒用户必须先**启动 UU 远程（GameViewer.exe）并保持连接状态**，以便提取到外网 IP。
3. **执行脚本**：直接运行本目录下的 `Exclude-UURemoteWARP.ps1` PowerShell 脚本。
4. **反馈结果**：
   - 脚本会自动使用 `Get-NetTCPConnection` 找到连接的 IP 并调用 `warp-cli tunnel ip add` 将其排除。
   - 脚本运行结束后，向用户报告被成功排除的 IP 地址。
   - 告知用户问题已解决，可以立刻体验满速连接。

## 文件依赖
- `Exclude-UURemoteWARP.ps1`: 核心自动排除脚本。
- `README.md`: 供人类阅读的使用说明文档。
