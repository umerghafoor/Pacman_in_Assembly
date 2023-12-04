// A C program

#include <stdio.h>

extern int asmMain();

int main() {
	printf("Hello world\n");

	asmMain();

	getchar();

	return 0;
}