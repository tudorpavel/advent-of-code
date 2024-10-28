module_masses = STDIN.read.split("\n").map(&:to_i)

puts module_masses.map { |mass| (mass / 3) - 2 }.sum
puts (
  module_masses.map do |mass|
    fuel = 0
    while mass > 0
      mass = (mass / 3) - 2
      fuel += mass < 0 ? 0 : mass
    end
    fuel
  end.sum
)
