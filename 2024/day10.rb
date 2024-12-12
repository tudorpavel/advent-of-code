map = STDIN.read.split("\n").map { |line| line.chars.map(&:to_i) }

DELTAS = [
  [-1, 0],
  [1, 0],
  [0, -1],
  [0, 1]
]

def bfs_score(map, start_i, start_j)
  queue = [[start_i, start_j, 0]]
  peaks = Set.new
  p2_score = 0
  while !queue.empty?
    i, j, height = queue.shift
    DELTAS.each do |di, dj|
      ni, nj = i + di, j + dj
      next if ni < 0 || ni >= map.size || nj < 0 || nj >= map.first.size

      neighbor = map[ni][nj]
      next unless height + 1 == neighbor

      if neighbor == 9
        peaks << [ni, nj]
        p2_score += 1
      else
        queue << [ni, nj, neighbor]
      end
    end
  end
  [peaks.size, p2_score]
end

trail_heads = []
0.upto(map.size - 1).each do |i|
  0.upto(map.first.size - 1).each do |j|
    trail_heads << [i, j] if map[i][j] == 0
  end
end

puts trail_heads.map { |(i, j)| bfs_score(map, i, j) }.reduce { |(p1, p2), (s1, s2)| [p1 + s1, p2 + s2] }
