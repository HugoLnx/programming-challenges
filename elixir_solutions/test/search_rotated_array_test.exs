defmodule SearchRotatedArrayTest do
  use ExUnit.Case
  import SearchRotatedArray

  test "return 0 if the searched number if the first in the array" do
    assert search({20, 100, 1, 10}, 20) == {:ok, 0}
  end

  test "return array size minus one if the searched number is the last" do
    assert search({20, 100, 1, 10}, 10) == {:ok, 3}
  end

  test "find the number if it is the first on the rotated array" do
    assert search({20, 100, 1, 10}, 1) == {:ok, 2}
  end

  test "find the number if it is the last on the rotated array" do
    assert search({20, 100, 1, 10}, 100) == {:ok, 1}
  end

  test "return error if the number were not found" do
    assert search({20, 100, 1, 10}, 3120) == {:error, :not_found}
  end

  test "return error if the array is empty" do
    assert search({}, 10) == {:error, :not_found}
  end

  test "geeksforgeeks: {5, 6, 7, 8, 9, 10, 1, 2, 3}, 3" do
    assert search({5, 6, 7, 8, 9, 10, 1, 2, 3}, 3) == {:ok, 8}
  end

  test "geeksforgeeks: {5, 6, 7, 8, 9, 10, 1, 2, 3}, 30" do
    assert search({5, 6, 7, 8, 9, 10, 1, 2, 3}, 30) == {:error, :not_found}
  end

  test "geeksforgeeks: {30, 40, 50, 10, 20}, 10" do
    assert search({30, 40, 50, 10, 20}, 10) == {:ok, 3}
  end
end
