.PHONY: deploy_web clean deploy_web_channel

deploy_web:
	flutter build web
	firebase deploy

deploy_web_channel:
	@if [ -z "$(CHANNEL)" ]; then \
		echo "Error: CHANNEL variable is required"; \
		exit 1; \
	fi
	flutter build web
	firebase hosting:channel:deploy $(CHANNEL)

clean:
	rm -rf build/