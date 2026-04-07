CONFIG := $(HOME)/.config

.PHONY: all zsh x11

all: zsh x11

zsh:
	ln -sf $(PWD)/zshrc $(HOME)/.zshrc

x11:
	mkdir -p $(CONFIG)/X11
	ln -sf $(PWD)/X11/xinitrc $(CONFIG)/X11/xinitrc
	ln -sf $(PWD)/X11/Xresources $(CONFIG)/X11/Xresources
	[ -n "$$DISPLAY" ] && xdpyinfo >/dev/null 2>&1 && xrdb -merge $(CONFIG)/X11/Xresources


