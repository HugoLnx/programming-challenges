# https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/

defmodule RemoveDuplicated do
  def solve(list, last_el \\ nil)

  def solve([], _last_el) do
    []
  end

  def solve([head | tail], nil) do
    [head | solve(tail, head)]
  end

  def solve([head | tail], last_el) when head == last_el do
    solve(tail, head)
  end

  def solve([head | tail], _last_el) do
    [head | solve(tail, head)]
  end
end

defmodule RemoveDuplicated2 do
  def solve([head | tail]) do
    tail
    |> Enum.reduce({head, [head]}, fn
      el, {last_elem, new_list} when el == last_elem -> {el, new_list}
      el, {_last_elem, new_list} -> {el, [el | new_list]}
    end)
    |> elem(1)
    |> Enum.reverse()
  end
end
