with open("input.txt") as f:
    l = sorted([sum(map(int, x.split())) for x in f.read().strip().split("\n\n")])
    print(f"Part 1: {l[-1]}")
    print(f"Part 2: {sum(l[-3:])}")
