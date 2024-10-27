line = gets.chomp

DIR_CHANGE = {
  [0, -1] => { 'L' => [-1, 0], 'R' => [1, 0] },
  [1, 0] => { 'L' => [0, -1], 'R' => [0, 1] },
  [0, 1] => { 'L' => [1, 0], 'R' => [-1, 0] },
  [-1, 0] => { 'L' => [0, 1], 'R' => [0, -1] },
}

pos = [0, 0]
dir = [0, -1]
visited = Set.new([pos.to_s])
p2 = nil
line.split(', ').each do |s|
  dir = DIR_CHANGE[dir][s[0]]
  step_count = s[1..].to_i
  step_count.times do
    pos[0] += dir[0]
    pos[1] += dir[1]
    p2 = pos.map(&:abs).sum if visited.include?(pos.to_s) && p2.nil?
    visited.add(pos.to_s)
  end
end

puts pos.map(&:abs).sum
puts p2
