#!/bin/bash

set -euo pipefail

function freeze_linter() {
	freeze --theme=dracula -o "${2}" --execute "bash -c 'echo $ ${1}; ${1} || true'"
}

function freeze_trunk() {
	freeze --theme=dracula -o "${2/tb/trunk}" --execute "bash -c '${1} --no-progress --show-existing'"
}

mkdir -p screenshots

# Requires a pre-release version of Trunk
tb=../trunk/bazel-bin/trunk/cli/cli
freeze_trunk "${tb} check --filter=markdownlint test_data.md" "screenshots/markdownlint_trunk.png"
freeze_linter ".trunk/tools/markdownlint -r markdownlint-rule-search-replace test_data.md" "screenshots/markdownlint.png"

freeze_trunk "trunk check --filter=cspell test_data.md" "screenshots/cspell_trunk.png"
freeze_linter ".trunk/tools/cspell --no-summary test_data.md" "screenshots/cspell.png"

freeze_trunk "trunk check --filter=codespell test_data.md" "screenshots/codespell_trunk.png"
freeze_linter ".trunk/tools/codespell test_data.md" "screenshots/codespell.png"

freeze_trunk "trunk check --filter=vale test_data.md" "screenshots/vale_trunk.png"
freeze_linter ".trunk/tools/vale --output=line test_data.md" "screenshots/vale.png"

freeze_trunk "trunk check --filter=semgrep test_data.md" "screenshots/semgrep_trunk.png"
freeze_linter ".trunk/tools/semgrep --config=auto --config=.semgrep.yaml -q --include=test_data.md" "screenshots/semgrep.png"

freeze_trunk "trunk check --filter=trunk-toolbox test_data.md" "screenshots/toolbox_trunk.png"
freeze_linter ".trunk/tools/trunk-toolbox --output-format=text test_data.md" "screenshots/toolbox.png"

freeze_trunk "trunk check --filter=todo-grep-wrapped test_data.md" "screenshots/grep_trunk.png"
freeze_linter "./todo_grep.sh test_data.md" "screenshots/grep.png"
