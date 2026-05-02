#!/usr/bin/env bash
#
# Fail fast and safely.
# -e: exit immediately if a command exits with a non-zero status.
# -u: treat unset variables as an error and exit immediately.
# -o pipefail: fail if any command in a pipeline fails.
set -euo pipefail

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Check with:
# $ nvm -v

# Check https://nodejs.org/en/about/previous-releases.
# Then install some node.js version with:
# $ nvm install 22
# $ nvm use 22
# Check with:
# $ node -v
# $ npm -v
