//---------------------------------------------------------------
// Program lab_9a - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o lab_9a lab_9a.c lab_9a_asm.s
// To run:          ./lab_9a
//
//---------------------------------------------------------------

#include <stdio.h>

int factc( unsigned int k )
{
	int result = 1;
	while( k > 1 )
	   result *= k--;
	return result;			
}

int facta( unsigned int k );

void main( void )
{
 int i;

 for( i = 1; i <= 6; i++ )
   printf( "FactC(%d) = %d FactA(%d) = %d\n", i, factc(i), i, facta(i) );
}