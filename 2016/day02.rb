lines = STDIN.read.split("\n")

DIFFS = {
  'U' => [-1, 0],
  'R' => [0, 1],
  'D' => [1, 0],
  'L' => [0, -1]
}
KEYPAD1 = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]
pos = [1, 1]
puts (
  lines.map do |line|
    line.chars.each do |instr|
      new_pos = pos.zip(DIFFS[instr]).map(&:sum)
      next unless [0, 1, 2].include?(new_pos.first)
      next unless [0, 1, 2].include?(new_pos.last)
      pos = new_pos
    end
    KEYPAD1[pos.first][pos.last]
  end.join
)

KEYPAD2 = [
  '..1..',
  '.234.',
  '56789',
  '.ABC.',
  '..D..'
]
pos = [2, 0]
puts (
  lines.map do |line|
    line.chars.each do |instr|
      new_pos = pos.zip(DIFFS[instr]).map(&:sum)
      next if new_pos.first < 0 || new_pos.first >= KEYPAD2.size
      next if new_pos.last < 0 || new_pos.last >= KEYPAD2.size
      next if KEYPAD2[new_pos.first][new_pos.last] == '.'
      pos = new_pos
    end
    KEYPAD2[pos.first][pos.last]
  end.join
)
