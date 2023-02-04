using Base.Iterators: flatten

_parse_int(s::AbstractString) = s == "E" ? 16 : parse(Int, s)

@doc """
Parse a string into a 4x4 array of integers.

The string should be a 4x4 grid of integers, separated by newlines.
The empty space should be represented by the character 'E'.
""" ->
function parse_board(s::AbstractString)
    split_by_line = split(s, '\n'; keepempty=false)
    split_by_block =  split_by_line .|> split
    blocks_as_ints = flatten(split_by_block) .|> _parse_int
    return reshape(blocks_as_ints, (4, 4))' |> Board
end