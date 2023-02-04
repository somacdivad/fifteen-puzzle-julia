function _manhattan_distance(idx1::CartesianIndex, idx2::CartesianIndex)
    return abs(idx1[1] - idx2[1]) + abs(idx1[2] - idx2[2])
end

function manhattan(board::Board, target::Board)
    score = 0
    for block in board
        if block != EMPTY_BLOCK
            block_idx = get_index(board, block)
            target_idx = get_index(target, block)
            score += _manhattan_distance(block_idx, target_idx)
        end
    end
    return score
end