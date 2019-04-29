IN_FILES=$(wildcard tests/*.in)
LL_FILES=$(IN_FILES:.in=.ll)
FILE_NAMES=$(IN_FILES:.in=)
OUT_FILES=$(IN_FILES:.in=.out)

default: run

clean:
	rm -f main.byte
	rm -fr _build/
	rm -rf tests/*.ll
	rm -rf tests/*.bc
	rm -rf tests/*.out
	rm -f parsingErrors.ml

main.byte:
	ocamlbuild $(OPTIONS) main.byte $(TAGS)

tests/%.ll: tests/%.in main.byte
	./main.byte $< > $@

tests: main.byte $(LL_FILES)
	@for FILE_NAME in $(FILE_NAMES);                                \
	do                                                              \
		echo "(========== Compiling $${FILE_NAME}".ll" ==========)";\
		clang $${FILE_NAME}".ll" bindings.c -o $${FILE_NAME}".out"; \
	done
	@echo "Done compiling. Results in tests dir."

run: clean
	make main.byte
	make tests
	@for OUT_FILE in $(OUT_FILES);                          \
	do                                                      \
		echo "(========== Running $${OUT_FILE} ==========)";\
		$${OUT_FILE} || true;                               \
	done
	@echo "Done running."

parsingErrors.ml: handcrafted.messages parser.mly
	menhir --compile-errors handcrafted.messages parser.mly > parsingErrors.ml

OPTIONS = -use-menhir -use-ocamlfind -pkgs core,menhirLib,llvm,llvm.analysis -yaccflag --table
TAGS = -tag thread