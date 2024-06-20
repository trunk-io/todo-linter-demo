#!/bin/bash

set -euo pipefail

LINT_TARGET="${1}"

TODO_REGEX="TODO\W"
GREP_FORMAT="([^:]*):([0-9]+):(.*)"
PARSER_FORMAT="\1:\2:0: [error] Found TODO in line (TODO)"

grep -o -E "${TODO_REGEX}" --line-number --with-filename "${LINT_TARGET}" | sed -E "s/${GREP_FORMAT}/${PARSER_FORMAT}/"
