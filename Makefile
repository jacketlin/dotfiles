default: install

dependencies:
	@command -v stow >/dev/null 2>&1 || { echo >&2 "Please install GNU stow"; exit 1; }

install: dependencies
	stow git
	stow ruby
	stow screen
	stow slate
	stow sqlite
	stow tig
	stow tmux
	stow xvim
