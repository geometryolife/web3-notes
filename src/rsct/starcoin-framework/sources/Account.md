# `Account.move`

## Struct

- `Account` has key
  - 每个账户都有 `Account::Account` 资源
  - `authentication_key` 当前的身份验证密钥，这可以不同于用于创建帐户的密钥。
  - `withdrawal_capability` 允许拥有此能力的任何人从帐户提款。在创建帐户时，此能力存储在此选项中。稍后可以通过 `extract_withdraw_capability` 从该字段取出，也可以通过 `restore_withdraw_capability` 归还。
  - `key_rotation_capability` 允许拥有此能力的人轮换帐户的身份验证密钥。在创建帐户时，此功能存储在此选项中。稍后可以通过 `extract_key_rotation_capability` 从该字段取出，也可以通过 `restore_key_rotation_capability` 归还。
  - `withdraw_events` 账户余额提取事件的事件句柄

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

--------

- `emit_account_deposit_event`
- `账户` `代币数量` `元数据`
- 

## Entry function

