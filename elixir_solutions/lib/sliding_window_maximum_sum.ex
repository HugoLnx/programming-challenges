defmodule SlidingWindowMaximumSum do
  import Enum

  alias SlidingWindowMaximumSum, as: MSum

  defstruct ~w[tuple window_size window_inx window_sum max_sum]a

  def max_window(tuple, window_size) when tuple_size(tuple) < window_size,
    do: {:error, :window_is_too_big}

  def max_window(tuple, window_size) do
    %MSum{tuple: tuple, window_size: window_size, window_inx: 0, window_sum: nil, max_sum: nil}
    |> calculate_window_sum
    |> update_max_sum
    |> slide_through
    |> format_return
  end

  defp calculate_window_sum(%MSum{tuple: tuple, window_size: size, window_inx: inx} = maximum) do
    %{maximum | window_sum: sum_tuple_slice(tuple, inx, size)}
  end

  defp update_max_sum(%MSum{window_sum: sum, max_sum: nil} = maximum),
    do: %{maximum | max_sum: sum}

  defp update_max_sum(%MSum{window_sum: sum, max_sum: max_sum} = maximum),
    do: %{maximum | max_sum: max([sum, max_sum])}

  defp slide_through(%MSum{tuple: tuple, window_size: size, window_inx: inx} = maximum)
       when size + inx >= tuple_size(tuple),
       do: maximum

  defp slide_through(%MSum{} = maximum) do
    maximum
    |> step
    |> update_max_sum
    |> slide_through
  end

  defp step(%MSum{tuple: tuple, window_size: size, window_inx: inx, window_sum: sum} = maximum) do
    %{maximum | window_sum: sum - elem(tuple, inx) + elem(tuple, inx + size), window_inx: inx + 1}
  end

  defp format_return(%MSum{max_sum: max_sum}), do: {:ok, max_sum}

  defp sum_tuple_slice(tuple, slice_inx, slice_size) do
    slice_inx..(slice_size - 1)
    |> reduce(0, fn i, sum -> elem(tuple, i) + sum end)
  end
end
