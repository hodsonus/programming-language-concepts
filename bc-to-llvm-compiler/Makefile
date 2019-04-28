IN_FILES=$(wildcard tests/*.in)
OUT_FILES=$(IN_FILES:.in=.ll)

default: main.byte

clean:
	rm -f main.byte
	rm -fr _build/
	rm -rf tests/*.ll
	rm -f parsingErrors.ml

main.byte:
	ocamlbuild $(OPTIONS) main.byte $(TAGS)

tests/%.ll: tests/%.in main.byte
	./main.byte $< > $@

tests: main.byte $(OUT_FILES)
	# cd ./tests/ && clang-4.0 *.ll
	@echo "Done testing. Results in tests dir."

parsingErrors.ml: handcrafted.messages parser.mly
	menhir --compile-errors handcrafted.messages parser.mly > parsingErrors.ml

OPTIONS = -use-menhir -use-ocamlfind -pkgs core,menhirLib,llvm -yaccflag --table
TAGS = -tag thread