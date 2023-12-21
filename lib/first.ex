defmodule Day1 do
  import Enum

  @numbers %{
    48 => 0,
    49 => 1,
    50 => 2,
    51 => 3,
    52 => 4,
    53 => 5,
    54 => 6,
    55 => 7,
    56 => 8,
    57 => 9
  }

  def run(content) do
    content
    |> String.split("\n")
    # 48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    |> map(fn s ->
      String.to_charlist(s) |> filter(&(&1 >= 48 && &1 <= 57)) |> hd_last()
    end)
    # |> reverse()
    |> sum()
    |> IO.inspect(charlists: :as_list)

    # IO.puts(content)
  end

  
  defp hd_last([]) do
    0
  end

  # return first and last elements from the list
  defp hd_last(list) do
    first = hd(list)
    last = List.last(list)
    String.to_integer(to_string(@numbers[first]) <> to_string(@numbers[last]))
    # first + last
  end
end
