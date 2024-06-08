#include <stdint.h>
#include <pic32mx.h>
#include "mipslab.h"

int getsw(){
  int value = (PORTD & 0x0F00)>>8;
  return value;
}

int getbtns(){
  int value = (PORTD & 0x00E0)>>5;
  return value;
}