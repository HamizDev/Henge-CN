<p align="center"><img src="docs/icon.png" width="112" height="112" alt="Henge-CN"></p>
<h1 align="center">Henge-CN</h1>
<p align="center">在 iPhone 和 iPad 上运行 macOS · 简体中文汉化及增强版</p>

**[下载开发预览 IPA](https://github.com/HamizDev/Henge-CN/releases)** · [English README](README.en.md) · [Henge 原版](https://github.com/Leviidev/Henge)

> **非官方社区 Fork**：基于 [Leviidev/Henge](https://github.com/Leviidev/Henge)。保留原始作者、贡献者、提交历史及 GPL-2.0-or-later 许可。并非原项目官方版本。

## 功能

- **简体中文界面**：逐步覆盖安装、JIT 配对、虚拟机管理、设置、运行状态与常见提示；底层诊断日志保留原文。
- **macOS 27 性能预设**：设置 → 性能 → 应用 macOS 27 均衡性能预设。将显示刷新率设置为 30 Hz 等保守参数，减少模拟渲染负担，但**不能保证彻底解决运行缓慢问题**。
- **保留上游完整功能**：安装/启动虚拟 Mac、触控输入、键鼠、文件共享等。

## 下载与安装

从 **[GitHub Releases](https://github.com/HamizDev/Henge-CN/releases)** 下载最新开发预览的 **Henge.ipa**。每次 main 分支构建成功后自动发布一个与对应提交关联的预发布版本；构建产物同时保留在 [Actions](https://github.com/HamizDev/Henge-CN/actions)。

**重要**：IPA 是未经正式签名的开发预览产物，需要通过合法侧载工具重新签名，且应保留 `get-task-allow` 以便启用 JIT。iPhone 17 Pro Max / iOS 27.2 Beta 2 仍未完成真机兼容性验收。测试前请做好数据和虚拟 Mac 的备份。

## 从源码构建

需要 Xcode 27+、`xcodegen` 及 Husk 的 iOS 编译依赖。完整构建步骤：[English README · Building](README.en.md#building)，实际流水线见 [build-henge.yml](.github/workflows/build-henge.yml)。

## 项目维护

- 后续提交说明使用 **中文**，在 GitHub 首页可直接阅读。
- 与上游保持可追踪关系，不直接覆盖已有虚拟 Mac 的磁盘或固件。
- 中文开发说明：[README.zh-CN.md](README.zh-CN.md)；验收清单：[docs/HENGE-CN.md](docs/HENGE-CN.md)。
- GPL-2.0-or-later 开源许可：[LICENSE](LICENSE)。发布 IPA 时须提供对应完整源码并保留版权信息。
