defmodule Num do
  defstruct start: 0, finish: 0, value: ""
end

defmodule Day3 do
  def part_one(content) do
    with {nums, heat} <- content |> String.to_charlist() |> parse() do
      hits = heat |> Enum.filter(fn xy -> Map.has_key?(nums, xy) end) |> Enum.reverse()

      nums
      |> Enum.group_by(fn {{_, y}, _} -> y end)
      |> Map.new(fn {key, list} ->
        list |> IO.inspect()
        {
          key,
          {
            for {x, y} <- hits, y == key do
              x
            end,
            Enum.map(list, fn {{x, _}, v} -> {x, v} end) |> connect()
          }
        }
      end)
      |> Map.values()
      |> Enum.map(fn {h, n} -> get_res(h, n) end)
      |> Enum.sum()
      |> IO.inspect()
    end
  end

  def get_res(hitted, nums) do
    nums
    |> Enum.filter(fn {start, finish, _} ->
      Enum.any?(start..finish, &Enum.member?(hitted, &1))
    end)
    |> Enum.map(fn {_, _, v} -> String.to_integer(v) end)
    |> Enum.sum()
  end

  def connect([]), do: []

  def connect(line) do
    line = line |> Enum.sort(fn {a, _}, {b, _} -> a <= b end)

    {x, v} = hd(line)

    l =
      Enum.reduce(tl(line), %{prev: x, start: x, current: v, result: []}, fn {x, v}, acc ->
        if x - 1 == acc.prev do
          %{
            prev: x,
            start: acc.start,
            current: acc.current <> v,
            result: acc.result
          }
        else
          %{
            prev: x,
            start: x,
            current: v,
            result: [{acc.start, acc.prev, acc.current} | acc.result]
          }
        end
      end)

    [{l.start, l.prev, l.current} | l.result] |> Enum.reverse()
  end

  defp parse(content) when is_list(content), do: parse(content, [], [], 0, 0)

  defp parse([], nums, chars, _x, _y) do
    {nums |> Map.new(), heats(chars)}
  end

  defp parse([c | rest], nums, chars, x, y) do
    case c do
      ?\n ->
        parse(rest, nums, chars, 0, y + 1)

      c when c in ?0..?9 ->
        parse(rest, [{{x, y}, to_string([c])} | nums], chars, x + 1, y)

      ?. ->
        parse(rest, nums, chars, x + 1, y)

      _ ->
        parse(rest, nums, [{x, y} | chars], x + 1, y)
    end
  end

  defp heats([]), do: []

  defp heats([{x, y} | rest]) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1}
      | heats(rest)
    ]
  end
end
