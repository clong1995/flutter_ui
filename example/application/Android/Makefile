flutter_run:
	flutter run

flutter_upgrade:
	flutter pub upgrade

#adb

adb_devices:
	~/Library/Android/sdk/platform-tools/adb devices

adb_tcpip: # 华为手机必须选择“仅充电模式下允许ADB调试”
	~/Library/Android/sdk/platform-tools/adb tcpip 5555

adb_connect:
	~/Library/Android/sdk/platform-tools/adb connect 192.168.10.101:5555

adb_disconnect:
	~/Library/Android/sdk/platform-tools/adb disconnect

jdk:
	/Applications/Android\ Studio.app/Contents/jbr/Contents/Home/bin

#fat APK
build_apk:
	flutter build apk --obfuscate --split-debug-info=./build/app/outputs/flutter-apk

build_apk_split:
	flutter build apk --split-per-abi --obfuscate --split-debug-info=./build/app/outputs/flutter-apk

build_apk_arm64:
	flutter build apk --target-platform android-arm64 --obfuscate --split-debug-info=./build/app/outputs/flutter-apk

#检查签名
check_sign:
	/Applications/Android\ Studio.app/Contents/jbr/Contents/Home/bin/jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk


#icon

icons_generate:
	dart run flutter_launcher_icons:generate --override

icons_run:
	dart run flutter_launcher_icons

#splash

splash_run:
	dart run flutter_native_splash:create