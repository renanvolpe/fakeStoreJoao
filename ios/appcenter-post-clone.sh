#!/usr/bin/env bash
#Place this script in project/ios/

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b test-ios-deploy https://github.com/renanvolpe/fakeStoreJoao.git 

export PATH=C:/flutter/bin:$PATH

set PATH=C:\flutter\bin;%PATH%


flutter channel stable
flutter doctor

echo "Installed flutter to `pwd`/flutter"

cd ./ios
flutter precache --ios
flutter pub get
pod install