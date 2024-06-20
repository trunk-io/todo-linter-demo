#!/bin/bash

# mastodon

set -euo pipefail

LINT_TARGET="${1}"

TODO_REGEX="TODO"
GREP_FORMAT="([^:]*):([0-9]+):(.*)"
PARSER_FORMAT="\1:\2:0: [error] Found \3 in line (TODO)"

grep -o -E -i "${TODO_REGEX}" --line-number --with-filename "${LINT_TARGET}" | sed -E "s/${GREP_FORMAT}/${PARSER_FORMAT}/"
