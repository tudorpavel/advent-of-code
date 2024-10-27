nums = STDIN.read.split("\n").map(&:to_i)
puts nums.sum

def part2(nums)
  seen = Set.new
  sum = 0
  loop do
    nums.each do |num|
      return sum if seen.include?(sum)
      seen.add(sum)
      sum += num
    end
  end
end

puts part2(nums)
