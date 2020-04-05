import java.util.*;
import java_cup.runtime.*;
//there three tabs between two columns


%% 
%class Apocalypse
%column
%line
%cup

%init{   
    System.out.println("Line          Column          Token           Value");
    System.out.println("===================================================");
%init}

%eofval{
    System.out.println("the end of file");
    System.exit(0);
%eofval}

%{
    

    private Symbol symbol(int type) { 
        return new Symbol(type, yyline, yycolumn); 
    } 

    private Symbol symbol(int type, Object value) { 
        return new Symbol(type, yyline, yycolumn, value);
    }
 
    
   
%} 

R_OPS = "add" | "sub" | "slt" |"xor"
I_OPS = "addi" | "beq" | "sb" | "lb" | "rand"
J_OPS = "disp" | "j" | "halt"

REGHEAD = "$r"
REG = {REGHEAD}[1-3]
LABEL = {Identifier}:

WhiteSpace = [ \t\r\n]
Identifier = [a-zA-Z_][a-zA-Z0-9_]*
Int = 0|[1-9][0-9]*

Star = \*
CommentStart = "/"{Star}
CommentEnd = {Star}+"/"
NotAStar = [^*]
Newline = [\n]
NotAStarOrSlash = [^*/]
Comment={CommentStart}({NotAStar}|{Newline}|({Star}+({NotAStarOrSlash}|{Newline})))*{CommentEnd}|"/""/".*\n
%%


{R_OPS}    {return symbol(R_OPS,yytext());}
{I_OPS}    {return symbol(I_OPS,yytext());}
{J_OPS}    {return symbol(J_OPS,yytext());}
","        {return symbol(COMA);}
{REG}      {return symbol(REG,yytext());}
{LABEL}    {return symbol(LABEL,yytext());}
{Newline}  {return symbol(NL,yytext());}
{Int}      {return symbol(INT,yytext());}
{WhiteSpace}    {}
{Comment}       {}
.       {return symbol(ILLEGALCHAR,yytext());}