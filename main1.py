import pyopencl as cl
import numpy
import os


# create context,queue and program

if __name__ == "__main__":

	os.environ['PYOPENCL_COMPILER_OUTPUT'] = '1'
	os.environ['PYOPENCL_NO_CACHE'] = '1'
	os.environ['PYOPENCL_CTX'] = '0:0'

	context = cl.create_some_context()
	queue = cl.CommandQueue(context)
	kernelsource = open('pykernel.cl').read()
	program = cl.Program(context, kernelsource).build()
	form_ident = program.form_iden     # one of the function in kernel

	# create host arrays
	h_a = numpy.random.randint(0, 256, 20).astype(numpy.uint8)
	h_b = numpy.empty_like(h_a)
	h_c = numpy.empty_like(h_a)
	h_d = numpy.empty_like(h_a)

	print('ori')
	print(h_a)

	# create device buffers
	mf = cl.mem_flags
	d_a = cl.Buffer(context, mf.READ_WRITE | mf.COPY_HOST_PTR, hostbuf=h_a)
	d_b = cl.Buffer(context, mf.WRITE_ONLY, h_b.nbytes)
	d_c = cl.Buffer(context, mf.WRITE_ONLY, h_c.nbytes)
	d_d = cl.Buffer(context, mf.WRITE_ONLY, h_d.nbytes)

	# run kernel
	# loopshape = (4, 4)
	form_ident.set_scalar_arg_dtypes([None, None, None, None])
	form_ident(queue, h_a.shape, None, d_a, d_b, d_c, d_d)

	# return results
	cl.enqueue_copy(queue, h_b, d_b)
	cl.enqueue_copy(queue, h_c, d_c)
	cl.enqueue_copy(queue, h_d, d_d)

	print('end')
	print(h_b)
	print('search for pivot')
	print(h_c)
	print('resultof bitcompare')
	print(h_d)