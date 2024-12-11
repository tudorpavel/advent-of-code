nums = STDIN.read.chomp.chars.map(&:to_i)

nums << 0 if nums.size.odd?

# Part 1
tuples = nums.each_slice(2).map.with_index { |(file_size, empty_size), id| [file_size, empty_size, id] }
left = 0
right = tuples.size - 1
current_idx = 0
p1_checksum = 0
while left <= right
  if tuples[left][0] > 0
    p1_checksum += current_idx.upto(current_idx + tuples[left][0] - 1).map { |i| i * tuples[left][2] }.sum
    current_idx += tuples[left][0]
    tuples[left][0] = 0
  end
  if tuples[left][1] > 0
    min = [tuples[left][1], tuples[right][0]].min
    p1_checksum += current_idx.upto(current_idx + min - 1).map { |i| i * tuples[right][2] }.sum
    current_idx += min
    tuples[left][1] -= min
    tuples[right][0] -= min
  end
  if tuples[left][1] == 0
    left += 1
  end
  if tuples[right][0] == 0
    right -= 1
  end
end
puts p1_checksum

# Part 2
FILE = 'file'.freeze
EMPTY = 'empty'.freeze
Block = Struct.new(:type, :id, :size, :prev, :next) do
  def prepend(block)
    self.prev.next = block if self.prev
    block.prev = self.prev
    block.next = self
    self.prev = block
  end

  def append(block)
    self.next.prev = block if self.next
    block.prev = self
    block.next = self.next
    self.next = block
  end
end

file_blocks = []
empty_blocks = []
first = Block.new(EMPTY, -1, 0, nil, nil)
current = first
nums.each_slice(2).each_with_index do |(file_size, empty_size), id|
  f = Block.new(FILE, id, file_size, nil, nil)
  e = Block.new(EMPTY, id, empty_size, nil, nil)
  current.append(f)
  f.append(e)
  file_blocks << f
  empty_blocks << e
  current = e
end
first = first.next
first.prev = nil

file_blocks.reverse.each do |file|
  empty_blocks.each do |empty|
    break if empty.id >= file.id

    if empty.size >= file.size
      block = Block.new(FILE, file.id, file.size, nil, nil)
      file.type = EMPTY
      empty.prepend(block)
      empty.size -= block.size
      break
    end
  end
end

current = first
current_idx = 0
p2_checksum = 0
while !current.nil?
  if current.type == FILE
    p2_checksum += current_idx.upto(current_idx + current.size - 1).map { |i| i * current.id }.sum
  end
  current_idx += current.size
  current = current.next
end
puts p2_checksum
