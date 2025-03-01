define link_file
	if [ -f $(1) ]; then mv -n $(1) $(1).backup; fi
	ln -s $(realpath $(2)) $(1) -f
endef

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

.PHONY: all
all: tmux git vim
