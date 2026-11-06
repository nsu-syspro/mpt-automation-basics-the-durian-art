NAME = $(shell jq -r .name config.json)
VER  = $(shell jq -r .version config.json)

TESTS = $(wildcard test/*.txt)
TEST_RESULTS = $(patsubst test/%.txt,build/test/%.out,$(TESTS))

.PHONY: all clean check

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VER)"' -o build/$(NAME) src/wordcount.c

clean:
	rm -rf build

check: $(TEST_RESULTS)

build/test/%.out: test/%.txt test/%.expected build/$(NAME)
	mkdir -p build/test
	./build/$(NAME) < $< > $@
	diff -u test/$*.expected $@
