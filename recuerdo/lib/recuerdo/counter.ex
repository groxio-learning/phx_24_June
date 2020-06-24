defmodule Recuerdo.Counter do
  
  def new, do: 0

  def increment(count) do
    count + 1
  end

  def decrement(count) do
    count - 1
  end
end
