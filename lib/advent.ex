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
    content = File.read!("text/day3.txt")

    Day3.part_one(content)
  end
end

Advent.start()
