elves = STDIN.read.split("\n\n").map { |str| str.split("\n").map(&:to_i) }

def solve(elves, size)
  elves.map(&:sum).max(size).sum
end
puts solve(elves, 1)
puts solve(elves, 3)
