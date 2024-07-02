#!/bin/bash

set -euo pipefail

# Uses https://github.com/charmbracelet/freeze/pull/113
freeze_path="${FREEZE:-freeze}"
trunk_path=../trunk/bazel-bin/trunk/cli/cli

function freeze_linter() {
	${freeze_path} --theme=catppuccin-mocha --execute-non-zero -o "${2}" --execute "bash -c 'echo $ ${1}; ${1}'"
}

function freeze_trunk() {
	# freeze does not support ending with an ANSI escape code, so add empty text
	# Also modify the color codes to work better for freeze's themes.
	${freeze_path} --theme=catppuccin-mocha --execute-non-zero -o "${2}" --execute "bash -c 'echo $ ${1/${trunk_path}/trunk}; ${1} --no-progress --show-existing --upstream=false | sed s/✖/x/ | sed s/30m/104m/; echo -n \" \"'"
}

mkdir -p screenshots

# Requires a pre-release version of Trunk
freeze_trunk "${trunk_path} check --filter=markdownlint test_data.md" "screenshots/markdownlint_trunk.png"
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
