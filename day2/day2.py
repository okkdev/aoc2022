p1 = {
    "A": {
        "X": 4,
        "Y": 8,
        "Z": 3,
    },
    "B": {
        "X": 1,
        "Y": 5,
        "Z": 9,
    },
    "C": {
        "X": 7,
        "Y": 2,
        "Z": 6,
    },
}
p2 = {
    "A": {
        "X": 3,
        "Y": 4,
        "Z": 8,
    },
    "B": {
        "X": 1,
        "Y": 5,
        "Z": 9,
    },
    "C": {
        "X": 2,
        "Y": 6,
        "Z": 7,
    },
}

with open("input.txt") as f:
    xs = f.read().strip().split("\n")
    print(f"Part 1: {sum([p1[l[0]][l[-1]] for l in xs])}")
    print(f"Part 2: {sum([p2[l[0]][l[-1]] for l in xs])}")
