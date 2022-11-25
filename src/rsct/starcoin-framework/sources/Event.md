# `Event.move`

## Const

- `EEVENT_GENERATOR` 事件生成器资源处于无效状态。

## Struct

- EventHandleGenerator
  - 代表计数器的资源，用于在每个帐户下生成唯一性。该资源不会有析构函数，以此来保证生成的句柄的唯一性。
  - `counter` 单调递增的计数器。
  - `addr` 账户地址。


- EventHandle
  - 事件的管理（句柄），例如：1. 其他模块可以向这个句柄发出事件。2. 存储可以用这个句柄来证明过去发生的事件总数。
  - `counter` 发送到此事件流的事件总数。
  - `guid` 此事件流的全局唯一 ID。

## Function
