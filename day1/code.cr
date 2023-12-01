data = File.read("./input.txt")

lines = data.split("\n")
lines.delete_at(lines.size - 1)

# Part 1
solution = lines.map { |line|
  digits = line.chars.map { |char|
    if char.number?
      char.to_i
    end
  }.reject! { |v| v == nil }

  f = digits.first || 0
  l = digits.last || 0

  f*10 + l
}.reduce { |acc, i| acc + i }

puts "Part 1"
puts solution
puts

# Part 2
num_map = {
  "1"     => 1,
  "2"     => 2,
  "3"     => 3,
  "4"     => 4,
  "5"     => 5,
  "6"     => 6,
  "7"     => 7,
  "8"     => 8,
  "9"     => 9,
  "0"     => 0,
  "one"   => 1,
  "two"   => 2,
  "three" => 3,
  "four"  => 4,
  "five"  => 5,
  "six"   => 6,
  "seven" => 7,
  "eight" => 8,
  "nine"  => 9,
}

search_regex = Regex.new(num_map.keys.join("|"))

solution = lines.map { |line|
  fm = line.partition(search_regex)[1]
  lm = line.rpartition(search_regex)[1]

  fn = num_map[fm] || 0
  ln = num_map[lm] || 0

  fn*10 + ln
}

puts "Part 2"
puts solution.reduce { |acc, i| acc + i }
