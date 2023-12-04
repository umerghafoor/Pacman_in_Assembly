// main.cpp

#include <stdio.h>

extern "C" void asmMain( );
extern "C" void printSingle( float d, int precision );

void printSingle(float d, int precision)
{
	printf("%f", d);
}

/*
void printSingle( float d, int precision )
{
	strstream temp;
	temp << "%." << precision << "f" << '\0';
	printf(temp.str( ), d );
}*/


int main( )
{
	printf("Input an integer: ");
	int d;
	scanf("%d", &d);
	printf("Input a float, then a double: ");
	asmMain( );
	return 0;
}