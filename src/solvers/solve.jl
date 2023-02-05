using DataStructures: PriorityQueue, dequeue!, enqueue!
using DataStructures: DefaultDict

const TARGET = reshape(1:16, (4, 4))' |> Board

struct Node
    board::Board
    move::Block
    parent::Union{Node, Nothing}
end
Base.:(==)(a::Node, b::Node) = a.board == b.board

function valid_moves(node::Node)
    return filter((m) -> m != node.move, neighbors(node.board, EMPTY_BLOCK))
end

function extract_moves(node::Node)
    moves = Block[]
    while node.parent !== nothing
        pushfirst!(moves, node.move)
        node = node.parent
    end
    return moves
end

include("./heuristics/manhattan.jl")
include("./heuristics/manhattan_plus.jl")
include("./algorithms/bfs.jl")
include("./algorithms/a_star.jl")
include("./algorithms/ida_star.jl")

function solve(board::Board; target::Board = TARGET, alg::Function = ida_star, heuristic::Union{Function, Nothing} = manhattan)
    if alg == bfs
        return alg(board, target)
    else
        return alg(board, target, heuristic)
    end
end