# Henge-CN · 中文开发说明

> 基于 [Leviidev/Henge](https://github.com/Leviidev/Henge) 的非官方社区版本，保留原始许可证及上游作者归属。

## 当前进度（同步上游 main 开发版）

- 已加入简体中文本地化、部分动态 UI/状态翻译及 macOS 27 保守性能预设。
- 同步 Henge 0.3 与后续上游开发：新增 Mac Apps 翻译层和 Instant Resume；两项实验功能默认关闭、尚未经本 Fork 真机验证。
- 本阶段按要求**暂停 GitHub Releases 自动发布**；GitHub Actions 仍保留编译检查及 IPA/TIPA 产物。
- **仍未完成 iPhone 17 Pro Max + iOS 27.2 Beta 2 的真机 JIT、安装、macOS 27 启动与稳定性测试**，不应当作稳定版。
- 某些底层原始错误和开发者诊断日志保留英文，以避免影响故障分析。

## 下载

[Releases](https://github.com/HamizDev/Henge-CN/releases) · [Actions](https://github.com/HamizDev/Henge-CN/actions) · [英文文档](README.en.md)

Release 的 `Henge.ipa` 需要重新签名，务必保留 `get-task-allow`。备份设备及虚拟 Mac 后再试用。

## 性能预设

适合先尝试 4 vCPU、6 GB 客体内存、30 Hz 显示，并根据具体设备签名权限调整 JIT 缓存，切勿强制大内存。
已有 Lighter macOS 选项可减少桌面动态效果。实际性能优化仍需要测量译码、TLB、GPU 和内存占用。

## 后续

- [ ] 完整中文界面与用户可读错误提示，保留日志原始错误
- [ ] 验证 Release IPA 重新签名与 JIT
- [ ] 完成 iOS 27.2 Beta 2 及 macOS 27 真机兼容性测试
- [ ] 持续跟进上游性能优化和安全修复

## 许可

本 Fork 遵循 GPL-2.0-or-later，保留对应源码、贡献者署名及许可信息。
后续提交信息使用中文。
