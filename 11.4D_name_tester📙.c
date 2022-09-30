// By BLOODMOON

#include <stdio.h>
#include <string.h>
#include "terminal_user_input.h"

#define LOOP_COUNT 60

void print_silly_name(my_string name)
{
  printf("Your name %s is a ", name.str);
  int index;
  for(index=0;index<LOOP_COUNT;index++) {
    printf("silly ");
  }
  printf("name!\n");
}

int main()
{
  my_string name;
  int index;
 
  name = read_string("What is your name? ");

  if (strcmp(name.str, "Trung") == 0 || strcmp(name.str, "Matthew") == 0)
  {
    printf("Your name is an AWESOME name!");  
  }
  else
  {
    print_silly_name(name);
  }

  return 0;
}

  // There may be a minor problem in this program, somehow I cannot run this in my VSCODE, but when I use any online C compiler, everything seemed to be okay =))))
