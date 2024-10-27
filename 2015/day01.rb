line = gets.chomp

p2 = nil
p1 = line.chars.each_with_index.reduce(0) do |res, (c, i)|
  res = c == '(' ? res + 1 : res - 1

  if res < 0 && p2.nil?
    p2 = i + 1
  end

  res
end
puts p1
puts p2
