%{
#include <stdlib.h>
#include "token.h"

int yyline=1, yycolumn=1, yylval;
char err[1024];

void install_id(char* text, int len, int tokenid); /* insert an id/string into hash table, set yylval */
void ReportError(char* msg, int line, int column);
void match();
%}

/* regular definitions */
delim         [ \t]
ws            {delim}+
newline       [\n]
declarations declarations
enddeclarations enddeclarations
iint        int
method      method
program     program
val         val
while       while
class       class
else        else
if          if
return      return
void        void
identifier    [A-Za-z][A-Za-z0-9]*
int           [0-9]+
errid         [0-9]+{identifier}
strcnst       '([^'\n\\]*(\\.)?)*'
errstr        '([^'\n\\]*(\\.)?)*[\n]
slashstar     \/\*
errcomm1      \*\/

%%
{ws}                {
                      int i;
                      for ( i=0; i<yyleng; i++ )
                      {
                        if ( yytext[i]=='\t' )
                          yycolumn = yycolumn + 8 - (yycolumn&0x7);
                        else
                          yycolumn++;
                      }
                    }
{newline}           {yyline++; yycolumn=1;}
"&&"                {yycolumn += yyleng; return(ANDnum);}
":="                {yycolumn += yyleng; return(ASSGNnum);}
{declarations}      {
                     yycolumn += yyleng; 
                     return(DECLARATIONSnum);
                    } 
"."                 {yycolumn += yyleng; return(DOTnum);}
{enddeclarations}   {
                     yycolumn+= yyleng;
                     return(ENDDECLARATIONSnum);
                    }
"="                 {yycolumn += yyleng; return(EQUALnum);}
">"                 {yycolumn += yyleng; return(GTnum);}
{method}            {yycolumn += yyleng; return(METHODnum);}
{program}           {yycolumn += yyleng; return(PROGRAMnum);}
{val}               {yycolumn += yyleng; return(VALnum);}
{while}             {yycolumn += yyleng; return(WHILEnum);}
{class}             {yycolumn += yyleng; return(CLASSnum);}
{else}              {yycolumn += yyleng; return(ELSEnum);}
{if}                {yycolumn += yyleng; return(IFnum);}
{iint}              {yycolumn += yyleng; return(INTnum);
}
{return}            {yycolumn += yyleng; return(RETURNnum);}
{void}              {yycolumn += yyleng; return(VOIDnum);}
{identifier}        {
                     yycolumn += yyleng;
                     install_id(yytext, yyleng, IDnum);
                     return(IDnum);}
{errid}             {
                     sprintf(err, "Malformed identifier '%s'", yytext);
                     ReportError(err, yyline, yycolumn);
                     yycolumn += yyleng;
                    }
"["                 {yycolumn += yyleng; return(LBRACnum);}
"("                 {yycolumn += yyleng; return(LPARENnum);}
"!="                {yycolumn += yyleng; return(NEnum);}
"||"                {yycolumn += yyleng; return(ORnum);}
"]"                 {yycolumn += yyleng; return(RBRACnum);}
")"                 {yycolumn += yyleng; return(RPARENnum);}
";"                 {yycolumn += yyleng; return(SEMInum);}
","                 {yycolumn += yyleng; return(COMMAnum);}
"/"                 {yycolumn += yyleng; return(DIVIDEnum);}
"=="                {yycolumn += yyleng; return(EQnum);}
">="                {yycolumn += yyleng; return(GEnum);}
{int}               {yycolumn += yyleng; yylval = atoi(yytext); return(ICONSTnum);}
"{"                 {yycolumn += yyleng; return(LBRACEnum);}
"<="                {yycolumn += yyleng; return(LEnum);}
"<"                 {yycolumn += yyleng; return(LTnum);}
"-"                 {yycolumn += yyleng; return(MINUSnum);}
"!"                 {yycolumn += yyleng; return(NOTnum);}
"+"                 {yycolumn += yyleng; return(PLUSnum);}
"}"                 {yycolumn += yyleng; return(RBRACEnum);}
{strcnst}           {yycolumn += yyleng;
                     install_id( yytext+1, yyleng-2, SCONSTnum);
                     return(SCONSTnum);}
{errstr}            {ReportError("Unmatched string constant", yyline, yycolumn); yyline++; yycolumn=1;}
"*"                 {yycolumn += yyleng; return(TIMESnum);}
{slashstar}         {yycolumn += yyleng; match(); }
{errcomm1}          {yycolumn++; ReportError("Unmatched comment", yyline, yycolumn);}
.                   {sprintf(err, "Undefined symbol '%s'", yytext); ReportError(err, yyline, yycolumn); while (input() != '\n'); yyline++; yycolumn=1; }
<<EOF>>             {return(EOFnum);}
%%
void ReportError(char* msg, int line, int column)
{
  printf("Error: %s, at line %d column %d\n", msg, line, column);
}

char input_with_tracking()
{
  char c = input();
  if( c == '\n') {
    yyline++;
    yycolumn = 1;
  }
  else {
    yycolumn++;
  }
  return c;
}

void match()
{
  /* trying to find the ending of the comment, print error msg when necessary */
  char c;

  for ( ; ; ) {
    while ( (c = input_with_tracking()) != '*' && c != EOF ) ; /* eat up text of comment */
    if ( c == '*' ) {
      while ( (c = input_with_tracking()) == '*' ) ;
      if ( c == '/' )
        break; /* found the end */
    }
    if ( c == EOF ) {
      yycolumn--; // we should not count EOF as a character
      ReportError("EOF found in comment", yyline, yycolumn);
      break;
    }
  }
}
