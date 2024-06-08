#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define COLUMNS 6
int current=0;

void print_number(int x){
  if (current%COLUMNS==0){
    printf("\n");
  }
  printf("%10d ", x);
  current++;
}

void print_sieves(int n){
  char* array = (char*) malloc(n);
  int max = sqrt(n)-2;
  int nr = 0;
  for (int i = 0; i<n-1; i++){ //create array filled with numbers from 2 to n
    *(array+i)=1;
  }
  for (int i = 0; i <= max; i++){
    if (*(array+i)!=0){
      nr = i+2;
      for (int j = 2*nr; j<=n; j+=nr){
        *(array+(j-2)) = 0;
      } 
    }
  }
  for (int i = 0; i<n-1;i++){
    if (*(array+i)!=0){
      print_number(i+2);
    }
  }
  free(array);
}

int main(int argc, char *argv[]){
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an integer number.\n");
  return 0;
}
