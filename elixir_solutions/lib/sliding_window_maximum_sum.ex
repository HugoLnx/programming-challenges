defmodule SlidingWindowMaximumSum do
  import Enum

  def max_window(tuple, window_size) when tuple_size(tuple) < window_size do
    {:error, :window_is_too_big}
  end

  def max_window(tuple, window_size) do
    window_sum = 0..(window_size - 1) |> reduce(0, fn i, sum -> elem(tuple, i) + sum end)
    slide_through(tuple, window_size, 1, window_sum, window_sum)
  end

  def slide_through(tuple, window_size, window_inx, prev_window_sum, max_sum)
      when window_size + window_inx > tuple_size(tuple) do
    {:ok, max_sum}
  end

  def slide_through(tuple, window_size, window_inx, prev_window_sum, max_sum) do
    window_sum =
      prev_window_sum - elem(tuple, window_inx - 1) + elem(tuple, window_inx + window_size - 1)

    slide_through(tuple, window_size, window_inx + 1, window_sum, max([max_sum, window_sum]))
  end
end
