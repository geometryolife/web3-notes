# 第二讲 Move 语法基础与实践

## 课程目标

- 掌握 Move 相关基础知识
  - 为什么学习 Move
  - Move 的开发环境搭建
  - Move 的数据类型
  - 作用域和生命周期
  - Move 的函数
- 掌握 Move 小型案例的编写能力

## Move 的结构

- Modules
  - 结构化定义
  - 函数功能
  - 全局存储
- Scripts
  - 暂时的代码片段
  - 可以调用 Modules 的函数
  - 一个 Script 内只能有一个函数

## 第一个 Move 程序

```move
script {
  use 0x1::Debug; // import Debug module

  // main just a function name
  fun main() {
    let num: u64 = 1024;
    Debug::print(&num);
  }
}
```

## 三种数据类型

- 整型
  - u8、u64、u128
- 布尔值
  - bool: true 或 false
- 地址
  - address 是 Move 的地址类型，它与 Solidity 中的 address 类型没有关系，作用也不太一样
  - Std、0x1、Sender 等都是 address 类型

## 变量的四种定义方式

- 类型推导 & 赋值
  - `let a = 10;`
- 显式定义 & 赋值
  - `let b: u64 = 11;`
- 值 + 类型表示
  - `let c = 5u128`
- 先声明后赋值
  - `let d: u8;`
  - `d = 13;`
