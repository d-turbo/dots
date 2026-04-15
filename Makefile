LOCAL := $(HOME)/.local
SRC := $(LOCAL)/src
TMP := /tmp/dots
CONFIG := $(HOME)/.config

.PHONY: all config compiled zsh x11 nvim suckless resume

all: zsh config x11 nvim

config:
	mkdir -p $(CONFIG)

compiled:
	mkdir -p $(SRC)
	mkdir -p $(TMP)

zsh:
	ln -sfn $(PWD)/zshrc $(HOME)/.zshrc

x11: config
	rm -rf $(CONFIG)/X11
	ln -s $(PWD)/X11 $(CONFIG)/X11
	[ -n "$$DISPLAY" ] && xdpyinfo >/dev/null 2>&1 && xrdb -merge $(CONFIG)/X11/Xresources

nvim: config
	rm -rf $(CONFIG)/nvim
	ln -s $(PWD)/nvim $(CONFIG)/nvim

zathura: config x11
	$(PWD)/zathura/zathurarc.template > $(CONFIG)/zathura/zathurarc

suckless: compiled
	@if [ -z "$(PROG)" ]; then \
		echo "Usage: make suckless PROG=<tool>"; \
		exit 1; \
	fi

	@echo -e "\nFetching $(PROG)..."
	@if [ -d "$(SRC)/$(PROG)" ]; then \
		cd "$(SRC)/$(PROG)" && git pull --ff-only || echo "Using local copy"; \
	else \
		if ! git clone "https://git.suckless.org/$(PROG)" "$(SRC)/$(PROG)"; then \
			echo "No $(PROG)..."; \
			exit 1; \
		fi \
	fi

	@echo -e "\nBuilding $(PROG)..."
	rm -rf "$(TMP)/$(PROG)"
	cp -a "$(SRC)/$(PROG)" "$(TMP)/$(PROG)"
	cp -a "$(PWD)/$(PROG)/." "$(TMP)/$(PROG)/"

	@echo -e "\nPatching $(PROG)..."
	@cd $(TMP)/$(PROG) && \
	if [ -d "$(TMP)/$(PROG)/patches" ]; then \
		for p in $(TMP)/$(PROG)/patches/*.diff; do \
			if [ -f "$$p" ]; then \
				echo -e "\nApplying $$p..."; \
				patch -p1 < $$p || { echo "Patch $$p failed!"; rm $$p; exit 1; }; \
				rm $$p; \
			fi \
		done \
	fi

	@echo -e "\nCompiling $(PROG)..."
	@cd $(TMP)/$(PROG)/ && make PREFIX=$(LOCAL) install
	@echo -e "\nCleanup for $(PROG)..."
	rm -rf $(TMP)/$(PROG)

resume:
	@if [ -z "$(PROG)" ]; then \
		echo "Usage: make resume PROG=<tool>"; \
		exit 1; \
	fi

	@if [ ! -d "$(TMP)/$(PROG)" ]; then \
		exit 1; \
	fi

	cd $(TMP)/$(PROG) && \
	if [ -d "$(TMP)/$(PROG)/patches" ]; then \
		echo -e "\nResume patching $(PROG)..."; \
		for p in $(TMP)/$(PROG)/patches/*.diff; do \
			if [ -f "$$p" ]; then \
				echo -e "\nApplying $$p..."; \
				patch -p1 < $$p || { echo "Patch $$p failed!"; rm $$p; exit 1; }; \
				rm $$p; \
			fi \
		done \
	fi

	@echo -e "\nCompiling $(PROG)..."
	@cd $(TMP)/$(PROG)/ && make PREFIX=$(LOCAL) install
	@echo -e "\nCleanup for $(PROG)..."
	rm -rf $(TMP)/$(PROG)
