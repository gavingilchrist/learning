def sum_of_squares_cy(int n):
    cdef long long result = 0
    cdef long long i
    for i in range(n):
        result += i * i
    return result
