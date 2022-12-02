values = %{"A" => 0, "B" => 1, "C" => 2, "X" => 1, "Y" => 2, "Z" => 3}

File.read!("input.txt")
|> String.split("\n")
|> tap(
  &(Enum.reduce(
      &1,
      0,
      fn <<a::binary-size(1), " ", b::binary>> = ab, acc ->
        acc + values[b] +
          cond do
            ab == "A Y" -> 6
            ab == "B Z" -> 6
            ab == "C X" -> 6
            values[a] + 1 == values[b] -> 3
            true -> 0
          end
      end
    )
    |> IO.inspect(label: "Part 1"))
)
|> tap(
  &(Enum.reduce(
      &1,
      0,
      fn <<a::binary-size(1), " ", b::binary>>, acc ->
        acc +
          case b do
            "X" -> Integer.mod(values[a] - 1, 3) + 1
            "Y" -> values[a] + 1 + 3
            "Z" -> Integer.mod(values[a] + 1, 3) + 1 + 6
          end
      end
    )
    |> IO.inspect(label: "Part 2"))
)
