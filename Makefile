.PHONY: tools
tools:
	go install mvdan.cc/gofumpt@latest
	go install golang.org/x/tools/gopls@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install golang.org/x/tools/cmd/godoc@latest
	go install github.com/go-delve/delve/cmd/dlv@latest
	go install github.com/daveshanley/vacuum@latest
	go install github.com/gokcehan/lf@latest
	go install gotest.tools/gotestsum@latest
	go install github.com/tomasruud/dog@latest
	go install github.com/tomasruud/serve@latest
	go install github.com/tomasruud/urlr@latest
	go install github.com/tomasruud/tprompt@latest
	go install github.com/tomasruud/go-test-skeleton@latest

	npm i -g dockerfile-language-server-nodejs
	npm i -g intelephense
	npm i -g typescript-language-server
	npm i -g typescript
	npm i -g vscode-langservers-extracted
	npm i -g bash-language-server
	npm i -g prettier

	gem install rubocop

	cargo install eza
	cargo install fd-find
	cargo install bat
	cargo install ripgrep
	cargo install sleek
	cargo install lsp-ai

	if [ ! -d ~/external/helix ]; then \
		git clone https://github.com/helix-editor/helix ~/external/helix; \
	fi; \
	cd ~/external/helix; \
	git pull; \
	cargo install --path helix-term --locked
	hx -g fetch
	hx -g build

.PHONY: install
install:
	stow --verbose --target=$${HOME} --restow */

.PHONY: uninstall
uninstall:
	stow --verbose --target=$${HOME} --delete */

.PHONY: backup-secrets
backup-secrets:
	tar -zcvf $(shell hostname)-$(shell date +%Y-%m-%d)-secrets.backup.tgz ~/.ssh ~/.netrc ~/.env* ~/.gitconfig.local

.PHONY: backup-brew
backup-brew:
	brew bundle dump --force --file ./brew/Brewfile
