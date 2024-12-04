input = STDIN.read
mat = input.split("\n").map(&:chars)

# Part 1
def count_for(input)
  (input + "\n" + input.reverse).scan('XMAS').size
end

def make_input_diag(mat)
  input_diag = []
  0.upto(mat.first.size - 4) do |col|
    i = 0
    j = col
    while i < mat.size && j < mat.first.size
      input_diag << mat[i][j]
      i += 1
      j += 1
    end
    input_diag << '|'
  end
  1.upto(mat.size - 4) do |row|
    i = row
    j = 0
    while i < mat.size && j < mat.first.size
      input_diag << mat[i][j]
      i += 1
      j += 1
    end
    input_diag << '|'
  end
  input_diag.join
end

input_transposed = mat.transpose.map(&:join).join("\n")

horiz_count = count_for(input)
vert_count = count_for(input_transposed)
diag_count = count_for(make_input_diag(mat)) + count_for(make_input_diag(mat.reverse))

puts horiz_count + vert_count + diag_count

# Part 2
count = 0
1.upto(mat.size - 2).each do |i|
  1.upto(mat.first.size - 2).each do |j|
    next unless mat[i][j] == 'A'

    primary = %w[MS SM].include?([mat[i-1][j-1], mat[i+1][j+1]].join)
    secondary = %w[MS SM].include?([mat[i+1][j-1], mat[i-1][j+1]].join)
    count += 1 if primary && secondary
  end
end
puts count
