# Run from Project 2 directory.
# `make` to build & test, `-s` to suppress output

LOCAL_ANTLR = *.g4
LOCAL_JAVA = *.java
TEST_PATH = org.antlr.v4.gui.TestRig:Core/:CtrlNodes/:NumNodes/:.

all: clean build test

clean:
	@find . -type f -name '*.class' -delete
	@find . -type f -name '*.interp' -delete
	@find . -type f -name '*.tokens' -delete
	@find . -type f -name 'Grammar*.java' -delete
	@if [ -d .antlr ]; then rm -r .antlr; fi

build:
	@java -jar antlr-4.7.2-complete.jar Grammar.g4
	@javac -cp .:antlr-4.7.2-complete.jar *.java

test:
	@java Main