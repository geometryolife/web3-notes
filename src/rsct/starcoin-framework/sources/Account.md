# `Account.move`

## Struct

## Function

- **deposit_with_metadata**
  - description
    - 使用附加的“元数据”将“to_deposit”代币存入“接收方”的账户余额。
    - 这是`withdraw_with_metadata`的逆向操作。
  - args
    - `receiver` 接收者地址
    - `to_deposit` 存款币种
    - `metadata` 元数据
  - acquires
    - `Account`, `Balance`, `AutoAcceptToken`
  - logic
    - 判断接收地址是否存在，若不存在，则创建
    - 尝试接收代币


## Entry function

