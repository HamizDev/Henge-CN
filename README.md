<p align="center"><img src="docs/icon.png" width="112" height="112" alt="Henge-CN"></p>
<h1 align="center">Henge-CN</h1>
<p align="center">在 iPhone 和 iPad 上运行 macOS · 同步上游开发分支的简体中文增强版</p>

**[下载开发预览 IPA](https://github.com/HamizDev/Henge-CN/releases)** · [English README](README.en.md) · [Henge 原版](https://github.com/Leviidev/Henge)

> **非官方社区 Fork**：基于 [Leviidev/Henge](https://github.com/Leviidev/Henge)。保留原始作者、贡献者、提交历史及 GPL-2.0-or-later 许可。并非原项目官方版本。

## 功能

- **简体中文界面**：逐步覆盖安装、JIT 配对、虚拟机管理、设置、运行状态与常见提示；底层诊断日志保留原文。
- **macOS 27 性能预设**：设置 → 性能 → 应用 macOS 27 均衡性能预设。将显示刷新率设置为 30 Hz 等保守参数，减少模拟渲染负担，但**不能保证彻底解决运行缓慢问题**。
- **同步上游最新开发代码**：保留 macOS 0.3 的虚拟机功能，并引入实验性的 Instant Resume 与免完整 macOS 启动 Mac Apps 兼容层（两项功能默认关闭）。
- **关于本机身份（可选）**：每台虚拟 Mac 的设置可选择在 macOS「关于本机」显示当前 iPhone/iPad 的设备名称与芯片；也可单独开启实验性的型号标识符映射。两个选项默认关闭，只修改启动期间的虚拟设备信息，不更改实际设备或虚拟磁盘。

- **内存保护和可选 TLB 优化**：参考上游 [#214](https://github.com/Leviidev/Henge/pull/214) 与 [#218](https://github.com/Leviidev/Henge/pull/218)。小内存设备默认采用保守的客体 RAM 上限与 JIT 缓存默认值；不改写已有虚拟 Mac 设置。两项跨核同步实验开关默认关闭，可独立测试并关闭。没有引入静音后台保活、自动 balloon 回收或未合并的 TLB 竞态判断改动。

## 下载与安装

**本次上游同步暂不发布新 Release**。现有 [Releases](https://github.com/HamizDev/Henge-CN/releases) 的 #20 仍为上一版。同步后的源码通过 [GitHub Actions](https://github.com/HamizDev/Henge-CN/actions) 编译检查；成功构建的 IPA/TIPA 仅保留为 Actions 产物。

**重要**：IPA 是未经正式签名的开发预览产物，需要通过合法侧载工具重新签名，且应保留 `get-task-allow` 以便启用 JIT。iPhone 17 Pro Max / iOS 27.2 Beta 2 仍未完成真机兼容性验收。测试前请做好数据和虚拟 Mac 的备份。

## 从源码构建

需要 Xcode 27+、`xcodegen` 及 Husk 的 iOS 编译依赖。完整构建步骤：[English README · Building](README.en.md#building)，实际流水线见 [build-henge.yml](.github/workflows/build-henge.yml)。

## 项目维护

- 后续提交说明使用 **中文**，在 GitHub 首页可直接阅读。
- 与上游保持可追踪关系，不直接覆盖已有虚拟 Mac 的磁盘或固件。
- 中文开发说明：[README.zh-CN.md](README.zh-CN.md)；验收清单：[docs/HENGE-CN.md](docs/HENGE-CN.md)。
- GPL-2.0-or-later 开源许可：[LICENSE](LICENSE)。发布 IPA 时须提供对应完整源码并保留版权信息。
