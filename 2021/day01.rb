measurements = STDIN.read.split("\n").map(&:to_i)

def solve(measurements, size)
  measurements.each_cons(size).map(&:sum).each_cons(2).count { |a, b| a < b }
end
puts solve(measurements, 1)
puts solve(measurements, 3)
