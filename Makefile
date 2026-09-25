#!/usr/bin/make -f
PREFIX ?= $(HOME)
PACKAGES := $(patsubst %/,%,$(wildcard */))
FILES := $(shell find $(PACKAGES) -type f 2>/dev/null)

.DEFAULT_GOAL := install
.PHONY: install

# Copy files into place, replacing any existing file or symlink
install:
	@set -e; for f in $(FILES); do \
		dest="$(PREFIX)/.$$f"; \
		mkdir -p "$$(dirname "$$dest")"; \
		rm -f "$$dest"; \
		cp "$$f" "$$dest"; \
		echo "installed $$dest"; \
	done
