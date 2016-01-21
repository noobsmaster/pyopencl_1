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
	form_ident = program.form_iden     # one of the function in kernel

	# create host arrays
	h_a = numpy.random.randint(0, 256, 20).astype(numpy.uint8)
	h_b = numpy.empty_like(h_a)

	# create device buffers
	mf = cl.mem_flags
	d_a = cl.Buffer(context, mf.READ_WRITE | mf.COPY_HOST_PTR, hostbuf=h_a)
	d_b = cl.Buffer(context, mf.WRITE_ONLY, h_b.nbytes)

	# run kernel
	# loopshape = (4, 4)
	form_ident.set_scalar_arg_dtypes([None,None])
	form_ident(queue, h_a.shape, None, d_a, d_b)

	# return results
	cl.enqueue_copy(queue, h_b, d_b)

	print(h_b)
