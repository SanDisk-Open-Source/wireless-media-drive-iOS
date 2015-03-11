#!/bin/sh

XCODE_BASE=/Applications/Xcode.app
RESULT_DIR="./app/MediaDriveHD.app"

cp embedded.mobileprovision "$RESULT_DIR"

$XCODE_BASE/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -std=c++11 -stdlib=libstdc++ \
 -arch armv7 -arch arm64 \
 -isysroot $XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS8.1.sdk \
 "MediaDriveHDCore.a" \
 -dead_strip -ObjC \
 -Llib -Fframeworks \
 -lc++ -lstdc++ -lz -lbz2 -liconv -lxml2 -lsqlite3 \
 -fobjc-link-runtime -miphoneos-version-min=6.0 \
 -framework ImageIO -framework CoreImage -framework QuickLook -framework QuartzCore -framework Security -framework StoreKit -framework CoreTelephony -framework CoreText -framework Accelerate -framework AddressBook -framework MobileCoreServices -framework Social -framework AdSupport -framework Accounts -framework CoreData -framework SystemConfiguration -framework CoreLocation -framework MediaPlayer -framework MapKit -framework AudioToolbox -framework Foundation -framework CFNetwork -framework CoreVideo -framework CoreMedia -framework MessageUI -framework AVFoundation -framework AssetsLibrary -framework UIKit -framework CoreGraphics -framework MobileVLCKit \
 -o "$RESULT_DIR/MediaDriveHD"

plutil -convert xml1 -o "MediaDriveHD.xcent" "Entitlements.plist"

export CODESIGN_ALLOCATE=$XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate
export PATH="$XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:$XCODE_BASE/Contents/Developer/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin"
#/usr/bin/codesign --force --sign $IDENTITY --resource-rules="ResourceRules.plist" --entitlements "iXpand Sync.xcent" "$RESULT_DIR"
/usr/bin/codesign --force --sign $"YOUR_IDENTITY" --resource-rules="ResourceRules.plist" --entitlements "MediaDriveHD.xcent" "$RESULT_DIR"
