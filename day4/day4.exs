File.read!("input.txt")
|> String.split("\n")
|> Enum.map(fn line ->
  [l, r] = String.split(line, ",")
  [l1, l2] = String.split(l, "-") |> Enum.map(&String.to_integer/1)
  [r1, r2] = String.split(r, "-") |> Enum.map(&String.to_integer/1)

  {MapSet.new(l1..l2), MapSet.new(r1..r2)}
end)
|> tap(
  &(Enum.reduce(&1, 0, fn {l, r}, acc ->
      if MapSet.subset?(l, r) or
           MapSet.subset?(r, l) do
        acc + 1
      else
        acc
      end
    end)
    |> IO.inspect(label: "Part 1"))
)
|> tap(
  &(Enum.reduce(&1, 0, fn {l, r}, acc ->
      if MapSet.disjoint?(l, r) do
        acc
      else
        acc + 1
      end
    end)
    |> IO.inspect(label: "Part 2"))
)
