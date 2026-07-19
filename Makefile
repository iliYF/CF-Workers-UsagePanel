.PHONY: cf-pages clean

ARCHIVE_NAME ?= usage-panel-cf-pages.zip

cf-pages: clean
	bash scripts/build-cf-pages.sh
	mkdir -p output
	cd dist && zip -r ../output/$(ARCHIVE_NAME) .

clean:
	rm -rf dist output
