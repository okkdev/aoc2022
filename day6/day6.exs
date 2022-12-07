"input.txt"
|> File.read!()
|> String.graphemes()
|> Enum.with_index()
|> tap(
  &(Enum.reduce(&1, {0, []}, fn {value, index}, {score, acc} ->
      cond do
        Enum.uniq(acc) == acc and length(acc) == 4 -> {score, acc}
        true -> {index + 1, Enum.take([value | acc], 4)}
      end
    end)
    |> IO.inspect(label: "Part 1"))
)
|> tap(
  &(Enum.reduce(&1, {0, []}, fn {value, index}, {score, acc} ->
      cond do
        Enum.uniq(acc) == acc and length(acc) == 14 -> {score, acc}
        true -> {index + 1, Enum.take([value | acc], 14)}
      end
    end)
    |> IO.inspect(label: "Part 2"))
)
