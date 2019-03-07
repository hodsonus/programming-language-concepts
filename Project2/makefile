# Run from Project 2 directory.
# `make` to build & test, `-s` to suppress output

LOCAL_ANTLR = *.g4
LOCAL_JAVA = *.java
TEST_PATH = org.antlr.v4.gui.TestRig:Core/:CtrlNodes/:NumNodes/:.

all: build test

build:
	if [ -d .antlr ]; then rm -r .antlr; fi
	mkdir .antlr .antlr/Core .antlr/CtrlNodes .antlr/NumNodes
	cp Core/$(LOCAL_JAVA) .antlr/Core
	cp CtrlNodes/$(LOCAL_JAVA) .antlr/CtrlNodes
	cp NumNodes/$(LOCAL_JAVA) .antlr/NumNodes
	cp $(LOCAL_ANTLR) .antlr
	java -jar ../antlr-4.7.2-complete.jar .antlr/Grammar.g4
	javac .antlr/$(LOCAL_JAVA)

test:
	#cd .antlr && java org.antlr.v4.gui.TestRig Grammar allExpr ../misc.txt
	cd .antlr; java -cp ${TEST_PATH} Grammar exprList ../test.bc
