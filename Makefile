define link_file
	if [ -f $(1) ]; then mv -n $(1) $(1).backup; fi
	ln -s $(realpath $(2)) $(1)
endef

.PHONY: tmux
tmux:
	$(call link_file, ~/.tmux.conf, ./tmux/tmux.conf)
	$(call link_file, ~/.ssh/rc, ./tmux/ssh_rc)

.PHONY: git
git:
	$(call link_file, ~/.gitconfig, ./git/gitconfig)

.PHONY: all
all: tmux git
