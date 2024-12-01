lines = STDIN.read.split("\n")

list1 = []
list2 = []
lines.each do |line|
  a, b = line.split.map(&:to_i)
  list1 << a
  list2 << b
end

puts list1.sort.zip(list2.sort).map { |(a, b)| (a - b).abs }.sum

freq = list2.tally
puts list1.map { |a| a * freq.fetch(a, 0) }.sum
