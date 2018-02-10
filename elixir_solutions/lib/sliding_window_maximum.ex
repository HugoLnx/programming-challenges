defmodule SlidingWindowMaximum do
  import Enum

  def maximum(tuple, window_size) when tuple_size(tuple) < window_size,
    do: {:error, :window_is_too_big}

  def maximum(tuple, window_size) do
    {:ok, get_maximum(tuple, window_size, [], 0, [])}
  end

  defp get_maximum(tuple, _, _, inx, output) when inx >= tuple_size(tuple),
    do: Enum.reverse(output)

  defp get_maximum(tuple, window_size, userful_inxs, inx, output) do
    userful_inxs =
      userful_inxs
      |> remove_useless_inxs(tuple, elem(tuple, inx))
      |> remove_out_of_window_inxs(window_size, inx)

    userful_inxs = [inx | userful_inxs]

    output = next_output(tuple, window_size, userful_inxs, inx, output)
    get_maximum(tuple, window_size, userful_inxs, inx + 1, output)
  end

  defp remove_useless_inxs([], _, _), do: []

  defp remove_useless_inxs([head | tail] = userful_inxs, tuple, value)
       when elem(tuple, head) < value,
       do: remove_useless_inxs(tail, tuple, value)

  defp remove_useless_inxs([head | tail] = userful_inxs, _tuple, _value), do: userful_inxs

  defp remove_out_of_window_inxs([], _, _), do: []

  defp remove_out_of_window_inxs([head | tail] = userful_inxs, window_size, inx)
       when head <= inx - window_size,
       do: remove_out_of_window_inxs(tail, window_size, inx)

  defp remove_out_of_window_inxs(userful_inxs, window_size, inx), do: userful_inxs

  defp next_output(_tuple, window_size, _userful_inxs, inx, _output) when inx < window_size - 1,
    do: []

  defp next_output(tuple, _window_size, userful_inxs, _inx, output) do
    [elem(tuple, List.last(userful_inxs)) | output]
  end
end
