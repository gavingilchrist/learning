cpdef int count_increases(int[:] depths):
    cdef int increase_counter, current_depth, depth, length, i
    length = depths.shape[0]
    current_depth = depths[0]
    increase_counter = 0
    for i in range(1, length):
        if depths[i] > current_depth:
            increase_counter += 1
        current_depth = depths[i]
    return increase_counter
