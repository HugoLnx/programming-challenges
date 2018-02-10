# https://leetcode.com/problems/sliding-window-smax/description/
# https://www.youtube.com/watch?v=39grPZtywyQ&t=963s
defmodule SlidingWindowMaximum do
  import Enum
  alias SlidingWindowMaximum, as: SMax

  defstruct ~w[userful_inxs max_list inx]a
  @empty_queue {[], []}

  def maximum(tuple, window_size) when tuple_size(tuple) < window_size,
    do: {:error, :window_is_too_big}

  def maximum(tuple, window_size) do
    %SMax{userful_inxs: :queue.new(), max_list: [], inx: 0}
    |> build_max_list(tuple, window_size)
    |> format_return
  end

  defp build_max_list(%SMax{max_list: max_list, inx: inx} = smax, tuple, _)
       when inx >= tuple_size(tuple),
       do: smax

  defp build_max_list(%SMax{} = smax, tuple, window_size) do
    smax
    |> remove_inxs_useless(tuple)
    |> remove_inxs_out_of_window(window_size)
    |> add_current_inx_as_userful
    |> add_to_max_list(tuple, window_size)
    |> increment_inx
    |> build_max_list(tuple, window_size)
  end

  defp add_current_inx_as_userful(%SMax{userful_inxs: inxs, inx: inx} = smax) do
    %{smax | userful_inxs: :queue.in(inx, inxs)}
  end

  defp remove_inxs_useless(%SMax{userful_inxs: @empty_queue} = smax, _), do: smax

  defp remove_inxs_useless(%SMax{userful_inxs: inxs, inx: inx} = smax, tuple) do
    {{:value, head}, tail} = :queue.out_r(inxs)

    if elem(tuple, head) <= elem(tuple, inx) do
      %{smax | userful_inxs: tail}
      |> remove_inxs_useless(tuple)
    else
      smax
    end
  end

  defp remove_inxs_out_of_window(%SMax{userful_inxs: @empty_queue} = smax, _), do: smax

  defp remove_inxs_out_of_window(
         %SMax{userful_inxs: inxs, inx: inx} = smax,
         window_size
       ) do
    {{:value, head}, tail} = :queue.out_r(inxs)

    if head <= inx - window_size do
      %{smax | userful_inxs: tail}
      |> remove_inxs_out_of_window(window_size)
    else
      smax
    end
  end

  defp add_to_max_list(%SMax{inx: inx} = smax, _, window_size)
       when inx < window_size - 1,
       do: smax

  defp add_to_max_list(
         %SMax{userful_inxs: inxs, max_list: max_list} = smax,
         tuple,
         _
       ) do
    %{smax | max_list: [elem(tuple, :queue.peek(inxs) |> elem(1)) | max_list]}
  end

  defp increment_inx(%SMax{inx: inx} = smax), do: %{smax | inx: inx + 1}

  defp format_return(%SMax{max_list: max_list}), do: {:ok, Enum.reverse(max_list)}
end
