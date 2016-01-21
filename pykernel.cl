typedef unsigned char MY_INT;
typedef unsigned int D_INT;

__kernel void bit_mul(__global MY_INT* a, __global MY_INT* b, __global MY_INT* c)
{
    int i = get_global_id(0);

    c[i] = a[i] ^ b[i];
}


__kernel void form_iden(__global MY_INT* a, __global MY_INT* b)
{
    int i = get_global_id(0); //number of arrays elements

    bool asdf[20];

    D_INT m;
    D_INT n;
    MY_INT swap_temp;
    MY_INT xor_temp;

    for (m = 0; m < 8 ; m++ )
    {
        if (a[i] < (2^(8-m)) && a[i] > (2^(8-m-1)) )
        {
            asdf[i]=1;
        }
        else
        {
            asdf[i]=0;
        }

        for (n = 0; asdf[n] == 0 ; n++);    //search for 1
        if (n > m)                      //swap if needed
        {
            swap_temp = a[n];
            a[n] = a[m];
            a[m] = swap_temp;
        }
        asdf[m]=0;
        xor_temp = a[m];
        if (asdf[i] == 1)
        {
            a[i] = a[i] ^ xor_temp;
        }
    }
    b[i] = a[i];


}

/*
__kernel void form_upper_tri(__global bool* a, __global bool* b)
{
	unsigned int m = sizeof(a);
	// printf ("number of rows:");
	// printf m;

	unsigned int n = sizeof(a[0]);
	// printf ("number of column:");
	// printf n;

	unsigned int i;
	unsigned int k;

	for( i = 0 ; i < n-1 ; i++)			//for every row from top to bottom until n row,
	{
		if ( a[i][i] == 0)				//check if pivot element is '0'
		{
			unsigned int pivot_cand[m]= {0};
			unsigned int j = get_global_id(0);

			if ( a[j][i] == 1)
			{
				pivot_cand[j]=1;
			} // marking the candidate row

			for( k = 0 ; k < m-1 ; k++)
			{
				if (pivot_cand[m-k]==1)
				{
					b[i]=a[m-k];							//copy row with pivot element over

					unsigned int y = get_global_id(0);
					unsigned int x = get_global_id(1);		//clear all the element at column[i]

					if (pivot_cand[y]==1)
					{
						a[y][x]=a[y][x]^b[i][x];
					}
				}
			}
		}
		else
		{
			b[i]=a[i];

			unsigned int y = get_global_id(0);				//clear all the element at column[i]
			unsigned int x = get_global_id(1);

			if (a[y][i]==1)
			{
				a[y][x]=a[y][x]^b[i][x];
			}
		}
	}
// at this point, the b matrix should be in upper triangular format
}

__kernel void form_ident(__global bool* a, __global bool* b)
{
	unsigned int m = sizeof(a);
	printf ("number of rows:");
	printf m;

	unsigned int n = sizeof(a[0]);
	printf ("number of column:");
	printf n;

	bool temp1[m][n]= {0};
	bool temp2[m][n]= {0};

	temp1 = a;

	for( i = 0 ; i < n-2 ; i++)			//for every row from top to bottom until n row,
	{
		unsigned int y = get_global_id(0);
		unsigned int x = get_global_id(1);

		if ( (x+1+i)<n &&  )
		{
			if (a[y][x+1+i]==1)
			{
				temp2[y][x]=temp1[y][x]^temp1[y+1][x];
			}
		}



	}

}
*/