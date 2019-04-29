IN_FILES=$(wildcard tests/*.in)
LL_FILES=$(IN_FILES:.in=.ll)
BC_FILES=$(IN_FILES:.ll=.bc)
OUT_FILES=$(IN_FILES:.in=.out)

default: main.byte

clean:
	rm -f main.byte
	rm -fr _build/
	rm -rf tests/*.ll
	rm -rf tests/*.bc
	rm -rf tests/*.out
	rm *.out
	rm -f *.o
	rm -f parsingErrors.ml

main.byte:
	ocamlbuild $(OPTIONS) main.byte $(TAGS)

tests/%.ll: tests/%.in main.byte
	./main.byte $< > $@

tests: main.byte $(LL_FILES)
	llvm-as tests/*.ll && clang tests/*.bc bindings.c
	# chmod +x $(OUT_FILES)
	# chmod 755 $(OUT_FILES)
	# $(OUT_FILES)
	@echo "Done testing. Results in tests dir."

parsingErrors.ml: handcrafted.messages parser.mly
	menhir --compile-errors handcrafted.messages parser.mly > parsingErrors.ml

OPTIONS = -use-menhir -use-ocamlfind -pkgs core,menhirLib,llvm,llvm.analysis -yaccflag --table
TAGS = -tag thread