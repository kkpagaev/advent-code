defmodule Advent do
  @moduledoc """
  Documentation for `Advent`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Advent.hello()
      :world

  """
  def hello do
    :world
  end

  def start do
    content = File.read!("text/day2.txt")

    Day2.part_two(content)
  end
end

Advent.start()
