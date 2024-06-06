# Node-Path-Action

| Languages/語言         | ID         |
| ---------------------- | ---------- |
| 中文                   | zh-Hans-CN |
| [English](./Readme.md) | en-Latn-US |

## Q&A

### Q1: 这玩意儿有什么用？

A1: 用来获取 Github Actions Runner (运行器) 自带的 NodeJS 的文件路径。

### Q2: 创建这个 action 的初衷是什么？

A2:

我想要用 rust 来写 actions，然后编译成 WASM (WebAssembly)，最后用 NodeJS 来调用它。

Unfortunately, 不是所有系统都预装了 NodeJS。

- 如果是自己的机器的话，那加个 PATH 就完事了。
- 若是分享给别人的 actions，那最好不要对系统环境做太大的改动。

万幸的是，咱们可以调用 Runner 自带的 NodeJS。

> runner 自带的 node 位于 externals 目录下，比如 /path/to/runners/externals/node20/bin/node

## 快速上手

```yaml
name: test
on: push

jobs:
  test:
    # runs-on: ubuntu-latest
    runs-on: self-hosted
    steps:
      - id: node_path
        uses: 2moe/node-path-action@v20

      - name: Hello World
        shell: sh -e {0}
        run: |
          '${{steps.node_path.outputs.exe}}' <<'EOF'
            console.log("Hello world")
            throw Error("Panic")
          EOF
```

Tips:

- 将 **2moe/node-path-action@v20** 中的 `@v20` 改成 `@v16`，可以获取 NodeJS 16 的文件路径。

---

如果是 Github Actions 的 Runners，而不是自托管的运行器，则您无需使用本 action。

您可以直接将 node 作为 shell 来使用。

```yaml
      - name: Hello World
        shell: node {0}
        run: console.log("Hello world")
```
