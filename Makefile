#!/usr/bin/make -f
PREFIX ?= $(HOME)
PACKAGES := $(patsubst %/,%,$(wildcard */))
FILES := $(if $(PACKAGES),$(shell git ls-files $(PACKAGES)))
UNTRACKED := $(if $(PACKAGES),$(shell git ls-files --others --exclude-standard $(PACKAGES)))
SETTINGS := $(PREFIX)/.claude/settings.json
STATUSLINE := {"type": "command", "command": "sh ~/.claude/scripts/statusline.sh"}

.DEFAULT_GOAL := install
.PHONY: install files settings

install: files settings

# Copy files into place, replacing any existing file or symlink
files:
	@for f in $(UNTRACKED); do echo "skipped untracked $$f"; done
	@set -e; for f in $(FILES); do \
		dest="$(PREFIX)/.$$f"; \
		mkdir -p "$$(dirname "$$dest")"; \
		rm -f "$$dest"; \
		cp "$$f" "$$dest"; \
		echo "installed $$dest"; \
	done

# Merge only statusLine, and only when it differs, so other local settings are kept
settings:
	@set -e; mkdir -p "$$(dirname "$(SETTINGS)")"; \
	[ -f "$(SETTINGS)" ] || echo '{}' > "$(SETTINGS)"; \
	if ! jq -e '.statusLine == $(STATUSLINE)' "$(SETTINGS)" >/dev/null; then \
		jq '.statusLine = $(STATUSLINE)' "$(SETTINGS)" > "$(SETTINGS).tmp"; \
		mv "$(SETTINGS).tmp" "$(SETTINGS)"; \
		echo "configured statusLine in $(SETTINGS)"; \
	fi
