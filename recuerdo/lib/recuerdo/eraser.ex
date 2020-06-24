defmodule Recuerdo.Eraser do
  defstruct [:text, :plan]
  
  @dont_replace ["\n", ",", ".", ";", " "]
  
  def new(text, steps) do
    size = String.length(text)
    
    plan = 
      (1..size)
      |> Enum.shuffle
      |> Enum.chunk_every(step_size(size, steps))
      
    %__MODULE__{text: text, plan: plan}
  end
  
  defp step_size(size, steps) do
    size 
    |> Kernel./(steps)
    |> ceil
  end
  
  def erase(%{text: text, plan: [step|steps]}=eraser) do
    erased = 
      text
      |> String.graphemes
      |> Enum.with_index(1)
      |> Enum.map(fn {char, index} -> maybe_replace(char, (index in step)) end)
      |> Enum.join
    
    %{eraser| plan: steps, text: erased}
  end
  
  defp maybe_replace(char, _) when char in @dont_replace, do: char
  defp maybe_replace(_char, true), do: "_"
  defp maybe_replace(char, _false), do: char
end