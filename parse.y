%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *);
int yylex(void);

%}

%union {
char * string;
}

%token OPEN_PAREN CLOSE_PAREN OPEN_BRACE CLOSE_BRACE SEMICOLON QUOTE GLOBAL HOST EOFTOK EOLN
%token<string> TEXT EQUAL

%type <string> inlines inline configset
%start input

%%

input
  : lines EOFTOK      {YYACCEPT;}
  ;

lines
  :
  | GLOBAL configset {printf("GLOBAL CONFIG\n------------\n%s\n",$2);}
  | HOST QUOTE TEXT QUOTE configset {printf("Host \"%s\" CONFIG\n------------------\n",$3);printf("%s",$5);}
  ;

configset
  : OPEN_BRACE inlines CLOSE_BRACE SEMICOLON{$$=$2;}
  | error {printf("configset messed up");}
  ;

inlines
  : inline {char *buf; buf = (char *)malloc(1000*sizeof(char)); strcat(buf,$1);strcat(buf,"\n");$$=buf;}
  | inlines inline {char *buf; buf = (char *)malloc(1000*sizeof(char)); strcpy(buf,$1);strcat(buf,$2);strcat(buf,"\n");$$=buf;}
  ;

inline
  : TEXT EQUAL TEXT {char str[1000]; sprintf(str,"%s = %s",$1,$3);$$=str;}
  | error  {printf("inline messed up");}
  ;
%%

void yyerror(char *msg) {}
