defmodule TwosumTest do
  use ExUnit.Case

  test "return the indices of two numbers that the sum match a specific target" do
    assert Twosum.solve(10, [1,2,3,4,5,6]) == {3,5}
  end

  test "return the {nil, nil} if there are matching sum" do
    assert Twosum.solve(10, [1,2,3,4,5]) == {nil, nil}
  end

  test "return the indices of two numbers that the sum match a specific target even if they are equal" do
    assert Twosum.solve(10, [1,5,2,3,4,5]) == {1, 5}
  end
end
