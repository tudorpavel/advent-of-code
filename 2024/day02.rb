lines = STDIN.read.split("\n")

def safe?(levels)
  return false if levels.each_cons(2).any? { |a, b| a == b || (a - b).abs > 3 }
  levels == levels.sort || levels.reverse == levels.sort
end

def safe_with_dampner?(levels)
  return true if safe?(levels)
  0.upto(levels.size - 1).any? do |i|
    safe?(levels[0, i] + levels[i+1..])
  end
end

reports = lines.map { |line| line.split.map(&:to_i) }
puts reports.count { |r| safe?(r) }
puts reports.count { |r| safe_with_dampner?(r) }
