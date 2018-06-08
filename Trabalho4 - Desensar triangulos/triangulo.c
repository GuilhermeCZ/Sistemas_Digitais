#include <stdio.h>
#include <stdlib.h>
#define I 64
#define J 48
typedef struct _ponto
{
    int i;
    int j;
} Ponto;

int TesteTriangulo(Ponto A, Ponto B, Ponto C, Ponto T)
{
  int detA, detB, detC, detT, dett;
  int i, j;

  detT = (A.i * B.j * 1) + (A.j * 1 * C.i) + (1 * B.i * C.j) - (1 * B.j * C.i) - (1 * C.j * A.i) - (1 * A.j * B.i);
  if(detT < 0){ detT*=-1; }
  detA = (T.i * A.j * 1) + (T.j * 1 * B.i) + (1 * A.i * B.j) - (1 * A.j * B.i) - (T.i * 1 * B.j) - (T.j * A.i * 1);
  if(detA < 0){ detA*=-1; }
  detB = (T.i * B.j * 1) + (T.j * 1 * C.i) + (1 * B.i * C.j) - (1 * B.j * C.i) - (T.i * 1 * C.j) - (T.j * B.i * 1);
  if(detB < 0){ detB*=-1; }
  detC = (T.i * C.j * 1) + (T.j * 1 * A.i) + (1 * C.i * A.j) - (1 * C.j * A.i) - (T.i * 1 * A.j) - (T.j * C.i * 1);
  if(detC < 0){ detC*=-1; }
  dett = detA + detB + detC;
  printf("detT: %d \ndetA: %d \ndetB: %d \ndetC: %d \ndett: %d \n", detT, detA, detB, detC, dett);

 if(dett<=detT)
 {
   return 1;
 }
 else
 {
   return 0;
 }
}

int main()
{
    int n;
    Ponto A, B, C, T;

    printf("\nInforme a primeira coordenada do triagulo!\n");
    printf("A.i = ");
    scanf("%d", &A.i);
    printf("A.j = ");
    scanf("%d", &A.j);

    printf("\nInforme a segunda coordenada do triagulo!\n");
    printf("B.i = ");
    scanf("%d", &B.i);
    printf("B.j = ");
    scanf("%d", &B.j);

    printf("\nInforme a terceira coordenada do triagulo!\n");
    printf("C.i = ");
    scanf("%d", &C.i);
    printf("C.j = ");
    scanf("%d", &C.j);

    printf("\nInforme coordenada que deseja verificar se está dentro do triagulo!\n");
    printf("T.i = ");
    scanf("%d", &T.i);
    printf("T.j = ");
    scanf("%d", &T.j);


    if(TesteTriangulo(A, B, C, T))
    {
      printf("O ponto informado está dentro do triangulo!\n");
    }
    else
    {
      printf("O ponto informado não está dentro do triangulo!\n");
    }


    return 0;
}
