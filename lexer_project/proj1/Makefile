BINS = lexer_sol lexer_stu
OUTPUTS = $(OUTPUTS_SOL) $(OUTPUTS_STU)
OUTPUTS_SOL = hello.mjava.sol.out strings.mjava.sol.out test.mjava.sol.out test2.mjava.sol.out
OUTPUTS_STU = hello.mjava.stu.out strings.mjava.stu.out test.mjava.stu.out test2.mjava.stu.out
DIFFS = hello.mjava.diff strings.mjava.diff test.mjava.diff test2.mjava.diff

all: $(BINS) $(OUTPUTS) $(DIFFS)

%.sol.out: proj1_tests/%
	-cat $< | ./lexer_sol > $@

%.stu.out: proj1_tests/%
	-cat $< | ./lexer_stu > $@

%.diff: %.sol.out %.stu.out
	@-diff -dwy $^ > $@
	@printf "\n--------- $@ BEGIN ---------\n\n"
	@cat $@
	@printf "\n\n--------- $@ END ---------\n"

lexer_sol: lexdrv.o lex.yy.o table.o
	gcc -o $@ lexdrv.o lex.yy.o table.o -ll
lexdrv.o: lexdrv.c token.h
	gcc -c lexdrv.c
lex.yy.o : lex.yy.c 
	gcc -c lex.yy.c 
table.o  : table.c
	gcc -c table.c
lex.yy.c: lex.l token.h
	flex lex.l
clean:
	rm -f lexer_sol $(OUTPUTS) $(DIFFS) *.o *.yy.c
