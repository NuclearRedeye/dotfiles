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
	@# Merge only statusLine so other local settings are kept
	@set -e; settings="$(PREFIX)/.claude/settings.json"; \
	[ -f "$$settings" ] || echo '{}' > "$$settings"; \
	jq '.statusLine = {"type": "command", "command": "sh ~/.claude/scripts/statusline.sh"}' \
		"$$settings" > "$$settings.tmp"; \
	mv "$$settings.tmp" "$$settings"; \
	echo "configured statusLine in $$settings"
