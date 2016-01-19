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

	# create host arrays
	h_a = numpy.array([0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], dtype=numpy.float32)

	h_b = numpy.empty_like(h_a)
	# h_c = numpy.empty_like(h_a)
	Mdim = 4
	Ndim = 4
	# Mdim is the number of rows
	# Ndim is the number of column

	# create device buffers
	mf = cl.mem_flags
	d_a = cl.Buffer(context, mf.READ_WRITE | mf.COPY_HOST_PTR, hostbuf=h_a)
	d_b = cl.Buffer(context, mf.READ_WRITE, h_b.nbytes)
	# d_c = cl.enqueue_write_buffer_rect(, )

	# run kernel
	loopshape = (4, 4)
	form_ident(queue, loopshape, None, d_a)

	# return results
	cl.enqueue_copy(queue, h_b, d_a)

	print(h_b)
