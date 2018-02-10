# https://leetcode.com/problems/two-sum

defmodule Twosum do
  def solve(target, list, existent_indexes \\ {0, %{}})

  def solve(_, [], _) do
    {nil, nil}
  end

  def solve(target, [head | tail], {i, existent}) do
    existent_inx = existent[target - head]

    if is_nil(existent_inx) do
      solve(target, tail, {i + 1, Map.put(existent, head, i)})
    else
      {existent_inx, i}
    end
  end
end
