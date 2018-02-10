defmodule BinarySearch do
  defstruct ~w[tuple found]a
  alias BinarySearch, as: BSearch

  def search(tuple, element) do
    %BSearch{tuple: tuple, found: nil}
    |> binary_search(element, 0, tuple_size(tuple) - 1)
    |> jump_to_first_ocurrence
    |> format_return
  end

  defp binary_search(%BSearch{tuple: {}} = search, _, _, _), do: search
  defp binary_search(%BSearch{} = search, _, b, e) when b > e, do: search

  defp binary_search(%BSearch{tuple: tuple} = search, element_to_be_found, b, e) do
    middle_inx = (b + e) |> div(2)
    middle_element = elem(tuple, middle_inx)

    cond do
      element_to_be_found == middle_element ->
        %{search | found: middle_inx}

      element_to_be_found > middle_element ->
        binary_search(search, element_to_be_found, b, middle_inx - 1)

      element_to_be_found < middle_element ->
        binary_search(search, element_to_be_found, middle_inx + 1, e)
    end
  end

  defp jump_to_first_ocurrence(%BSearch{found: nil} = search), do: search
  defp jump_to_first_ocurrence(%BSearch{tuple: tuple, found: 0} = search), do: search

  defp jump_to_first_ocurrence(%BSearch{tuple: tuple, found: inx} = search) do
    if elem(tuple, inx - 1) == elem(tuple, inx),
      do: %{search | found: search.found - 1},
      else: search
  end

  defp format_return(%BSearch{found: nil}), do: {:error, :not_found}
  defp format_return(%BSearch{found: inx}), do: {:ok, inx}
end
