flutter_run:
	flutter run

flutter_run_release:
	flutter run --release

flutter_run_port:
	flutter run --web-hostname 192.168.10.104 --web-port 8080 -d chrome

flutter_upgrade:
	flutter pub upgrade

build_web_profile:
	flutter build web --profile --source-maps

build_web:
	flutter build web --release --wasm -O4 --no-source-maps --base-href=/oil/v_0_0_1/

build_web_no_cdn:
	flutter build web --release --wasm -O4 --no-source-maps --no-web-resources-cdn

build_web_run:
	python3 -m http.server 80 --directory build/web

#icon

icons_generate:
	dart run flutter_launcher_icons:generate --override

icons_run:
	dart run flutter_launcher_icons

#splash

splash_run:
	dart run flutter_native_splash:create