lines = STDIN.read.split("\n")
grid = lines.map { |line| line.chars }

NORTH = [-1, 0]
EAST =  [0, 1]
SOUTH = [1, 0]
WEST =  [0, -1]
NEXT_DIR = {
  NORTH => EAST,
  EAST => SOUTH,
  SOUTH => WEST,
  WEST => NORTH
}
GOBACK_DIR = {
  NORTH => SOUTH,
  EAST => WEST,
  SOUTH => NORTH,
  WEST => EAST
}

# Find start position
si = 0
sj = 0
0.upto(grid.size - 1).each do |i|
  0.upto(grid.first.size - 1).each do |j|
    si, sj = i, j if grid[i][j] == '^'
  end
end

# Part 1
i = si
j = sj
dir = NORTH
visited = Set.new([[i, j]])

loop do
  i, j = [i, j].zip(dir).map(&:sum)
  break if i < 0 || j < 0 || i >= grid.size || j >= grid.first.size

  if grid[i][j] == '#'
    i, j = [i, j].zip(GOBACK_DIR[dir]).map(&:sum)
    dir = NEXT_DIR[dir]
  else
    visited.add([i, j])
  end
end

puts visited.size

# Part 2
def stuck_in_loop?(grid, obj_i, obj_j, start_i, start_j)
  i = start_i
  j = start_j
  dir = NORTH
  grid[obj_i][obj_j] = '#'
  result = false
  vis = Set.new([[[i, j], dir]])

  loop do
    i, j = [i, j].zip(dir).map(&:sum)
    break if i < 0 || j < 0 || i >= grid.size || j >= grid.first.size

    if grid[i][j] == '#'
      i, j = [i, j].zip(GOBACK_DIR[dir]).map(&:sum)
      dir = NEXT_DIR[dir]
    elsif vis.include?([[i, j], dir])
      result = true
      break
    else
      vis.add([[i, j], dir])
    end
  end

  grid[obj_i][obj_j] = '.'
  result
end

visited.delete([si, sj]) # remove start point from candidates
puts visited.count { |oi, oj| stuck_in_loop?(grid, oi, oj, si, sj) }
