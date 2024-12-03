def multiply(instr)
  a, b = instr.scan(/\d+/).map(&:to_i)
  a * b
end

program_memory = STDIN.read

# Part 1
instructions = program_memory.scan(/mul\(\d+,\d+\)/)
puts instructions.map { |instr| multiply(instr) }.sum

# Part 2
instructions = program_memory.scan(/mul\(\d+,\d+\)|don't\(\)|do\(\)/)
enabled = true
puts (
  instructions.reduce(0) do |sum, instr|
    case instr
    when "don't()"
      enabled = false
    when 'do()'
      enabled = true
    else
      sum += multiply(instr) if enabled
    end

    sum
  end
)
