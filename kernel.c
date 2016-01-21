#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef unsigned int MY_INT;
typedef unsigned int D_INT;

int main(void)
{
	// int i = get_global_id(0); //number of arrays elements
	MY_INT a[20];
	MY_INT b[20];
	srand(time(NULL));

	for (int i = 0; i < 20; i++)
	{
		a[i]= rand() % 256;
		printf("%04x\t", a[i]);
	}
	printf(" random done\n");

	int asdf[20];

	D_INT m;
	D_INT n;
	MY_INT swap_temp;
	MY_INT xor_temp;

	for (m = 0; m < 8 ; m++ )
	{
		for (int i = 0; i < 20; i++)
		{
			printf("%04x\t", a[i]);
		}
		printf("\n");

		MY_INT bit_comparator = 1;
		bit_comparator = (bit_comparator << (8-1-m));

		printf("bitcom=%04x\n", bit_comparator);
		
		for (int i = 0; i < 20; i++)
		{
			if ( (a[i]&bit_comparator) == 0 )
			{
				asdf[i]=0;
			}
			else
			{
				asdf[i]=1;
			}
		}

		for (int i = 0; i < 20; i++)
		{
			printf("%d\t", asdf[i]);
		}	
		printf("\n\n");


		for (n = m; asdf[n] == 0 ; n++);    //search for 1
		if (n > m)                      //swap if needed
		{
			swap_temp = a[n];
			a[n] = a[m];
			a[m] = swap_temp;
		}
		asdf[m]=0;
		asdf[n]=0;
		xor_temp = a[m];

		for (int i = 0; i < 20; i++)
		{
			if (asdf[i] == 1)
			{
				a[i] = a[i] ^ xor_temp;
			}
		}

	}
	for (int i = 0; i < 20; i++)
	{
		b[i] = a[i];
		printf("%04x\t", b[i]);
	}
	printf("\n");

return 0;
}