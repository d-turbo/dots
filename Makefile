CONFIG := $(HOME)/.config

.PHONY: all config zsh x11 nvim

all: zsh config x11 nvim

config:
	mkdir -p $(CONFIG)

zsh:
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc

x11: config
	rm -rf $(CONFIG)/X11
	ln -s $(PWD)/X11 $(CONFIG)/X11
	[ -n "$$DISPLAY" ] && xdpyinfo >/dev/null 2>&1 && xrdb -merge $(CONFIG)/X11/Xresources

nvim: config
	rm -rf $(CONFIG)/nvim
	ln -s $(PWD)/nvim $(CONFIG)/nvim
