.PRECIOUS: %.sol.out %.stu.out

BINS = parser_sol parser_stu
DIFFS = src0.diff src1.diff src2.diff src3.diff src4.diff src5.diff src6.diff src7.diff src8.diff src9.diff src10.diff

all: $(BINS) $(DIFFS)

%.sol.out: proj2_tests/%
	@-cat $< | ./parser_sol > $@

%.stu.out: proj2_tests/%
	@-cat $< | ./parser_stu > $@

%.diff: %.sol.out %.stu.out
	$(eval RESULT="$(shell diff -dwy $^ > $@; echo $$?)")
#	@-diff -dwy $^ > $@
	@([ $(RESULT) = "0" ] && echo "$@ contains no differences.") || (echo "$@ contains differences." && printf "\n--------- $@ BEGIN ---------\n\n" && cat $@ && printf "\n--------- $@ END ---------\n")

parser_sol: y.tab.c lex.yy.c proj2.c
	gcc -g -o $@ $^ -lfl
y.tab.c:  grammar.y
	yacc -v -d grammar.y
lex.yy.c: lex.l 
	flex lex.l

clean:
	rm -f parser_sol *.out $(DIFFS) *.o *.yy.c *.tab.*
