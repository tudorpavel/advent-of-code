lines = STDIN.read.split("\n")

presents = lines.map { |line| line.split('x').map(&:to_i) }

puts (
  presents.map do |present|
    areas = present.combination(2).map { |(a, b)| a * b }
    areas.map { |a| a * 2 }.sum + areas.min
  end.sum
)
puts (
  presents.map do |present|
    (present.min(2).sum * 2) + present.reduce(&:*)
  end.sum
)
