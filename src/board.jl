Block = Int8
Board = Matrix{Block}

const EMPTY_BLOCK = Int8(16)

@doc """
Check if a given index is within the bounds of a board.
""" ->
inbounds(idx::CartesianIndex) = (1 <= idx[1] <= 4) && (1 <= idx[2] <= 4)

@doc """
Check if two indices are adjacent.
""" ->
function adjacent(idx1::CartesianIndex, idx2::CartesianIndex)
    return abs((idx1[1] - idx2[1]) + (idx1[2] - idx2[2])) == 1
end

get_index(board::Board, block::Block) = findfirst(==(block), board)

function move(board::Board, block::Block)
    board = copy(board)
    e = get_index(board, EMPTY_BLOCK)
    b = get_index(board, block)
    if adjacent(e, b)
        board[e], board[b] = board[b], board[e]
    end
    return board
end

function neighbors(board::Board, block::Block)
    neighbors = Block[]
    idx = get_index(board, block)
    for direction in ((0, 1), (0, -1), (1, 0), (-1, 0))
        neighbor_idx = CartesianIndex(idx[1] + direction[1], idx[2] + direction[2])
        if inbounds(neighbor_idx)
            push!(neighbors, board[neighbor_idx])
        end
    end
    return neighbors
end