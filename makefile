.PHONY: help get run_landing_web run_app_web run_landing_sim_active run_app_sim_active analyze test format format_check build_landing build_app build_all web_contract bundle_budget visual_get visual_install_browser visual_test visual_update production_smoke deploy_landing deploy_app deploy_web deploy_web_channel clean

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
	@echo "  make web_contract           Check production metadata, discovery, and analytics"
	@echo "  make bundle_budget          Enforce Flutter production bundle ceilings"
	@echo "  make visual_get             Install locked visual-test dependencies"
	@echo "  make visual_install_browser Install the pinned Playwright Chromium"
	@echo "  make visual_test            Build and compare Flutter layout screenshots"
	@echo "  make visual_update          Review and replace Flutter screenshot baselines"
	@echo "  make production_smoke      Verify every live portfolio route and domain"
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

web_contract: build_all
	node tool/check_flutter_web_contract.mjs

bundle_budget: build_all
	node tool/check_flutter_bundle_budget.mjs

visual_get:
	npm --prefix visual-tests ci

visual_install_browser:
	visual-tests/node_modules/.bin/playwright install chromium

visual_test: build_all
	node tool/check_flutter_web_contract.mjs
	node tool/check_flutter_bundle_budget.mjs
	npm --prefix visual-tests run test

visual_update: build_all
	npm --prefix visual-tests run update

production_smoke:
	node tool/verify_portfolio_production.mjs

deploy_landing:
	./build_apps.sh landing
	firebase deploy --only hosting:boonyongyang --project boonyongyang
	$(MAKE) production_smoke

deploy_app:
	./build_apps.sh app
	firebase deploy --only hosting:boonyongyang-app --project boonyongyang
	$(MAKE) production_smoke

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
