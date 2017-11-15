#!/usr/bin/env bash

# Install Slather
sudo gem install slather

# Use Slather to generate test coverage
slather coverage -x --scheme "$BUDDYBUILD_SCHEME" -i "$BUDDYBUILD_WORKSPACE/FrisbeeTests/\*" --build-directory "$BUDDYBUILD_TEST_DIR/Build/Intermediates.noindex" --output-directory "$BUDDYBUILD_TEST_DIR/coverage" "$BUDDYBUILD_WORKSPACE/Frisbee.xcodeproj"

# Upload results to Codecov
bash <(curl -s https://codecov.io/bash) -f "$BUDDYBUILD_TEST_DIR/coverage/cobertura.xml" -X coveragepy -X gcov -X xcode -t $CODECOV_REPO_TOKEN
