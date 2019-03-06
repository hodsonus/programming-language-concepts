# Run from Project 2 directory.
# `make` to build & test, `-s` to suppress output

local_antlr = *.g4
local_java = *.java

all: build # TODO test

build:
	if [ -d .antlr ]; then rm -r .antlr; fi
	mkdir .antlr
	cp Core/$(local_java) .antlr
	cp CtrlNodes/$(local_java) .antlr
	cp NumNodes/$(local_java) .antlr
	cp -r $(local_antlr) .antlr
	java -jar ../antlr-4.7.2-complete.jar .antlr/Grammar.g4
	javac .antlr/$(local_java)

# TODO
#test:
#	cd .antlr; java org.antlr.v4.gui.TestRig Grammar exprList ../test.bc
