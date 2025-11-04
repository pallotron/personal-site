# Makefile for hugo-based site

.PHONY: help test build clean lint

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help    Show this help message."
	@echo "  build   Build the Hugo site into the 'public' directory."
	@echo "  test    Build the site and run lychee to check for broken links."
	@echo "  lint    Run markdownlint on all markdown files."
	@echo "  clean   Remove the 'public' directory."

build: clean
	GOFLAGS="-mod=readonly" hugo --gc --minify

test: build
	lychee public --verbose --exclude-all-private --accept 200,403,429,500,503,999 --timeout 15 --root-dir $(PWD)/public

lint:
	markdownlint 'docs/**/*.md' 'content/**/*.md'

clean:
	rm -rf public