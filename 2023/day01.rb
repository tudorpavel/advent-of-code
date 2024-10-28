lines = STDIN.read.split("\n")

puts (
  lines.map do |l|
    digits = l.scan(/\d/).flatten
    (digits.first + digits.last).to_i
  end.sum
)
DIGIT_MAP = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9'
}
puts (
  lines.map do |l|
    digits = l.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
    [digits.first, digits.last].map { |d| DIGIT_MAP[d] || d }.join.to_i
  end.sum
)
