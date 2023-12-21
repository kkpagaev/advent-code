defmodule Round do
  defstruct red: 0, green: 0, blue: 0

  def is_valid(%Round{red: r, green: g, blue: b}) do
    r <= 12 && g <= 13 && b <= 14
  end

  def add(round, %Round{red: r, green: g, blue: b}) do
    %Round{
      red: round.red + r,
      green: round.green + g,
      blue: round.blue + b
    }
  end

  def maximum(round, %Round{red: r, green: g, blue: b}) do
    %Round{
      red: max(round.red, r),
      green: max(round.green, g),
      blue: max(round.blue, b)
    }
  end

  def score(%Round{red: r, green: g, blue: b}) do
    r * g * b
  end
end

defmodule Game do
  defstruct level: 0, rounds: []

  def is_valid(game) do
    game.rounds
    |> Enum.all?(&Round.is_valid/1)
  end

  def power(game) do
    game.rounds
    |> Enum.reduce(&Round.maximum(&1, &2))
    |> Round.score()
  end
end

defmodule Day2 do
  import Enum

  def part_one(content) do
    content
    |> String.split("\n")
    |> reverse()
    |> tl()
    |> map(&parse_game/1)
    |> filter(&Game.is_valid/1)
    |> map(fn g -> g.level end)
    |> sum()
    |> IO.inspect()
  end

  def part_two(content) do
    content
    |> String.split("\n")
    |> reverse()
    |> tl()
    |> map(&parse_game/1)
    |> map(&Game.power/1)
    |> sum()
    |> IO.inspect()
  end

  def parse_game("Game " <> line) do
    with [level, rounds] <- String.split(line, ":") do
      %Game{
        level: level |> String.to_integer(),
        rounds: rounds |> String.split(";") |> map(&parse_round/1)
      }
    end
  end

  def parse_round(line) do
    line
    |> String.replace(" ", "")
    |> String.split(",")
    |> map(&parse_ball/1)
    |> reduce(
      %Round{},
      fn {k, v}, acc -> Map.put(acc, k, v) end
    )
  end

  def parse_ball(r), do: parse_ball(r, "")

  defp parse_ball("red", count) do
    {:red, String.to_integer(count)}
  end

  defp parse_ball("green", count) do
    {:green, String.to_integer(count)}
  end

  defp parse_ball("blue", count) do
    {:blue, String.to_integer(count)}
  end

  defp parse_ball(<<c, rest::binary>>, count) do
    parse_ball(rest, count <> <<c>>)
  end
end
