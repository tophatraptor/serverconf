%{

#include <stdio.h>
#include "parse.tab.h"

int yyparse();

%}

%option noyywrap

%%

\(				{return OPEN_PAREN;}
\)        {return CLOSE_PAREN;}

\{        {return OPEN_BRACE;}
\}        {return CLOSE_BRACE;}

;         {return SEMICOLON;}

[ \t]     {}

\n        {}

\"        {return QUOTE;}

"host"    {return HOST;}

"global"  {return GLOBAL;}

=         {return EQUAL;}

[a-zA-Z0-9_.-/]+ {yylval.string = strdup(yytext);return TEXT;}

<<EOF>>   {return EOFTOK;}

%%

void parse_string(char *s) {
  char *str;
  asprintf(&str,"%s\n",s);
    YY_BUFFER_STATE bh = yy_scan_string(str);
    yyparse();
    yy_delete_buffer(bh);
    free(str);
}
