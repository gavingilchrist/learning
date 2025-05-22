import time
import pure_python_example
import cython_example

n = 1000000

start_time = time.time()
pure_python_example.sum_of_squares_py(n)
end_time = time.time()
print(f"Pure Python time: {end_time - start_time:.4f} seconds")

start_time = time.time()
cython_example.sum_of_squares_cy(n)
end_time = time.time()
print(f"Cython time: {end_time - start_time:.4f} seconds")
