NAME = $(shell jq -r .name config.json)
VER  = $(shell jq -r .version config.json)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VER)"' -o build/$(NAME) src/wordcount.c

clean:
	rm -rf build

check: all
	@bash -c 'for f in test/*.txt; do diff "$${f%.txt}.expected" <(./build/$(NAME) < $$f) || exit 1;	done'
