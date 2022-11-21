# `starcoin-framework/sources/Block.move`

## Struct

- Checkpoint
  - `block_number` 区块编号
  - `block_hash` 区块哈希
  - `state_root` 块的状态根

- Checkpoints
  - `checkpoints` 所有检查点
  - `index` 索引
  - `last_number` 最后的编号

## Entry function

- checkpoint_entry
  - 调用 `checkpoint`

```move
public (script) fun checkpoint_entry(_account: signer) acquires BlockMetadata, Checkpoints
```

## Function

- `checkpoint`
  - `parent_block_number` 获取父块高度
  - `parent_block_hash` 父块哈希
  - `checkpoints` <++>

  - `base_checkpoint(checkpoints, parent_block_number, parent_block_hash)`

