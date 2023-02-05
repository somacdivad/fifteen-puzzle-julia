include("./src/fifteenpuzzle.jl")

using .FifteenPuzzle

board = parse_board("""
12 1 2 15
11 6 5 8
7 10 9 4
E 13 14 3
""")

println("Solving the following board:")
@show board

@time solution = solve(board)
@show solution
