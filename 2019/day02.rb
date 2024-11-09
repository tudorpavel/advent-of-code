ints = STDIN.read.split(',').map(&:to_i)

class Intcode
  def initialize(mem, noun, verb)
    @mem = mem
    @noun = noun
    @verb = verb
  end

  def run
    @mem[1] = @noun
    @mem[2] = @verb
    pos = 0

    loop do
      case @mem[pos]
      when 1
        pos = add(pos)
      when 2
        pos = mul(pos)
      when 99
        break
      else
        raise "Unexpected instr: #{@mem[pos]}"
      end
    end

    @mem[0]
  end

  private

  def add(pos)
    @mem[@mem[pos + 3]] = @mem[@mem[pos + 1]] + @mem[@mem[pos + 2]]
    pos + 4
  end

  def mul(pos)
    @mem[@mem[pos + 3]] = @mem[@mem[pos + 1]] * @mem[@mem[pos + 2]]
    pos + 4
  end
end

puts Intcode.new(ints.dup, 12, 2).run

0.upto(99) do |noun|
  0.upto(99) do |verb|
    if Intcode.new(ints.dup, noun, verb).run == 19690720
      puts (100 * noun) + verb
      break
    end
  end
end
