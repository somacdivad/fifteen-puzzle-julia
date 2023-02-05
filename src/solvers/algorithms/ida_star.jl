function _ida_search(path::AbstractArray{Node}, g::Int, bound::Int, heuristic::Function, target::Board)
    node = last(path)
    f = g + heuristic(node.board, target)
    f > bound && return f
    node.board == target && return true
    min = Inf64
    for neighbor in valid_moves(node)
        new_board = move(node.board, neighbor)
        new_node = Node(new_board, neighbor, node)
        if new_node ∉ path
            push!(path, new_node)
            t = _ida_search(path, g + heuristic(node.board, new_node.board), bound, heuristic, target)
            t == true && return true
            if t < min
                min = t
            end
            pop!(path)
        end
    end
    return min
end

function ida_star(board::Board, target::Board, heuristic::Function)
    root = Node(board, EMPTY_BLOCK, nothing)
    path = Node[root]
    bound = heuristic(board, target)
    while true
        t = _ida_search(path, 0, bound, heuristic, target)
        t == true && return extract_moves(path[end])
        t == Inf64 && return Node[]
        bound = t
    end
end