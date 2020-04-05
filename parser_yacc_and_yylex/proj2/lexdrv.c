#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
 
extern  int yylex();
extern  void prt_hash_tbl();
extern  void prt_string_tbl();
extern  void init_hash_tbl();
extern  void init_string_tbl();
extern int yycolumn, yylength, yyline, yylval;

int main()
{
  int lexrtn;
  char* tokenid[40]={"EOFnum", "ANDnum", "ASSGNnum", 
                     "DECLARATIONSnum", "DOTnum", "ENDDECLARATIONSnum",
                     "EQUALnum", "GTnum", "IDnum", "INTnum", "LBRACnum",
                     "LPARENnum", "METHODnum", "NEnum", "ORnum", "PROGRAMnum",
                     "RBRACnum", "RPARENnum", "SEMInum", "VALnum", "WHILEnum",
                     "CLASSnum", "COMMAnum", "DIVIDEnum", "ELSEnum", "EQnum",
                     "GEnum", "ICONSTnum", "IFnum", "LBRACEnum", "LEnum", "LTnum",
                     "MINUSnum", "NOTnum", "PLUSnum", "RBRACEnum", "RETURNnum",
                     "SCONSTnum", "TIMESnum", "VOIDnum" };

  init_hash_tbl();
  init_string_tbl();
  yyline = 1;  yycolumn = 1;
  printf("Line\tColumn\t%-16s\tIndex in String table\n", "Token");
  while( 1 )
  {
     switch ( lexrtn = yylex() ){
     default:        printf("%d\t%d\t%-16s\n",yyline,yycolumn, tokenid[lexrtn - 256]); break;
     case ICONSTnum: printf("%d\t%d\t%-16s\t\n",yyline,yycolumn, tokenid[lexrtn - 256]);
                     break;
     case SCONSTnum:
     case IDnum:     printf("%d\t%d\t%-16s\t%d\n",yyline,yycolumn, tokenid[lexrtn - 256], yylval); 
                     break;
     case EOFnum:    printf("%d\t%d\t%-16s\n",yyline,yycolumn, tokenid[0]);  /* end of file incurred */
                     /*printf("\nHash Table :\n");
                     prt_hash_tbl();  */
                     printf("\nString Table : ");
                     prt_string_tbl();
                     return 0;
     }
  }
  return 0;
}
