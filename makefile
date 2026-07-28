.PHONY: help get run_landing_web run_app_web run_landing_sim_active run_app_sim_active analyze test format format_check build_landing build_app build_all deploy_landing deploy_app deploy_web deploy_web_channel clean

help:
	@echo "Available commands:"
	@echo "  make get                    Install Flutter packages"
	@echo "  make run_landing_web        Run revamped landing on Flutter Web"
	@echo "  make run_app_web            Run old/main app on Flutter Web"
	@echo "  make run_landing_sim_active Run revamped landing on the already booted iOS Simulator"
	@echo "  make run_app_sim_active     Run old/main app on the already booted iOS Simulator"
	@echo "  make analyze                Run analyzer without failing on info lints"
	@echo "  make test                   Run Flutter tests with coverage"
	@echo "  make format                 Format Dart files"
	@echo "  make format_check           Check Dart formatting"
	@echo "  make build_landing          Build revamped landing web app"
	@echo "  make build_app              Build old/main web app"
	@echo "  make build_all              Build both web apps"
	@echo "  make deploy_landing         Deploy only the Flutter landing site"
	@echo "  make deploy_app             Deploy only the Flutter interactive app"
	@echo "  make deploy_web             Alias for deploy_landing"
	@echo "  make deploy_web_channel     Deploy preview channel; pass CHANNEL=name"

get:
	flutter pub get

run_landing_web:
	flutter run -d chrome --target=lib/main_landing.dart

run_app_web:
	flutter run -d chrome --target=lib/main_app.dart

run_landing_sim_active:
	@BOOTED_DEVICE_ID="$$(xcrun simctl list devices booted | awk -F '[()]' '/Booted/{print $$2; exit}')"; \
	if [ -z "$$BOOTED_DEVICE_ID" ]; then \
		echo "No booted iOS Simulator found. Boot one manually first."; \
		exit 1; \
	fi; \
	LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 flutter run -d "$$BOOTED_DEVICE_ID" --target=lib/main_landing.dart

run_app_sim_active:
	@BOOTED_DEVICE_ID="$$(xcrun simctl list devices booted | awk -F '[()]' '/Booted/{print $$2; exit}')"; \
	if [ -z "$$BOOTED_DEVICE_ID" ]; then \
		echo "No booted iOS Simulator found. Boot one manually first."; \
		exit 1; \
	fi; \
	LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 flutter run -d "$$BOOTED_DEVICE_ID" --target=lib/main_app.dart

analyze:
	flutter analyze --no-fatal-infos

test:
	flutter test --coverage

format:
	dart format .

format_check:
	dart format --set-exit-if-changed .

build_landing:
	./build_apps.sh landing

build_app:
	./build_apps.sh app

build_all:
	./build_apps.sh all

deploy_landing:
	./build_apps.sh landing
	firebase deploy --only hosting:boonyongyang --project boonyongyang

deploy_app:
	./build_apps.sh app
	firebase deploy --only hosting:boonyongyang-app --project boonyongyang

deploy_web: deploy_landing

deploy_web_channel:
	@if [ -z "$(CHANNEL)" ]; then \
		echo "Error: CHANNEL variable is required"; \
		exit 1; \
	fi
	./build_apps.sh landing
	firebase hosting:channel:deploy $(CHANNEL) --site boonyongyang --project boonyongyang

clean:
	flutter clean
	rm -rf build/
