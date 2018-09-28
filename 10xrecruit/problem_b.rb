def solve
  _, _ = gets.split(/\s+/).map(&:to_i)
  row_sums = gets.split(/\s+/).map(&:to_i)
  col_sums = gets.split(/\s+/).map(&:to_i).sort

  row_sums.each do |sum|
    sum.times do |i|
      v = (col_sums[-(i+1)] -= 1)
      return false if v < 0
    end
    col_sums.sort!
  end
  return col_sums.all?(&:zero?)
end

puts(solve ? "Yes" : "No")
