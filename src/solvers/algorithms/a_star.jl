function a_star(board::Board, target::Board, h::Function)
    unvisited = PriorityQueue{Node, Int}()
    g_score = DefaultDict{Node, Float64}(Inf64)
    f_score = DefaultDict{Node, Float64}(Inf64)

    # Initialize algorithm with root node starting at the empty block
    root = Node(board, EMPTY_BLOCK, nothing)
    enqueue!(unvisited, root, 0)
    g_score[root] = 0
    f_score[root] = h(board, target)

    # Search for the target board
    while !isempty(unvisited)
        node = dequeue!(unvisited)
        node.board == target && return extract_moves(node)
        for neighbor in valid_moves(node)
            new_board = move(node.board, neighbor)
            new_node = Node(new_board, neighbor, node)
            new_g_score = g_score[node] + h(node.board, new_node.board)
            if new_g_score < g_score[new_node]
                g_score[new_node] = new_g_score
                f_score[new_node] = new_g_score + h(new_board, target)
                if new_node ∉ keys(unvisited)
                    enqueue!(unvisited, new_node, f_score[new_node])
                end
            end
        end
    end
    return []
end