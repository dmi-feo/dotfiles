define link_file
	if [ -f $(1) ]; then mv -n $(1) $(1).backup; fi
	ln -s $(realpath $(2)) $(1) -f
endef

UNAME_S := $(shell uname -s)

.PHONY: tmux
tmux:
	$(call link_file, ~/.tmux.conf, ./tmux/tmux.conf)
	$(call link_file, ~/.ssh/rc, ./tmux/ssh_rc)

.PHONY: git
git:
	@if [ -z "$(email)" ]; then echo "Error: 'email' argument is required. Usage: make git email=your@email.com"; exit 1; fi
	cp ./git/gitconfig ~/.gitconfig && sed -i -e 's/{{email}}/$(email)/g' ~/.gitconfig

.PHONY: vim
vim:
	$(call link_file, ~/.vimrc, ./vim/vimrc)

.PHONY: utils-for-mac
utils-for-mac:
	./utils/install_utils.sh
	./ensure_line_in_file.sh "source `realpath ./utils/export_env_vars.sh`" ~/.zshrc

.PHONY: zsh
zsh:
	git -C ~/.zsh.d pull --recurse-submodules || git clone --recurse-submodules git@github.com:dmi-feo/zsh_config.git ~/.zsh.d
	./ensure_line_in_file.sh "source ~/.zsh.d/zshrc" ~/.zshrc

.PHONY: all-mac
all-mac: zsh tmux git vim utils-for-mac

.PHONY: all-linux
all-linux: zsh tmux git vim

.PHONY: all
all: $(if $(findstring Darwin,$(UNAME_S)),all-mac,all-linux)
