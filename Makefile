VERSION ?= v0.4.5

DOCKER ?= docker
GIT ?= git

build: src/shellcheck/.git
	./build-shellcheck "$(dir $@)" "$(VERSION)"

src/shellcheck/.git:
	mkdir -p src
	$(GIT) clone https://github.com/koalaman/shellcheck.git src/shellcheck
	$(GIT) --git-dir $@ --work-tree=src/shellcheck reset --hard $(VERSION)
