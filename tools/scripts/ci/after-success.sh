#!/bin/bash

# Script which always runs when the current Travis mode succeeds.
# Used to run the travis-after-modes script, which checks if all other modes finished.

# Go to the project root directory
cd $(dirname $0)/../../..

# Use @DevVersion npm plugin Travis-After-Modes to
# confirm all Travis jobs completed successfully see .travis.yml

npmBin=$(npm bin)
ciResult=$($npmBin/travis-after-modes)

if [ "$ciResult" = "PASSED" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
  echo "All travis modes passed. Publishing the build artifacts..."
  ./tools/scripts/release/publish-build-artifacts.sh
fi
