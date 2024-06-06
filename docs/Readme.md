# Node-Path-Action

| Languages/語言         | ID         |
| ---------------------- | ---------- |
| English                | en-Latn-US |
| [中文](./Readme-zh.md) | zh-Hans-CN |

## Q&A

### Q1: What is this used for?

A1: It's used to obtain the file path for the NodeJS that comes with the Github Actions Runner.

### Q2: What was the original intention behind creating this action?

A2:

I wanted to write actions in Rust, compile them into WebAssembly (WASM), and then invoke them using NodeJS.

Unfortunately, not all systems come with NodeJS pre-installed.

- If it's your own machine, you can simply add the PATH.
- However, if you're sharing actions with others, it's best not to make significant changes to the system environment.

Fortunately, we can use the NodeJS that comes with the Runner.

> The Runner's built-in NodeJS is located in the `externals` directory, such as `/path/to/runners/externals/node20/bin/node`.

## Quick Start

### Example 1

```yaml
name: test
on: push

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - id: node_path
        uses: 2moe/node-path-action@v20
      - run: printf "${{steps.node_path.outputs.exe}}\n"
```

### Example 2

```yaml
name: test
on: push

jobs:
  test:
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

- To get the file path for NodeJS 16, change `@v20` in **2moe/node-path-action@v20** to `@v16`

---

If you’re using Github Runners instead of self-hosted runners, you don’t need to use this action. You can directly use Node as a shell.

```yaml
      - name: Hello World
        shell: node {0}
        run: console.log("Hello world")
```
