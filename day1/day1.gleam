import gleam/int
import gleam/list
import gleam/function
import gleam/erlang/file
import gleam/string
import gleam/io

pub fn main() {
  assert Ok(input) = file.read("input.txt")

  input
  |> string.split(on: "\n\n")
  |> list.map(fn(inventory) {
    inventory
    |> string.split(on: "\n")
    |> list.filter_map(int.parse)
    |> int.sum
  })
  |> function.tap(fn(calories) {
    calories
    |> list.fold(0, int.max)
    |> int.to_string
    |> string.append(to: "Part 1: ")
    |> io.println
  })
  |> function.tap(fn(calories) {
    calories
    |> list.sort(int.compare)
    |> list.reverse
    |> list.take(3)
    |> int.sum
    |> int.to_string
    |> string.append(to: "Part 2: ")
    |> io.println
  })
}
