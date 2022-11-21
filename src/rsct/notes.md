# 随记

- `starcoin-framework = {git = "https://github.com/starcoinorg/starcoin-framework", rev = "0fb8810d08875fdd0bf319755ab031f31b1be441"}` 在 `rev` 中使用哈希值而非标签确保依赖稳定。

- Move 会检查每个函数是否有对应的形式化验证，所以每个函数都要添加 `spec`，除非关闭整个模块的形式化验证。

- `exp` 文件的作用？
  - `.exp` 文件是基准文件，用来检查集成测试是否有变化，这样可以知道 测试时候影响了什么，如果对以前有兼容问题，有些 test 是通过不了的。

- 现在的 gas 是怎么计算得来的？
  - 实际 vm 里跑出来的，集成测试的时候底层起了个模拟（mock）链，真实地跑了整个的交易。
