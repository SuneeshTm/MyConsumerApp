#!/bin/bash

echo "🚀 Building MyAwesomeSDK XCFramework..."

set -e

# Clean previous builds
rm -rf build
mkdir -p build

# Build for iOS Device
xcodebuild archive \
  -scheme MyAwesomeSDK \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "build/ios_devices" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build for iOS Simulator
xcodebuild archive \
  -scheme MyAwesomeSDK \
  -configuration Release \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "build/ios_simulators" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Create XCFramework
xcodebuild -create-xcframework \
  -framework build/ios_devices.xcarchive/Products/Library/Frameworks/MyAwesomeSDK.framework \
  -framework build/ios_simulators.xcarchive/Products/Library/Frameworks/MyAwesomeSDK.framework \
  -output build/MyAwesomeSDK.xcframework

echo "✅ MyAwesomeSDK.xcframework generated successfully at build/"
