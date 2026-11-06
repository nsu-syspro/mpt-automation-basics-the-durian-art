NAME = $(shell jq -r .name config.json)
VER  = $(shell jq -r .version config.json)

TESTS = $(wildcard test/*.txt)

.PHONY: all clean check $(TESTS)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VER)"' -o build/$(NAME) src/wordcount.c

clean:
	rm -rf build

check: $(TESTS)
	@:

$(TESTS): build/$(NAME)
	@./build/$(NAME) < $@ | diff - $(@:.txt=.expected)
