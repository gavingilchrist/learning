def count_increases_py(depths):
    current_depth = depths[0]
    increase_counter = 0
    for depth in depths[1:]:
        if depth > current_depth:
            increase_counter += 1
        current_depth = depth
    return increase_counter


# def count_increases_py(depths):
#     increase_counter = 0
#     for i in range(1, len(depths)):
#         if depths[i] > depths[i-1]:
#             increase_counter += 1
#     return increase_counter


# def count_increases_py(depths):
#     increase_counter = 0
#     ix = 0
#     stopix = len(depths) - 1
#     while ix < stopix:
#         current_depth = depths[ix]
#         ix += 1
#         if depths[ix] > current_depth:
#             increase_counter += 1
#     return increase_counter
