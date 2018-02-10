defmodule SlidingWindowMaximum do
  @empty_queue {[], []}
  import Enum

  def maximum(tuple, window_size) when tuple_size(tuple) < window_size,
    do: {:error, :window_is_too_big}

  def maximum(tuple, window_size) do
    {:ok, get_maximum(tuple, window_size, :queue.new(), 0, [])}
  end

  defp get_maximum(tuple, _, _, inx, output) when inx >= tuple_size(tuple),
    do: Enum.reverse(output)

  defp get_maximum(tuple, window_size, userful_inxs, inx, output) do
    userful_inxs =
      userful_inxs
      |> remove_useless_inxs(tuple, elem(tuple, inx))
      |> remove_out_of_window_inxs(window_size, inx)

    userful_inxs = :queue.in(inx, userful_inxs)

    output = next_output(tuple, window_size, userful_inxs, inx, output)
    get_maximum(tuple, window_size, userful_inxs, inx + 1, output)
  end

  defp remove_useless_inxs(@empty_queue = userful_inxs, _, _), do: userful_inxs

  defp remove_useless_inxs(userful_inxs, tuple, value) do
    {{:value, head}, tail} = :queue.out_r(userful_inxs)

    if elem(tuple, head) < value,
      do: remove_useless_inxs(tail, tuple, value),
      else: userful_inxs
  end

  defp remove_out_of_window_inxs(@empty_queue = userful_inxs, _, _), do: userful_inxs

  defp remove_out_of_window_inxs(userful_inxs, window_size, inx) do
    {{:value, head}, tail} = :queue.out_r(userful_inxs)

    if head <= inx - window_size,
      do: remove_out_of_window_inxs(tail, window_size, inx),
      else: userful_inxs
  end

  defp next_output(_, window_size, _, inx, _) when inx < window_size - 1,
    do: []

  defp next_output(tuple, _, userful_inxs, _, output) do
    [elem(tuple, :queue.peek(userful_inxs) |> elem(1)) | output]
  end
end
