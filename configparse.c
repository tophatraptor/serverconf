#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include "configparse.h"
char *progname;

int main(int argc, char **argv) {
  progname = argv[0];

  char *data_file = argv[1];
  if(argc>1) {
    for(int i=1;i<argc;++i) {
      parse_string(argv[i]);
    }
  }
  else {
    yyparse();
  }
  exit(0);
}
