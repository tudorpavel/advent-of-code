line = gets.chomp
digits = line.chars.map(&:to_i)

p1 = 0
p2 = 0
digits.each_with_index do |digit, i|
  next_p1 = (i + 1) % digits.size
  next_p2 = (i + (digits.size / 2)) % digits.size
  p1 += digit if digit == digits[next_p1]
  p2 += digit if digit == digits[next_p2]
end
puts p1
puts p2
