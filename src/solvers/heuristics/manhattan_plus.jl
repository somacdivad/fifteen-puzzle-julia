function _col_conflicts(board::Board, target::Board)
    num_conflicts = 0
    for col in eachcol(board)
        for i in 1:4, j in i+1:4
            if col[i] != EMPTY_BLOCK && col[j] != EMPTY_BLOCK
                target_i = get_index(target, col[i])
                target_j = get_index(target, col[j])
                in_same_col = target_i[2] == target_j[2]
                out_of_order = target_i[1] > target_j[1]
                if in_same_col && out_of_order
                    num_conflicts += 1
                end
            end
        end
    end
    return num_conflicts
end

_row_conflicts(b::Board, t::Board) = _col_conflicts(Board(b'), Board(t'))
_conflicts(b::Board, t::Board) = _col_conflicts(b, t) + _row_conflicts(b, t)
manhattan_plus(b::Board, t::Board) = manhattan(b, t) + 2 * _conflicts(b, t)