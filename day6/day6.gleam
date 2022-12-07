import gleam/int
import gleam/list
import gleam/function
import gleam/erlang/file
import gleam/string
import gleam/io

pub fn main() {
  assert Ok(input) = file.read("input.txt")

  find_marker(input, 4)
  |> int.to_string
  |> string.append(to: "Part 1: ")
  |> io.println

  find_marker(input, 14)
  |> int.to_string
  |> string.append(to: "Part 2: ")
  |> io.println
}

fn find_marker(input: String, count: Int) -> Int {
  input
  |> string.to_graphemes
  |> list.window(count)
  |> list.map(function.compose(list.unique, list.length))
  |> list.take_while(fn(length) { length < count })
  |> list.length
  |> int.add(count)
}
