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
end
