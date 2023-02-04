function reconstruct_path(came_from::Dict{Node, Node}, current::Node)
    total_path = Block[current.move]
    while current ∈ keys(came_from)
        current = came_from[current]
        if current.move != EMPTY_BLOCK
            push!(total_path, current.move)
        end
    end
    return reverse(total_path)
end

function a_star(board::Board, target::Board, heuristic::Function)
    root = Node(board, EMPTY_BLOCK, nothing)
    unvisited = PriorityQueue{Node, Int}()
    unvisited[root] = 0
    came_from = Dict{Node, Node}()
    g_score = DefaultDict{Node, Float64}(Inf64)
    g_score[root] = 0
    f_score = DefaultDict{Node, Float64}(Inf64)
    f_score[root] = heuristic(board, target)
    while !isempty(unvisited)
        node = dequeue!(unvisited)
        node.board == target && return reconstruct_path(came_from, node)
        for neighbor in valid_moves(node)
            new_board = move(node.board, neighbor)
            new_node = Node(new_board, neighbor, node)
            tentative_g_score = g_score[node] + heuristic(node.board, new_node.board)
            if tentative_g_score < g_score[new_node]
                came_from[new_node] = node
                g_score[new_node] = tentative_g_score
                f_score[new_node] = tentative_g_score + heuristic(new_board, target)
                if new_node ∉ keys(unvisited)
                    enqueue!(unvisited, new_node, f_score[new_node])
                end
            end
        end
    end
    return Stack{Node}()
end