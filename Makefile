# Makefile for hugo-based site

.PHONY: help test build clean

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help    Show this help message."
	@echo "  build   Build the Hugo site into the 'public' directory."
	@echo "  test    Build the site and run lychee to check for broken links."
	@echo "  clean   Remove the 'public' directory."

build: clean
	GOFLAGS="-mod=readonly" hugo --gc --minify

test: build
	lychee public --verbose --exclude-all-private --accept 200,403,429,500,503,999 --timeout 15 --root-dir $(PWD)/public

clean:
	rm -rf public