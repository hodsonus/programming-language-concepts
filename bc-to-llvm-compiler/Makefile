IN_FILES=$(wildcard tests/*.in)
LL_FILES=$(IN_FILES:.in=.ll)
BC_FILES=$(IN_FILES:.in=.bc)
OUT_FILES=$(IN_FILES:.in=.out)

# TODO - fix the makefile

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
	# clang $(LL_FILES) bindings.c -o $${i}; 
		# $$OUT_FILE = $$($$IN_FILE:.bc=.ll)    
		# $$OUT_FILE := $$(   $$IN_FILE:%.bc=%.ll   ) 
	# patsubst %.bc,%.ll,$$IN_FILE
	# @for IN_FILE in $(BC_FILES)  ;                \
	# do                                       \
	# 	$$OUT_FILE := $$(patsubst %.bc,%.ll,$$IN_FILE) \
	# 	echo "Processing $${IN_FILE}";             \
	# done                                   
	# clang $(LL_FILES) bindings.c -o $(OUT_FILES)
	clang tests/p0.ll bindings.c -o tests/p0.out
	@echo "Done testing. Results in tests dir."

run: clean
	make main.byte
	make tests
	# @for OUT_FILE in $(OUT_FILES); \
	# do \
	# 	echo "Running $${OUT_FILE}"; \
	# 	$OUT_FILE || true \
	# done
	# @echo "Done running."
	$(OUT_FILES) || true


parsingErrors.ml: handcrafted.messages parser.mly
	menhir --compile-errors handcrafted.messages parser.mly > parsingErrors.ml

OPTIONS = -use-menhir -use-ocamlfind -pkgs core,menhirLib,llvm,llvm.analysis -yaccflag --table
TAGS = -tag thread