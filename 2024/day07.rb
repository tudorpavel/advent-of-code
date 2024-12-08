lines = STDIN.read.split("\n")

ADD = '+'
MUL = '*'
CON = '||'
P1_OPTS = [ADD, MUL]
P2_OPTS = [ADD, MUL, CON]

def total_calibration(equations, possible_operators)
  result = 0
  equations.each do |(test_value, operands)|
    choices = possible_operators.repeated_permutation(operands.size - 1)
    choices.each do |operators|
      res = operators.zip(operands[1..]).reduce(operands.first) do |acc, (opt, opd)|
        case opt
        when ADD
          acc += opd
        when MUL
          acc *= opd
        else
          acc = (acc.to_s + opd.to_s).to_i
        end
      end

      if res == test_value
        result += res
        break
      end
    end
  end
  result
end

equations = lines.map do |line|
  l, r = line.split(':')
  [l.to_i, r.split.map(&:to_i)]
end

puts total_calibration(equations, P1_OPTS)
puts total_calibration(equations, P2_OPTS)
