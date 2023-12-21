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
    content = File.read!("text/day1.txt")

    Day1.run(content)
  end
end

Advent.start()
