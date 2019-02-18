# Run from Project 2 directory.
# `make build && make test`

local_antlr = *.g4
local_java = *.java

all: build test

build:
	if [ -d .antlr ]; then rm -r .antlr; fi
	mkdir .antlr && cp $(local_antlr) $(local_java) .antlr/
	java -jar ../antlr-4.7.2-complete.jar .antlr/Grammar.g4
	javac .antlr/$(local_java)

test:
	cd .antlr; \
	java org.antlr.v4.gui.TestRig Grammar exprList ../test.bc
