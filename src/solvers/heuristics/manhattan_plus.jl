function _col_conflicts(board::Board, target::Board)
    num_conflicts = 0
    for col in eachcol(board)
        for i in 1:4, j in i+1:4
            if col[i] != EMPTY_BLOCK && col[j] != EMPTY_BLOCK
                target_idx_i = get_index(target, col[i])
                target_idx_j = get_index(target, col[j])
                if target_idx_i[2] == target_idx_j[2]
                    if target_idx_i[1] > target_idx_j[1]
                        num_conflicts += 1
                    end
                end
            end
        end
    end
    return num_conflicts
end

_row_conflicts(board::Board, target::Board) = _col_conflicts(Board(board'), Board(target'))

function linear_conflicts(board::Board, target::Board)
    return _col_conflicts(board, target) + _row_conflicts(board, target)
end

function manhattan_plus(board::Board, target::Board)
    return manhattan(board, target) + 2 * linear_conflicts(board, target)
end