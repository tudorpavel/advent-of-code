lines = STDIN.read.split("\n")
grid = lines.map { |line| line.chars }

antennas = {}

0.upto(grid.size - 1).each do |i|
  0.upto(grid.first.size - 1).each do |j|
    (antennas[grid[i][j]] ||= []) << [i, j] if grid[i][j] != '.'
  end
end

# Part 1
unique_locations = Set.new
antennas.each do |k, points|
  points.combination(2).each do |((ai, aj), (bi, bj))|
    antinodes = [
      [(ai - bi) + ai, (aj - bj) + aj],
      [(bi - ai) + bi, (bj - aj) + bj]
    ].filter { |(i, j)| i >= 0 && j >= 0 && i <= (grid.size - 1) && j <= (grid.first.size - 1) }

    antinodes.each { |a| unique_locations.add(a) }
  end
end
puts unique_locations.size

# Part 2
antinodes = Set.new
antennas.each do |k, points|
  points.combination(2).each do |((ai, aj), (bi, bj))|
    n = 0
    while
      i = n * (ai - bi) + ai
      j = n * (aj - bj) + aj
      break if i < 0 || j < 0 || i > (grid.size - 1) || j > (grid.first.size - 1)
      antinodes.add([i, j])
      n += 1
    end
    n = 0
    while
      i = n * (bi - ai) + bi
      j = n * (bj - aj) + bj
      break if i < 0 || j < 0 || i > (grid.size - 1) || j > (grid.first.size - 1)
      antinodes.add([i, j])
      n += 1
    end
  end
end
puts antinodes.size
