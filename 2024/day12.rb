garden = STDIN.read.split("\n").map(&:chars)

# padding outer edge
garden.unshift(['.'] * garden.first.size)
garden.push(['.'] * garden.first.size)
garden.map! { |row| row.unshift('.'); row.push('.') }

# will store integer unique region IDs
visited = garden.map do |row|
  row.map { |c| c == '.' ? -1 : 0 }
end

DELTAS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
regions = Hash.new { |hash, key| hash[key] = { area: 0, perimeter: 0, side_count: 0 } }
region_id = 0

# Part 1 and assigning unique Region IDs
1.upto(garden.size - 2) do |outer_i|
  1.upto(garden.first.size - 2) do |outer_j|
    next if visited[outer_i][outer_j] != 0

    q = [[outer_i, outer_j]]
    id = region_id += 1
    until q.empty?
      i, j = q.pop
      next if visited[i][j] != 0

      visited[i][j] = id
      regions[id][:area] += 1
      DELTAS.each do |(di, dj)|
        if garden[i][j] == garden[i + di][j + dj]
          q.push([i + di, j + dj])
        else
          regions[id][:perimeter] += 1
        end
      end
    end
  end
end

# Part 2
def count_horizontal_edges(regions, visited)
  0.upto(visited.size - 2) do |i|
    row1 = visited[i]
    row2 = visited[i + 1]
    [[row1, row2], [row2, row1]].each do |(row_l, row_r)|
      # find sides from row_l perspective at the edge with row_r
      # row_l = 'RRRRIICCCF'
      # row_r = 'VVRRRCCFFF'
      # chunks => [['RV', 'RV'], ['RR'], ['RR'], ['IR', 'IC'], ['CC'], ['CF', 'CF'], ['FF']]
      # reject => [['RV', 'RV'], ['IR', 'IC'], ['CF', 'CF']]
      # where chunk ['RV', 'RV'] is a southern side of region 'R' with length 2
      row_l
        .zip(row_r)
        .chunk_while { |(la, ra), (lb, rb)| la == lb && la != ra && lb != rb }
        .reject { |chunk| chunk.size == 1 && chunk.first[0] == chunk.first[1] }
        .each { |chunk| regions[chunk.first[0]][:side_count] += 1 }
    end
  end
end
count_horizontal_edges(regions, visited)
count_horizontal_edges(regions, visited.transpose)

puts regions.values.sum { |r| r[:area] * r[:perimeter] }
puts regions.values.sum { |r| r[:area] * r[:side_count] }
