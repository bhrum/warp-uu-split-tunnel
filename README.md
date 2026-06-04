# WARP UU Remote Split Tunnel (Cloudflare WARP + 网易 UU 远程 分流脚本)

[English](#english) | [中文](#中文)

---

## 中文

### 简介
当你使用免费版（消费者版）的 Cloudflare WARP (1.1.1.1) 时，它会默认接管 Windows 系统上的所有网络流量。由于 Windows 版本的免费 WARP 客户端**不支持基于应用程序（App-Based）的代理分流**，这会导致“网易 UU 远程”（GameViewer）的数据也经过国外的代理节点，从而造成远程连接异常缓慢和卡顿。

本仓库提供了一个自动化的 PowerShell 脚本。该脚本会自动检测当前正在运行的“UU 远程”进程及其连接的外网 IP 地址，并将这些 IP 动态添加到 Cloudflare WARP 的**直连排除名单（Split Tunnels）**中，从而完美解决 UU 远程速度慢的问题。

### 功能特色
- 🚀 **自动化获取**：自动读取 `GameViewer.exe` 当前建立的 TCP 网络连接。
- 🛡️ **动态排除**：将检测到的目标 IP 自动注入 Cloudflare WARP 的路由排除表，实现动态分流。
- 💻 **零依赖**：纯 PowerShell 脚本，无需安装额外的第三方依赖。

### 使用方法
1. **启动 UU 远程**：打开“网易 UU 远程”客户端，并建立一次远程连接（确保有网络流量产生）。
2. **运行脚本**：
   - 下载本仓库中的 `Exclude-UURemoteWARP.ps1`。
   - 鼠标右键点击该脚本文件，选择 **“使用 PowerShell 运行” (Run with PowerShell)**。
3. **完成**：脚本会自动找出 IP 并设置好 WARP，之后你的 UU 远程就会恢复满速（不再走 WARP 代理）。

### 注意事项
- 当 UU 远程下次连接到了不同的服务器，或者 P2P 连接到了不同 IP 的新设备时，如果再次遇到速度变慢的情况，只需重新运行一次本脚本即可。
- 本脚本需要已安装 Cloudflare WARP 官方客户端，并且 `warp-cli.exe` 位于默认路径下。

---

## English

### Introduction
When using the free consumer version of Cloudflare WARP (1.1.1.1) on Windows, it takes over all your network traffic by default. Since the consumer Windows client **lacks App-Based Split Tunneling**, traffic from "NetEase UU Remote" (GameViewer) is routed through overseas proxy nodes, leading to severe latency and slow remote desktop connections.

This repository provides an automated PowerShell script that dynamically detects the active external IP addresses connected by the UU Remote process, and adds them to Cloudflare WARP's **Split Tunnels** exclusion list. This effectively bypasses the proxy for UU Remote, resolving the latency issues.

### Features
- 🚀 **Automated Detection**: Automatically reads active TCP network connections for `GameViewer.exe`.
- 🛡️ **Dynamic Exclusion**: Injects the detected target IP addresses directly into Cloudflare WARP's routing exclusion table.
- 💻 **Zero Dependencies**: Pure PowerShell script, requiring no third-party installations.

### How to Use
1. **Start UU Remote**: Open the "NetEase UU Remote" client and initiate a remote connection (to ensure network traffic is established).
2. **Run the Script**:
   - Download the `Exclude-UURemoteWARP.ps1` script from this repository.
   - Right-click the file and select **"Run with PowerShell"**.
3. **Done**: The script will automatically find the IPs and configure WARP. Your UU Remote connection will now bypass the WARP proxy and operate at full speed.

### Notes
- If UU Remote connects to different relay servers or P2P devices in the future and slows down again, simply re-run the script to update the exclusion list.
- Requires the official Cloudflare WARP desktop client to be installed, with `warp-cli.exe` located in the default installation path.
