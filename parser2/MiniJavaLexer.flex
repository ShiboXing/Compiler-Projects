import java.util.*;
import java_cup.runtime.Symbol;
import visitor.*;
//there three tabs between two columns

%%
%class MLexer
%column
%implements sym
%line
%cup
%init{   
    
%init}

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

WhiteSpace = [ \t\r\n]
Identifier = [a-zA-Z_][a-zA-Z0-9_]*
Integer = 0|[1-9][0-9]*


Star = \*
CommentStart = "/"{Star}
CommentEnd = {Star}+"/"
NotAStar = [^*]
Newline = [\n]
NotAStarOrSlash = [^*/]
Comment={CommentStart}({NotAStar}|{Newline}|({Star}+({NotAStarOrSlash}|{Newline})))*{CommentEnd}|"/""/".*\n
%%


{Comment} {}
{WhiteSpace}    {}
{Integer}  {return symbol(sym.INTEGER,yytext()); }
"+"     { return symbol(sym.PLUS);}
"-"     { return symbol(sym.MINUS);}
"*"     { return symbol(sym.MULTIPLY);}
"<"     { return symbol(sym.LESSTHAN);}
"$$"    { return symbol(sym.AND);}
"class" { return symbol(sym.CLASS);}
"{"   {return symbol(sym.LBRACE);}
"}"   {return symbol(sym.RBRACE);}
"("   {return symbol(sym.LPAREN);}
")"   {return symbol(sym.RPAREN);}
";"   {return symbol(sym.SEMICOLON);}
","   {return symbol(sym.COMA);}
"static"    {return symbol(sym.STATIC);}
"void"      {return symbol(sym.VOID);}
"main"      {return symbol(sym.MAIN);}
"String"    {return symbol(sym.STRING);}
"public"    {return symbol(sym.PUBLIC);}
"["         {return symbol(sym.LBRACKET);}
"]"         {return symbol(sym.RBRACKET);}
"extends"   {return symbol(sym.EXTENDS);}
"return"    {return symbol(sym.RETURN);}
"boolean"   {return symbol(sym.BOOLEAN);}
"int"   {return symbol(sym.INT);}
"if"    {return symbol(sym.IF);}
"else"  {return symbol(sym.ELSE);}
"while" {return symbol(sym.WHILE);}
"true" {return symbol(sym.TRUE);}
"false" {return symbol(sym.FALSE);}
"System.out.println" {return symbol(sym.SYSOUTPRINT);}
"="     {return symbol(sym.EQUAL);}
"."     {return symbol(sym.DOT);}
"length" {return symbol(sym.LENGTH);}
"this"    {return symbol(sym.THIS);}
"new"     {return symbol(sym.NEW);}
"!"       {return symbol(sym.NEGATION);} 
{Identifier}       {return symbol(sym.ID,yytext());}
.       {return symbol(sym.ILLEGALCHAR,yytext());}