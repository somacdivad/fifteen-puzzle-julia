module FifteenPuzzle
    include("./board.jl")
    include("./parse.jl")
    include("./solvers/solve.jl")

    export Board, Block
    export parse_board
    export move
    export solve, bfs, a_star, ida_star
    export manhattan, manhattan_plus
end