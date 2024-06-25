# todo-linter-demo

An exploration of different ways to build a TODO linter, including:

- [trunk-toolbox](#trunk-toolbox)
- [custom `grep` linter](#grep-linter)
- [CSpell](#cspell)
- [codespell](#codespell)
- [Vale](#vale)
- [Semgrep](#semgrep)

## Prerequisites

[Install Trunk](https://docs.trunk.io/check/usage) and run `trunk tools install`

## Use it yourself!

To import the todo rulesets automatically into any other repo, simply add the following to your `.trunk/trunk.yaml`:

```yaml
plugins:
  sources:
    - id: todo-linters
      ref: v0.1.0
      uri: https://github.com/trunk-io/todo-linter-demo
```

## CSpell

This CSpell linter setup is dependent on:

- `cspell.yaml`

```bash
trunk check --filter=cspell test_data.md
```

To run outside Trunk, run:

```bash
.trunk/tools/cspell --no-summary test_data.md
```

## codespell

This codespell linter setup is dependent on:

- `.codespellrc`
- `todo_dict.txt`

```bash
trunk check --filter=codespell test_data.md
```

To run outside Trunk, run:

```bash
.trunk/tools/codespell test_data.md
```

## Vale

This Vale linter setup is dependent on:

- `.vale.ini`
- `styles/base/todo.yml`

```bash
trunk check --filter=vale test_data.md
```

To run outside Trunk, run:

```bash
.trunk/tools/vale --output=line test_data.md
```

## Semgrep

This Semgrep linter setup is dependent on:

- `.semgrep.yaml`

```bash
trunk check --filter=semgrep test_data.md
```

To run outside Trunk, run:

```bash
.trunk/tools/semgrep --config=auto --config=.semgrep.yaml -q --include=test_data.md
```

## trunk-toolbox

This trunk-toolbox linter setup is dependent on:

- `toolbox.toml`

To run with Trunk, run:

```bash
trunk check --filter=trunk-toolbox test_data.md
```

To run outside Trunk, run:

```bash
.trunk/tools/trunk-toolbox --output-format=text test_data.md
```

## grep linter

This grep linter setup is dependent on:

- `todo_grep.sh`

To run with Trunk, run:

```bash
trunk check --filter=todo-grep-wrapped test_data.md
```

To run outside Trunk, run:

```bash
./todo_grep.sh test_data.md
```
