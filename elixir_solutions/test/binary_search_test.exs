defmodule BinarySearchTest do
  use ExUnit.Case
  import BinarySearch

  test "does not find anything in an empty array" do
    result = {} |> search(10)
    assert result == {:error, :not_found}
  end

  test "return not found if the element are not present" do
    result = {1, 2, 3, 4, 5} |> search(10)
    assert result == {:error, :not_found}
  end

  test "return the index of the specified element on the array" do
    result = {1, 2, 3, 4, 10} |> search(3)
    assert result == {:ok, 2}
  end

  test "return the index of the first ocurrence element on the array with odd size" do
    result = {1, 3, 3, 3, 4} |> search(3)
    assert result == {:ok, 1}
  end
end
