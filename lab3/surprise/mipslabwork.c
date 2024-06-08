/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int mytime = 0x5957;

char textstring[] = "text, more text, and even more text!";

volatile int* porte = (volatile int*) 0xbf886110;

int timeoutcount = 9;

int prime = 1234567;

/* Interrupt Service Routine */
void user_isr( void ) {
  if (((IFS(0)&0x100)>>8)==1) {
    IFS(0) &= ~0x100;
    timeoutcount++;

   if (timeoutcount == 10){
      timeoutcount = 0;
      time2string( textstring, mytime );
      display_string( 3, textstring );
      display_update();
      tick( &mytime );
    }
  }
  if (((IFS(0)&0x80000)>>19)==1) {
    IFS(0) &= ~0x80000;
    PORTE++;
  }
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{
  volatile int* trise = (volatile int*) 0xbf886100;
  * trise &= 0xFF00; //sets last 8 bits to 0 (output)
  * porte &= 0x00;

  TRISD |= 0xFE0; //sets bits 11-5 to 1, keeps everything else the same

  T2CON = 0x70; //chooses 1:256 prescaling
  PR2 = 0x7A12; //sets time-out period to 31250
  TMR2 = 0; //reset timer value
  T2CONSET = 0x8000; //starts counter
  timeoutcount = 0;

  //IEC(0) = 0x100; //enable interrupt from timer two

  IEC(0) = 0x80100; //enable interrupts from timer two and SW4
  IPC(2) |= 0x003F; //set priority of timer2
  IPC(4) |= 0x002E; //set priority of SW4
  INTCONSET = 0x00000010;

  enable_interrupt();
  return;
}

/* This function is called repetitively from the main program */
void labwork( void ) {
  prime = nextprime( prime );
  display_string( 0, itoaconv( prime ) );
  display_string( 1, "");
  display_string( 2, "");
  display_update();
}

