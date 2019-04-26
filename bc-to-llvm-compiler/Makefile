IN_FILES=$(wildcard tests/*.in)
OUT_FILES=$(IN_FILES:.in=.out)

default: main.byte

clean:
	rm -f main.byte
	rm -fr _build/
	rm -rf tests/*.out
	rm -f parsingErrors.ml

main.byte:
	ocamlbuild $(OPTIONS) main.byte $(TAGS)

tests/%.out: tests/%.in main.byte
	./main.byte $< > $@

tests: main.byte $(OUT_FILES)
	@echo "Done testing. Results in tests dir."

parsingErrors.ml: handcrafted.messages parser.mly
	menhir --compile-errors handcrafted.messages parser.mly > parsingErrors.ml

OPTIONS = -use-menhir -use-ocamlfind -pkgs core,menhirLib -yaccflag --table
TAGS = -tag thread