import java_cup.runtime.*;
//there three tabs between two columns

%%
%class Apocalypse
%column
%implements sym
%line
%column
%cup

%eofval{
  return symbol(sym.EOF);
%eofval}

%{
    private Symbol symbol(int type) { 
        return new Symbol(type, yyline, yycolumn); 
    } 

    private Symbol symbol(int type, Object value) { 
        return new Symbol(type, yyline, yycolumn, value);
    }   
%} 



LABEL = {Identifier}:
Delimiter= [ ,\t\r]
Identifier = [a-zA-Z_][a-zA-Z0-9_]*
Int = 0|[1-9][0-9]* | 0x[0-9a-fA-F]*
Newline = \n
Comment="#".*\n
%%

{Comment}  {return symbol(sym.NL);}
{Delimiter}    {}
"("        {return symbol(sym.LPAREN);}
")"        {return symbol(sym.RPAREN);}
"add"      {return symbol(sym.ADD);}
"sub"      {return symbol(sym.SUB);}
"slt"      {return symbol(sym.SLT);}
"xor"      {return symbol(sym.XOR);}
"addi"     {return symbol(sym.ADDI);}
"beq"      {return symbol(sym.BEQ);}
"rand"     {return symbol(sym.RAND);}
"disp"     {return symbol(sym.DISP);}
"halt"     {return symbol(sym.HALT);}
"lb"       {return symbol(sym.LB);}
"sb"       {return symbol(sym.SB);}
"j"        {return symbol(sym.J);}
"beq"      {return symbol(sym.BEQ);}
"rand"     {return symbol(sym.RAND);}
"$r0"      {return symbol(sym.REG0,yytext());}
"$r1"      {return symbol(sym.REG1,yytext());}
"$r2"      {return symbol(sym.REG2,yytext());}
"$r3"      {return symbol(sym.REG3,yytext());}
{Identifier} {return symbol(sym.ID,yytext());}
{LABEL}    {return symbol(sym.LABEL,yytext());}
{Newline}  {return symbol(sym.NL);}
-?{Int}      {return symbol(sym.INT,yytext());}
.          {return symbol(sym.ILLEGALCHAR);}