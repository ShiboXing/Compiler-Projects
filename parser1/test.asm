addi $r1,$r1,0x32
disp $r1 
addi $r1,$r1,-10
add $r2,$r1,$r1
disp $r2
j UUUu
UUUu:#test comment
disp $r1
disp $r1
disp $r1
disp $r1
disp $r1
disp $r1


GGG:
xor $r1,$r2,$r2
disp $r1
slt $r3,$r2,$r1
disp $r3

sub $r0,$r3,$r2
disp $r0
sb $r0,34($r1)
lb $r2,34($r1)
disp $r2
#make $r2 == $r1
xor $r2,$r2,$r2
beq $r1,$r2,10
halt
YYYJJJ: xor $r0,$r0,$r0
disp $r0
disp $r0
disp $r0
disp $r0
disp $r0
disp $r0
halt
j YYYJJJ






