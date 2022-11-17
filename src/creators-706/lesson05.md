# NFT 合约与 DApp 的实现

- Aptos 命令行工具使用
- 如何使用 managed——coin 发币
- coin 合约讲解
- 使用 petra 钱包与合约交互

Materials:

- Aptos-Simple-Coin：https://github.com/hqwangningbo/Aptos-Simple-Coin

## Aptos cli

1. 安装

安装Aptos https://github.com/aptos-labs/aptos-core/releases

2. 启动本地测试网

```shell
# 清除状态并从创世纪的新链开始
aptos node run-local-testnet --force-restart --with-faucet
```

3. 生成测试账户

```shell
# 生成公钥、私钥文件
aptos key generate --output-file <IDENTITY>

# For example
aptos key generate --output-file ../aptos-account/alice
aptos key generate --output-file ../aptos-account/bob
```

Petra 钱包：https://chrome.google.com/webstore/detail/petra-aptos-wallet/ejjladinnckdgjemekebdpeokbikhfci

4. 领取水龙头激活账户

- 使用 `curl` 向 Aptos 的水龙头发送 HTTP 请求，领取测试币
- `--location` 代表跟随重定向
- `--request` 指定请求方法为 `POST`
- 铸币请求需要传递两个参数：`amount` 和 `address`
- Aptos 的代币精度为 8 位

```shell
curl --location --request POST 'http://127.0.0.1:8081/mint?amount=<AMOUNT>&address=<ADDRESS>'

# For example
curl --location --request POST 'http://127.0.0.1:8081/mint?amount=100000000&address=0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410'
curl --location --request POST 'http://127.0.0.1:8081/mint?amount=100000000&address=0x5f7d5f85125ccfde8331f45e1dd3b9e4145a5b218b23711a90667713db484d36'
```

5. 合约相关

```shell
# 新建 move 项目
mkdir <PROJECT_NAME> && <PROJECT_NAME>
aptos move init --name <PROJECT_NAME>
```

```shell
# 编译 move
aptos move compile
```

```shell
# 测试
aptos move test
```

```shell
# 部署合约
aptos move publish --named-addresses <NAMED_ADDRESSES>=<ADDRESS> --private-key-file <PRIVATE_KEY_FILE_PATH> --url http://127.0.0.1:8080

# For example
aptos move publish --named-addresses simple_coin_1=0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410 --private-key-file ../../aptos-account/alice --url http://127.0.0.1:8080
```

```shell
# 调用合约
<FUNCTION_ID> => <ADDRESS>::<MODULE_NAME>::<FUNCTION_NAME>
aptos move run --function-id <ADDRESS>::<MODULE_NAME>::<FUNCTION_NAME> --private-key-file <PRIVATE_KEY_FILE_PATH> --url http://127.0.0.1:8080

# For example
aptos move run --function-id 0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410::SimpleCoin::issue --private-key-file ../../aptos-account/alice --url http://127.0.0.1:8080
```

## 如何发币

Aptos move 仓库：https://github.com/aptos-labs/aptos-core/tree/main/aptos-move/framework

想在 Aptos 开发 move 得心应手，一定得熟悉 aptos move 代码库，例如 timestamp 获取时间戳，block 获取当前区块高，math 数学库，event 事件等等，源码是最好的教程。

`aptos_framework` 部署在 `0x1` 地址下，带有 `entry` 可以直接使用命令行调用，例如：`0x1::coin::transfer`

调用命令：

1. `aptos move run --function-id`
2. `--args`：指定参数，注意要加类型，string:<STRING>，`vector<u8>` 类型使用 `string:"USDT"`，其他 `u8`、`bool` 等
3. `--type-args`：如果方法带有泛型，注意要加，如 `managed_coin` 下的 `initialize` 方法，需指定 `coin` 类型

- initialize

```shell
aptos move run --function-id 0x1::managed_coin::initialize --args string:"USDT" string:"USDT" u8:8 bool:true --type-args 0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410::SimpleCoin1::USDT --private-key-file ../../aptos-account/alice --url http://127.0.0.1:8080
```

- register

```shell
aptos move run --function-id 0x1::managed_coin::register --type-args 0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410::SimpleCoin1::USDT --private-key-file ../../aptos-account/alice --url http://127.0.0.1:8080
```

- mint

```shell
aptos move run --function-id 0x1::managed_coin::mint --args address:0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410 u64:10000000000 --type-args 0x9ac5e69d07766b31933bf6cdb7bb0c78095b5e2866164ba90b9a604dfc11e410::SimpleCoin1::USDT --private-key-file ../../aptos-account/alice --url http://127.0.0.1:8080
```

## Aptos 钱包交互讲解

https://github.com/hqwangningbo/Aptos-Simple-Coin/blob/master/simple_coin_template/src/SimpleCoin.jsx

```javascript
    connectWallet = async () => {
        const response = await window.aptos.connect()
        console.log(response.address)
        this.setState({ address: response.address });
    }
    issue = async () =>{
        const transaction = {
            type: "entry_function_payload",
            function: issue,
            arguments: [],
            type_arguments: [],
        };
        await window.aptos.connect()
        let ret = await window.aptos.signAndSubmitTransaction(transaction);
        console.log('ret', ret.hash);
        this.setState({
            address: this.state.address ,
            hash:ret.hash
        });
    }
    register = async () =>{
        const transaction = {
            type: "entry_function_payload",
            function: register,
            arguments: [],
            type_arguments: [],
        };
        await window.aptos.connect()
        let ret = await window.aptos.signAndSubmitTransaction(transaction);
        console.log('ret', ret.hash);
        this.setState({
            address: this.state.address,
            hash:ret.hash
        });
    }
    transfer = async () =>{
        const transaction = {
            type: "entry_function_payload",
            function: transfer,
            arguments: ["0xd8f6f1195aad9e39a3bd4bfe98a682bc6e6618b8640cf39c26f79a42863d6172","10"],
            type_arguments: [coinType],
        };
        await window.aptos.connect()
        let ret = await window.aptos.signAndSubmitTransaction(transaction);
        console.log('ret', ret.hash);
        this.setState({
            address: this.state.address,
            hash: ret.hash,
        });
    }
```
