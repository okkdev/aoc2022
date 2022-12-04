app "Day 1"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports [pf.Stdout, pf.Path, pf.File, pf.Task]
    provides [main] to pf

main =
    task =
        input <- "input.txt" |> Path.fromStr |> File.readUtf8 |> Task.await
        calories =
            input
            |> Str.split "\n\n"
            |> List.map
                \elf ->
                    Str.split elf "\n"
                    |> List.walk
                        0
                        \acc, inv ->
                            acc + (Str.toNat inv |> Result.withDefault 0)

        p1 =
            calories
            |> List.max
            |> Result.withDefault 0
            |> Num.toStr

        p2 =
            calories
            |> List.sortDesc
            |> List.takeFirst 3
            |> List.sum
            |> Num.toStr

        Stdout.line "Part 1: \(p1)\nPart 2: \(p2)"

    Task.onFail task \_ -> crash "oopsie"
