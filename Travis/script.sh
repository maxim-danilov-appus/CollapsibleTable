#!/bin/sh
set -e

xcodebuild -scheme CollapsibleTable -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.0' test
xcodebuild -scheme CollapsibleTableDemo -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.0' test