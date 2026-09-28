#!/usr/bin/make -f
PREFIX ?= $(HOME)
PACKAGES := $(patsubst %/,%,$(wildcard */))
FILES := $(if $(PACKAGES),$(shell git ls-files $(PACKAGES)))
UNTRACKED := $(if $(PACKAGES),$(shell git ls-files --others --exclude-standard $(PACKAGES)))

.DEFAULT_GOAL := install
.PHONY: install

# Copy files into place, replacing any existing file or symlink
install:
	@for f in $(UNTRACKED); do echo "skipped untracked $$f"; done
	@set -e; for f in $(FILES); do \
		dest="$(PREFIX)/.$$f"; \
		mkdir -p "$$(dirname "$$dest")"; \
		rm -f "$$dest"; \
		cp "$$f" "$$dest"; \
		echo "installed $$dest"; \
	done
