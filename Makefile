all: build

.PHONY: build
build:
	@yarn
	@hugo

.PHONY: serve
serve:
	@hugo server --buildDrafts

.PHONY: clean
clean:
	@rm -rf node_modules public
