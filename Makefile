all: build

bin/hugo:
	bash get-hugo.sh

.PHONY: build
build: bin/hugo
	./bin/hugo

.PHONY: serve
serve: bin/hugo
	./bin/hugo server --buildDrafts

.PHONY: clean
clean:
	rm -rf node_modules resources public bin
