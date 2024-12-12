stones = STDIN.read.split.map(&:to_i)

def stone_count(stone, iterations, memo)
  return 1 if iterations.zero?
  return memo[[stone, iterations]] unless memo[[stone, iterations]].nil?

  result = (
    case
    when stone == 0
      stone_count(1, iterations - 1, memo)
    when stone.to_s.size.even?
      stone.to_s.chars.each_slice(stone.to_s.size / 2).map(&:join).map(&:to_i).map do |num|
        stone_count(num, iterations - 1, memo)
      end.sum
    else
      stone_count(stone * 2024, iterations - 1, memo)
    end
  )
  memo[[stone, iterations]] = result
  result
end

memo = {}
puts stones.map { |stone| stone_count(stone, 25, memo) }.sum
puts stones.map { |stone| stone_count(stone, 75, memo) }.sum
