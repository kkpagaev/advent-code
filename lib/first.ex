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

  def part_two(content) do
    content
    |> String.split("\n")
    |> map(fn l -> 
      parse_str(l) |> String.to_charlist |> hd_last()
    end)
    |> sum
    |> IO.inspect
  end

  defp parse_str("") do
    <<>>
  end

  defp parse_str("one" <> rest), do: "1" <> parse_str("e" <> rest)
  defp parse_str("two" <> rest), do: "2" <> parse_str("o" <> rest)
  defp parse_str("three" <> rest), do: "3" <> parse_str("e" <> rest)
  defp parse_str("four" <> rest), do: "4" <> parse_str("r" <> rest)
  defp parse_str("five" <> rest), do: "5" <> parse_str("e" <> rest)
  defp parse_str("six" <> rest), do: "6" <> parse_str("x" <> rest)
  defp parse_str("seven" <> rest), do: "7" <> parse_str("n" <> rest)
  defp parse_str("eight" <> rest), do: "8" <> parse_str("t" <> rest)
  defp parse_str("nine" <> rest), do: "9" <> parse_str("e" <> rest)
  defp parse_str("zero" <> rest), do: "0" <> parse_str("o" <> rest)

  defp parse_str(<<c, rest::binary>>) do
    if c >= 48 && c <= 57 do
      <<c>> <> parse_str(rest)
    else
      parse_str(rest)
    end
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
