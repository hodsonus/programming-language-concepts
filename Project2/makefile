# Run from Project 2 directory.
# `make` to build & test, `-s` to suppress output

LOCAL_ANTLR = *.g4
LOCAL_JAVA = *.java
TEST_PATH = org.antlr.v4.gui.TestRig:Core/:CtrlNodes/:NumNodes/:.

all: clean build test

clean:
	find . -type f -name '*.class' -delete
	find . -type f -name '*.interp' -delete
	find . -type f -name '*.tokens' -delete
	find . -type f -name 'Grammar*.java' -delete
	if [ -d .antlr ]; then rm -r .antlr; fi

build:
	java -jar ../antlr-4.7.2-complete.jar Grammar.g4 -visitor
	find -name "*.java" > src.txt && javac -cp .:../antlr-4.7.2-complete.jar @src.txt && rm src.txt

test:
	#cd .antlr && java org.antlr.v4.gui.TestRig Grammar allExpr ../misc.txt
	cd .antlr; java -cp ${TEST_PATH} Grammar exprList ../test.bc
	java -cp antlr-4.0-complete.jar org.antlr.v4.Tool Mu.g4 -visitorjavac -cp antlr-4.0-complete.jar *.java
	java -cp .:antlr-4.0-complete.jar Main
