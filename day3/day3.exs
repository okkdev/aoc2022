values =
  (Enum.zip(?a..?z, 1..26) ++ Enum.zip(?A..?Z, 27..52))
  |> Enum.into(%{})

File.read!("input.txt")
|> String.split("\n")
|> tap(fn elves ->
  Enum.reduce(elves, 0, fn bag, acc ->
    String.graphemes(bag)
    |> then(&Enum.split(&1, div(length(&1), 2)))
    |> then(fn {pocket1, pocket2} -> pocket1 -- pocket1 -- pocket2 end)
    |> hd()
    |> :binary.decode_unsigned()
    |> then(&(acc + values[&1]))
  end)
  |> IO.inspect(label: "Part 1")
end)
|> tap(fn elves ->
  elves
  |> Enum.chunk_every(3)
  |> Enum.reduce(0, fn bags, acc ->
    bags
    |> Enum.map(&String.graphemes/1)
    |> then(fn [bag1, bag2, bag3] -> Enum.filter(bag1, &(&1 in bag2 and &1 in bag3)) end)
    |> hd()
    |> :binary.decode_unsigned()
    |> then(&(acc + values[&1]))
  end)
  |> IO.inspect(label: "Part 2")
end)
