typedef unsigned char MY_INT;

__kernel void bit_mul(__global MY_INT* a, __global MY_INT* b, __global MY_INT* c)
{
    int i = get_global_id(0);

    c[i] = a[i] ^ b[i];
}


/*
__kernel void form_iden_1(__global MY_INT* a, __global MY_INT* b, __global MY_INT* c)
{
    int i = get_global_id(0); //mainly use downwards
    int j = get_global_id(1); //mainly use to the right


    bool asdf[5] = {1,0,1,1,0};
    const int Mdim = 4 ;
    const int Ndim = 4 ;
    //int m = a[2];
    //printf("value of a2 = %d \n",m);

    int tempmat[Ndim] = {0};

    if ((i < Mdim) && (j < Ndim)) //limiting the work item on dimension of mat
    {
        for ( int k = 0; k < Ndim; k++ )
        {
            int pivot_cand[Mdim]= {0};

            // check all element in the column for '1'
            if (( a[ i*Ndim + k] ) != 0)
            {
                pivot_cand[i] = 1;
            }

            // if the pivot is currently zero
            if( pivot_cand[k] == 0)
            {
                //find the pivot  // to be optimized
                for (  l=k+1; l < Mdim ; l++ )
                {
                    if (pivot_cand[l]!=0)
                        break;
                }

                //swapping pivot row
                tempmat[j] = a[ l*Ndim + j ];
                a[ l*Ndim + j] = a[ k*Ndim + j ];
                a[ k*Ndim + j] = tempmat[j];
            }
            // clearing the non pivot element
            if( (i != k) && (pivot_cand[i]!=0) )         //work item to skip the pivot element
            {
                a[ i*Ndim + j ]  = a[ i*Ndim + j ] + a[ k*Ndim + j ];

            }
        }
    }

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