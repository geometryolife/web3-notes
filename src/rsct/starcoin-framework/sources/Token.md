# `Token.move`

## Function

- token_code
  - 返回已注册代币的代币代码。
  - `let (addr, module_name, name) = name_of<TokenType>();`
  - Return -> `TokenCode { addr, module_name, name }`

- zero
  - 创建一个值为 0 的新 `Token::Token<TokenType>`
  - -> `Token<TokenType> { value: 0 }`

## Native function

- name_of
  - `native fun name_of<TokenType>(): (address, vector<u8>, vector<u8>);`
  - 返回 Token 的模块地址、模块名称和 TokenType 的类型名称。
  - 从泛型中解析
