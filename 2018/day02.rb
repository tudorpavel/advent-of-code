ids = STDIN.read.split("\n")

def count_for(ids, size)
  ids.count { |id| id.chars.tally.values.include?(size) }
end

puts count_for(ids, 2) * count_for(ids, 3)

def part2(ids)
  ids.combination(2).each do |(a, b)|
    pairs = a.chars.zip(b.chars)
    same = pairs.filter { |(x, y)| x == y }
    return same.map(&:first).join if same.size == pairs.size - 1
  end
end
puts part2(ids)
