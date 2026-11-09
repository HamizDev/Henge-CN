# Henge-CN 开发记录与构建验证

2026-11-09 基于上游 b537dbb918c3220a1886cf25d1725ffa218f885e。

- 目标设备：iPhone 17 Pro Max，iOS 27.2 Beta 2。
- 先使用 Xcode 27+ 按上游 README 构建全部依赖（包括 Husk），签名时保留 get-task-allow。
- 安装后核查 JIT selftest PASS，然后再创建 macOS 27 guest。
- 测试建议：4 vCPU、6GB guest 内存、30 Hz，macOS 系统内执行上游的 Lighter macOS 命令。
- macOS 27 比 Sequoia 更重。降低刷新率只是减少图形渲染开销，并不保证加速 JIT/CPU；性能改动须通过同负载基准确认。
- 不要覆盖用户的现有 Mac 虚拟磁盘，测试前先导出备份。
- 发布版必须标明测试平台、编译状态和上游 commit。

**没有执行 Xcode 编译、真机安装或性能基准，因此目前只有源码修改，没有已验证的 IPA。**