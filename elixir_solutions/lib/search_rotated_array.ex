# https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/
# https://www.youtube.com/watch?v=uufaK2uLnSI&t=250s
defmodule SearchRotatedArray do
  def search(tuple, target, i \\ nil, j \\ nil)
  def search(tuple, target, nil, nil), do: search(tuple, target, 0, tuple_size(tuple) - 1)
  def search(tuple, target, i, j) when j < i, do: {:error, :not_found}

  def search(tuple, target, i, j) do
    k = (i + j) |> div(2)

    cond do
      elem(tuple, k) == target ->
        {:ok, k}

      elem(tuple, i) < elem(tuple, k) ->
        if elem(tuple, i) <= target and target < elem(tuple, k),
          do: search(tuple, target, i, k - 1),
          else: search(tuple, target, k + 1, j)

      elem(tuple, j) > elem(tuple, k) ->
        if elem(tuple, k) < target and target <= elem(tuple, j),
          do: search(tuple, target, k + 1, j),
          else: search(tuple, target, i, k - 1)

      true ->
        {:error, :not_found}
    end
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
