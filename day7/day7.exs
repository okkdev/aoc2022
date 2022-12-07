defmodule Day7 do
  def part1(input_file) do
    input_file
    |> parse_input()
    |> Enum.reduce(0, fn {_, size}, acc -> if size <= 100_000, do: acc + size, else: acc end)
  end

  def part2(input_file) do
    fs =
      input_file
      |> parse_input()

    fs
    |> Map.values()
    |> Enum.filter(&(70_000_000 - fs["root"] + &1 >= 30_000_000))
    |> Enum.min()
  end

  defp parse_input(input) do
    input
    |> File.read!()
    |> String.split("$ cd ", trim: true)
    |> Enum.map(fn el ->
      el
      |> String.split("\n", trim: true)
      |> Enum.reject(&String.contains?(&1, ["dir", "$ ls"]))
      |> then(fn [cd | files] ->
        [
          cd
          | Enum.map(files, &(&1 |> String.split(" ") |> hd() |> String.to_integer()))
        ]
      end)
    end)
    |> Enum.reduce({["root"], %{}}, fn [cd | files], {dir, tree} ->
      size = files |> List.wrap() |> Enum.sum()

      case cd do
        "/" ->
          {["root"], Map.merge(tree, %{"root" => size})}

        ".." ->
          {Enum.drop(dir, 1), tree}

        d ->
          {[d | dir],
           tree
           |> Map.merge(%{
             Enum.join([d | dir]) => size
           })
           |> update_rec(dir, size)}
      end
    end)
    |> elem(1)
  end

  defp update_rec(tree, [], _), do: tree

  defp update_rec(tree, [_] = dir, size),
    do: Map.update!(tree, Enum.join(dir), &(&1 + size))

  defp update_rec(tree, [_ | tail] = dir, size) do
    tree = Map.update!(tree, Enum.join(dir), &(&1 + size))
    update_rec(tree, tail, size)
  end
end

Day7.part1("input.txt")
|> IO.inspect(label: "Part 1")

Day7.part2("input.txt")
|> IO.inspect(label: "Part 2")
