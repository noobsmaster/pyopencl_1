import pyopencl as cl
import numpy
import os


# create context,queue and program

if __name__ == "__main__":

	os.environ['PYOPENCL_COMPILER_OUTPUT'] = '1'
	os.environ['PYOPENCL_NO_CACHE'] = '1'

	context = cl.create_some_context()
	queue = cl.CommandQueue(context)
	kernelsource = open('pykernel.cl').read()
	program = cl.Program(context, kernelsource).build()
	form_ident = program.form_iden_1     # one of the function in kernel
	# form_ident.set_scalar_arg_dtypes([numpy.bool])  # cast data type
	multip=program.bit_mul

	# create host arrays
	h_a = numpy.uint8(0b10100011)
	h_b = numpy.uint8(0b00111010)
	h_c = numpy.uint8(0b00001000)

	# h_c = numpy.empty_like(h_a)
	#Mdim = 4
	#Ndim = 4
	# Mdim is the number of rows
	# Ndim is the number of column

	# create device buffers
	mf = cl.mem_flags
	d_a = cl.Buffer(context, mf.READ_WRITE | mf.COPY_HOST_PTR, hostbuf=h_a)
	d_b = cl.Buffer(context, mf.READ_WRITE | mf.COPY_HOST_PTR, hostbuf=h_b)
	d_c = cl.Buffer(context, mf.WRITE_ONLY, h_c.nbytes)

	# run kernel
	#loopshape = (4, 4)
	#form_ident(queue, loopshape, None, d_a)
	multip.set_scalar_arg_dtypes([None ,None ,None ,numpy.uint8])
	multip(queue, 1, None, d_a, d_b, d_c,1)

	# return results
	cl.enqueue_copy(queue, h_c, d_c)

	print(h_c)
