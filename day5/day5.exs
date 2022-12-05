[raw_stacks, raw_instructions] =
  File.read!("input.txt")
  |> String.split("\n\n")

stacks =
  raw_stacks
  |> String.replace(["[", "]"], " ")
  |> String.split("\n")
  |> Enum.drop(-1)
  |> Enum.map(&String.graphemes/1)
  |> Enum.zip()
  |> Enum.map(&Tuple.to_list/1)
  |> Enum.filter(fn stack -> not Enum.all?(stack, &(&1 == " ")) end)
  |> Enum.map(fn stack -> Enum.filter(stack, &(&1 != " ")) end)
  |> Enum.with_index(&{&2 + 1, &1})
  |> Map.new()

instructions =
  raw_instructions
  |> String.split("\n")
  |> Enum.map(fn instructions ->
    [_, amount, from, to] = Regex.run(~r/move (\d+) from (\d) to (\d)/, instructions)
    amount = String.to_integer(amount)
    from = String.to_integer(from)
    to = String.to_integer(to)
    {amount, from, to}
  end)

instructions
|> Enum.reduce(stacks, fn {amount, from, to}, stacks ->
  stacks
  |> Map.update!(from, &Enum.drop(&1, amount))
  |> Map.update!(to, &((stacks[from] |> Enum.take(amount) |> Enum.reverse()) ++ &1))
end)
|> Enum.reduce("", fn {_, xs}, acc -> acc <> hd(xs) end)
|> IO.inspect(label: "Part 1")

instructions
|> Enum.reduce(stacks, fn {amount, from, to}, stacks ->
  stacks
  |> Map.update!(from, &Enum.drop(&1, amount))
  |> Map.update!(to, &((stacks[from] |> Enum.take(amount)) ++ &1))
end)
|> Enum.reduce("", fn {_, xs}, acc -> acc <> hd(xs) end)
|> IO.inspect(label: "Part 2")
