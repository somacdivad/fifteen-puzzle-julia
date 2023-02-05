function bfs(board::Board, target::Board)
    root = Node(board, EMPTY_BLOCK, nothing)
    unvisited = Node[root]
    seen = Set{Board}([root.board])
    while !isempty(unvisited)
        node = popfirst!(unvisited)
        for neighbor in valid_moves(node)
            new_board = move(node.board, neighbor)
            new_node = Node(new_board, neighbor, node)
            if new_board == target
                return extract_moves(new_node)
            elseif new_board ∉ seen
                push!(unvisited, new_node)
                push!(seen, new_board)
            end
        end
    end
    return extract_moves(root)
end
