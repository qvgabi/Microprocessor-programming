//---------------------------------------------------------------
// Program lab_9b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o lab_9b lab_9b.c lab_9b_asm.s
// To run:          ./lab_9b
//
//---------------------------------------------------------------

#include <stdio.h>

int fibc( unsigned int k )
{
	int fold = 0;
	int fnew = 1;
	int sum;

	if( k == 0 ) return fold;
	else if( k == 1 ) return fnew;
	else
	{
		do {
			sum = fold + fnew;
			fold = fnew;
			fnew =  sum;
			k--;
		}
		while( k > 1 );
		return sum;
	}
}

int fiba( unsigned int k );


void main( void )
{
 int i;

 for( i = 0; i <= 10; i++ )
   printf( "FibC(%d) = %d FibA(%d) = %d\n", i, fibc( i ), i, fiba( i ) );
}