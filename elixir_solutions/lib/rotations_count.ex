# https://www.geeksforgeeks.org/find-rotation-count-rotated-sorted-array/
defmodule RotationsCount do
  defguardp found_break(tuple, i, j)
            when j == rem(i + 1, tuple_size(tuple)) and elem(tuple, i) > elem(tuple, j)

  def rotations(tuple, i \\ 1, j \\ 0)
  def rotations({}, _, _), do: 0
  def rotations(tuple, i, j) when found_break(tuple, i, j), do: j
  def rotations(tuple, i, j) when found_break(tuple, j, i), do: i

  def rotations(tuple, i, j) do
    k = circular_middle(i, j, tuple_size(tuple))

    cond do
      elem(tuple, k) < elem(tuple, i) -> rotations(tuple, i, k)
      true -> rotations(tuple, k, j)
    end
  end

  defp circular_middle(i, j, array_size) do
    size = ((j - i + array_size) |> rem(array_size)) + 1
    (i + div(size, 2)) |> rem(array_size)
  end
end
