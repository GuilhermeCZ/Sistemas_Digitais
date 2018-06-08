#include <stdio.h>
#include <stdlib.h>
#define X 64
#define Y 48

typedef struct _ponto {
	int x;
	int y;
}ponto;

int testTriangulo(ponto a, ponto b, ponto c, ponto t){
	int findA = 0, findB=0,findC=0, findT=0,findt=0;
	int x, y;

	findT = (a.x *b.y * 1) + (a.y * 1 * c.x) + (1 * b.x * c.y) - (1 * b.y * c.x) - (1 * a.x * c.y) - (1 * a.y * b.x);
	findA = (t.x *a.y * 1) + (t.y * 1 * b.x) + (1 * a.x * b.y) - (1 * a.y * b.x) - (t.x * 1 * b.y) - (t.y * a.x * 1);
	findB = (t.x *b.y * 1) + (t.y * 1 * c.x) + (1 * b.x * c.y) - (1 * b.y * c.x) - (t.x * 1 * c.y) - (t.y * b.x * 1);
	findC = (t.x *c.y * 1) + (t.y * 1 * a.x) + (1 * c.x * a.y) - (1 * c.y * a.x) - (t.x * 1 * a.y) - (t.y * c.x * 1);

	if(findt < 0){ findT*=-1; }
	if(findt < 0){ findA*=-1; }
	if(findt < 0){ findB*=-1; }
	if(findt < 0){ findC*=-1; }

	findt = findA + findB + findC;

	if (findt <= findT){
		return 1;
	} else {
		return 0;
	}
}

int main(){
	ponto a, b, c, t;

	printf("\n\nInforme a Primeira coordenada do triagulo!\n");
    printf("a.x = ");
    scanf("%d", &a.x);
    printf("a.y = ");
    scanf("%d", &a.y);

    printf("\nInforme a Segunda coordenada do triagulo!\n");
    printf("b.x = ");
    scanf("%d", &b.x);
    printf("b.y = ");
    scanf("%d", &b.y);

    printf("\nInforme a Terceira coordenada do triagulo!\n");
    printf("c.x = ");
    scanf("%d", &c.x);
    printf("c.y = ");
    scanf("%d", &c.y);

    for(t.x=1; t.x<X; t.x++){
    	for(t.y=1; t.y<Y; t.y++){
				if (testTriangulo(a, b, c, t)) {
		    	printf("O ponto esta no dentro do triangulo\n");
					printf("X: %d - Y: %d\n", t.x, t.y);
		    } else {
					printf("O ponto nao esta no triangulo\n", );
				}
      }
    printf("\n");
    }
	return 0;
}
