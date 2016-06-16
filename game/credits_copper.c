#include <stdio.h>

#define HANDLE_LINE_WRAP(x)     if (line == 256) { printf("\tdc.w $ffdf,$fffe\n");line = line - 256; }

int 
main(int argc, char** argv)
{
  int line = 0x41;

  for (int row = 0; row < 25; row++) {
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$3ae\n", line++);
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$5ce\n", line++);    
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$7dd\n", line++);    
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$9ec\n", line++);    
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$bea\n", line++);    
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$de8\n", line++);    
    HANDLE_LINE_WRAP(line);
    printf("\tdc.w $%02x07,$fffe\n\tdc.w COLOR06,$ec6\n", line++);    
    line += 3;
  }

  return 0;
}
