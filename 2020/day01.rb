entries = STDIN.read.split("\n").map(&:to_i)

def solve(entries, size)
  entries.combination(size).each { |tuple| return tuple.reduce(&:*) if tuple.sum == 2020 }
end
puts solve(entries, 2)
puts solve(entries, 3)
