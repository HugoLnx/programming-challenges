# https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/
defmodule SearchRotatedArray do
  def search(tuple, e) do
    r = rotations(tuple)
    binary_search(tuple, e, r, 0, tuple_size(tuple) - 1)
  end

  defp binary_search({}, _, _, _, _), do: {:error, :not_found}

  defp binary_search(tuple, e, r, i, j) do
    k = (i + j) |> div(2)

    cond do
      j < i -> {:error, :not_found}
      e == relem(tuple, r, k) -> {:ok, (r + k) |> rem(tuple_size(tuple))}
      e > relem(tuple, r, k) -> binary_search(tuple, e, r, k + 1, j)
      true -> binary_search(tuple, e, r, i, k - 1)
    end
  end

  defp relem(tuple, r, inx) do
    tuple |> elem((r + inx) |> rem(tuple_size(tuple)))
  end

  defguard found_break(tuple, i, j)
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
