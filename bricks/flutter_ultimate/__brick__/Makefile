codegen-watch:
	@dart run build_runner watch -d
	
codegen:
	@dart run build_runner build -d

app_config:
	@dart run package_rename -p application.yaml

launcher_icons:
	@dart run flutter_launcher_icons -f application.yaml

native_splash:
	@dart run flutter_native_splash:create --path application.yaml

setup: app_config launcher_icons native_splash

apk: setup
	flutter build apk

appbundle: setup
	flutter build appbundle