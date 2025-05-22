# def count_increases_cy(int[:] depths):
#     cdef int current_depth = depths[0]
#     cdef int increase_counter = 0
#     cdef Py_ssize_t n = depths.shape[0]
#     cdef Py_ssize_t i
#     for i in range(1, n):
#         if depths[i] > current_depth:
#             increase_counter += 1
#         current_depth = depths[i]
#     return increase_counter


# def count_increases_cy(int[:] depths):
#     cdef int increase_counter = 0
#     cdef Py_ssize_t n = depths.shape[0]
#     cdef Py_ssize_t i
#     for i in range(1, n):
#         if depths[i] > depths[i-1]:
#             increase_counter += 1
#     return increase_counter


def count_increases_cy(int[:] depths):
    cdef int increase_counter = 0
    cdef Py_ssize_t ix = 0
    cdef Py_ssize_t stopix = depths.shape[0] - 1
    while ix < stopix:
        current_depth = depths[ix]
        ix += 1
        if depths[ix] > current_depth:
            increase_counter += 1
    return increase_counter
