fn main() {
    let mut l: Vec<i32> = std::fs::read_to_string("input.txt")
        .expect("couldn't read file")
        .trim()
        .split("\n\n")
        .map(|x| {
            x.split("\n")
                .map(|y| y.parse::<i32>().expect("couldn't parse int"))
                .sum::<i32>()
        })
        .collect();
    // giga brain stuff from the rust discord, still no non mutating sort :(
    l.select_nth_unstable_by(2, |a, b| b.cmp(a));
    println!("Part 1: {}", &l.first().expect("no first"));
    println!("Part 2: {}", &l.iter().take(3).sum::<i32>())
}
