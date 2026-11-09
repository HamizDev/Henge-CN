# Henge-CN · 简体中文及增强版

> 非官方社区版本，基于 [Leviidev/Henge](https://github.com/Leviidev/Henge)。本项目与原作者没有官方关联，遵循 GPL-2.0-or-later，保留原有提交历史、版权声明与贡献者署名。

## 状态

本 Fork 已集成首批中文资源和可选 macOS 27 均衡性能预设，补充了安装步骤与 JIT 引导的动态文本本地化。**当前仍是部分汉化；尚未通过 Xcode 编译及 iPhone 17 Pro Max（iOS 27.2 Beta 2）真机验证，不应视为稳定中文版。**

### 功能
- 简体中文（zh-Hans）本地化，保留英文回退，逐步覆盖安装、JIT、设置、虚拟 Mac 管理。
- 设置 → 性能中的 macOS 27 均衡性能预设：30 Hz、关闭实验性超级块和空闲忙等、采用原上游的安全缓存大小。
- 继承上游模拟器引擎与 JIT 代码，不修改用户磁盘或固件。

### 待验证
- [ ] Xcode 27、Husk 依赖和恢复栈完整编译，产出 IPA
- [ ] iPhone 17 Pro Max / iOS 27.2 Beta 2：JIT 自检、macOS 27 安装、启动、关机
- [ ] 完整动态字符串和错误信息汉化
- [ ] 独立定位 CPU/JIT、TLB、GPU 和 I/O 性能热点
- [ ] 安全地追踪和合并 Henge 上游更新

## 构建

查看原版 [README.md](README.md) 的 Building 部分：Xcode 27+、xcodegen、Husk 依赖、restore stack、C 引擎、IPA 打包和签名。请勿只运行 xcodegen 就以为得到可安装的 IPA。

签名保留 get-task-allow，并在真实设备验证 JIT，未验证前不要公开标注为稳定版。

## 许可证

原作者：Leviidev 及社区贡献者。Henge 源码按 GPL-2.0-or-later 发布，本项目修改部分同许可。分发修改后的 IPA 必须履行对应源码提供和版权/许可保留义务。

为了避免自动消耗 GitHub Actions 配额，Fork 已移除自动构建工作流。