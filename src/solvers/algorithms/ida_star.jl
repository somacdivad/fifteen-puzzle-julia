function _ida_search(
    path::AbstractArray{Node},
    g::Int,
    bound::Int,
    h::Function,
    target::Board,
)
    node = last(path)
    f = g + h(node.board, target)
    f > bound && return f
    node.board == target && return true
    min = Inf64
    for neighbor in valid_moves(node)
        new_board = move(node.board, neighbor)
        new_node = Node(new_board, neighbor, node)
        if new_node ∉ path
            push!(path, new_node)
            t = _ida_search(path, g + h(node.board, new_node.board), bound, h, target)
            t == true && return true
            if t < min
                min = t
            end
            pop!(path)
        end
    end
    return min
end

function ida_star(board::Board, target::Board, h::Function)
    root = Node(board, EMPTY_BLOCK, nothing)
    path = Node[root]
    bound = h(board, target)
    while true
        t = _ida_search(path, 0, bound, h, target)
        t == true && return extract_moves(path[end])
        t == Inf64 && return extract_moves(root)
        bound = t
    end
end
