defmodule RotationsCountTest do
  use ExUnit.Test
  import RotationsCount

  test "return 0 if it is not rotated" do
    assert rotations({1, 10, 20, 100}) == 0
  end

  test "return 1 if it was rotated once" do
    assert rotations({100, 1, 10, 20}) == 1
  end

  test "return 2 if it was rotated twice" do
    assert rotations({20, 100, 1, 10}) == 2
  end

  test "return 0 if the array is empty" do
    assert rotations({}) == 0
  end
end
