defmodule SlidingWindowMaximumSumTest do
  use ExUnit.Case
  import SlidingWindowMaximumSum

  test "return the greatest sum of the numbers on a window" do
    result = {0, 1, 3, 5, 1, 20} |> max_window(3)
    assert result == {:ok, 26}
  end

  test "return the greatest sum of the numbers on a window even if it has negative numbers" do
    result = {-10, 20, 1, -3, 5, 18, -3, 20} |> max_window(3)
    assert result == {:ok, 35}
  end

  test "return the sum of all the array if window size is equal array size" do
    result = {0, 1, 3, 5, 1, 20} |> max_window(6)
    assert result == {:ok, 30}
  end

  test "return error if the window size is bigger than the array" do
    result = {0, 1, 3, 5, 1, 20} |> max_window(100)
    assert result == {:error, :window_is_too_big}
  end
end
