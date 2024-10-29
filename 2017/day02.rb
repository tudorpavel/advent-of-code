rows = STDIN.read.split("\n").map { |line| line.split.map(&:to_i) }

puts rows.map { |r| r.max - r.min }.sum
puts rows.map { |r| r.sort.reverse.combination(2).find { |(a, b)| a % b == 0 }.reduce(&:/) }.sum
