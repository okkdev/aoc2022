fn main() {
    let input = std::fs::read_to_string("input.txt").expect("couldn't read file");

    let p1: i32 = input.lines().fold(
        0,
        |acc, line| match line.chars().collect::<Vec<char>>()[..] {
            [a, _, b] => {
                let y = a as i32 - 'A' as i32;
                let x = b as i32 - 'X' as i32;
                acc + (x + 1 + (x - y + 4) % 3 * 3)
            }
            _ => panic!("couldn't parse line"),
        },
    );

    let p2: i32 = input.lines().fold(
        0,
        |acc, line| match line.chars().collect::<Vec<char>>()[..] {
            [a, _, b] => {
                let y = a as i32 - 'A' as i32;
                let x = b as i32 - 'X' as i32;
                acc + (x * 3 + (x + y + 2) % 3 + 1)
            }
            _ => panic!("couldn't parse line"),
        },
    );

    println!("Part 1: {}", &p1);
    println!("Part 2: {}", &p2)
}
