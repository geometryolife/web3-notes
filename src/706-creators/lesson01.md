# 第一讲 Counter 合约与 dApp 的实现

- Bounties - Learn2Earn
- Lessons - 实战课
- [Challenges - 学习成功检验](https://github.com/NonceGeek/Web3-dApp-Camp/discussions/categories/projects-others)

## Counter-DApp 实践

- Lecturer
  - 叶开 @yekai1003

- Goal
  - Complete DApp action of `Counter`
    - Practice of `Counter` contracts
    - Environment configuration
    - Run the DApp

## Move 的四种类型能力

- `copy` - 可以被复制
- `drop` - 可以被丢弃
- `key` - 可以作为键值
- `store` - 可以存储到全局状态

原生数据类型默认具备：copy、drop、store

## 自定义结构

- 语法
  ```move
  struct NAME {
    FIELD1: TYPE1,
    FIELD2: TYPE2,
    ...
    FIELDn: TYPEn
  }
  ```

- 规则
  - 字段个数 0~65535
  - 字段类型可以是原生类型或自定义类型，不允许类型递归

## Signer

- Signer 代表发送交易的人
- 一种原生的数据类型
- 只有一种能力：drop
  - `struct signer has drop { a: address }`
- 不能在代码中创建，必须通过脚本调用传递
- 后面的知识点与 Signer 有关

## 什么是资源

- 资源（resource）是被限制了能力的结构
- 资源只能拥有 `key` 和 `store` 两种能力
- 资源必须存储在账户下
- 一个账户同一时刻只能容纳一个资源

## 资源相关 API

- `move_to<T>(&Signer, T)`
- `move_from<T>(address): T`
- `borrow_global_mut<T>(address): &mut T`
- `borrow_global<T>(address): &T`
- `exists<T>(address): bool`

## Counter 合约的设计与实现

- 需求
  - 初始化
  - 查询
  - 增长

### Counter 合约

- 模块函数 - 由脚本函数调用
- 脚本函数 - 可以被外部直接调用

- 外部 -> Script -> Module

- `address_of` 获取地址，因为 `borrow_global_mut<T>(address` 接收的是 address 而非 signer

## 使用 Move Playground

- https://playground.pontem.network

## 测试案例如何编写

- 一个 script 块只能写一个函数

## 配置文件修改

## StarMask
