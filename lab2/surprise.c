#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define COLUMNS 6
int current=0;
int count = 0;

void print_number(int x){
  if (current%COLUMNS==0){
    printf("\n");
  }
  printf("%10d ", x);
  current++;
}

void print_sieves(int n){
  int numbers[7920];
  int nr = 0;
  for (int i = 0; i<7920; i++){ //create array filled with numbers from 2 to n
    numbers[i]=i+2;
  }
  for (int i = 0; i <= 7920; i++){
    if (numbers[i]!=0){
      nr = numbers[i];
      for (int j = 2*nr; j<=7921; j+=nr){
        numbers[j-2] = 0;
      } 
    }
  }
  int i;
  for (i = 0; i<7920;i++){
    if (numbers[i]!=0){
      count++;
    }
    if (count == n){
      print_number(numbers[i]);
      break;
    }
  }
}

int main(int argc, char *argv[]){
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an integer number.\n");
  return 0;
}
