defmodule RemoveDuplicatedTest do
  use ExUnit.Case
  # alias RemoveDuplicated2, as: RemoveDuplicated

  test "removes a sequential double duplication" do
    assert RemoveDuplicated.solve([1,1,2,3,3,4,5,5]) == [1,2,3,4,5]
  end

  test "removes a sequential triple duplication" do
    assert RemoveDuplicated.solve([1,1,1,2,3,3,3,4,5,5,5]) == [1,2,3,4,5]
  end

  test "does not remove a non sequential duplication" do
    assert RemoveDuplicated.solve([1,2,1,2,3]) == [1,2,1,2,3]
  end
end
