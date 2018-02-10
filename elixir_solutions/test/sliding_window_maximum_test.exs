defmodule SlidingWindowMaximumTest do
  use ExUnit.Case
  import SlidingWindowMaximum

  test "get the maximum number of each subarray of a specified size" do
    result = maximum({1,3,-1,-3,5,3,6,7}, 3)
    assert result == {:ok, [3,3,5,5,6,7]}
  end

  test "get the maximum number of the array if window and array has the same size" do
    result = maximum({9, 3, 4, 5}, 4)
    assert result == {:ok, [9]}
  end

  test "return error if the window is bigger than the array" do
    result = maximum({1,2}, 10)
    assert result == {:error, :window_is_too_big}
  end
end
