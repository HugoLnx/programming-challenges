NEG_INF = -1000*205
while (headers = gets) && headers.strip != '0 0'
  n,k = headers.split(/\s+/).map(&:to_i)

  rooms = n.times.flat_map do |i|
    left, right = gets.split(/\s+/).map(&:to_i)
    i.even? ? [left, right] : [right, left]
  end

  memo = {}

  define_method :solve do |ri, k|
    solve_id = ri*201 + k
    return memo[solve_id] if memo[solve_id]
    return NEG_INF if k < 0
    if ri >= n*2
      return k == 0 ? 0 : NEG_INF
    end

    sol1 = safe_sum(solve(ri+1, k), rooms[ri]) # let current room opened
    sol2 = solve(ri+3, k-1) + safe_sum(rooms[ri+1], rooms[ri+2]) # close current one and left next two opened
    sol3 = if ri.odd? && ri+1 < n*2
      solve(ri+4, k-2) + safe_sum(rooms[ri+2], rooms[ri+3]) # close current one and the next, but let the two after free
    else
      NEG_INF
    end
    return memo[solve_id] = sol1 if max3?(sol1, sol2, sol3)
    return memo[solve_id] = sol2 if max3?(sol2, sol1, sol3)
    return memo[solve_id] = sol3 if max3?(sol3, sol2, sol1)
    return memo[solve_id] = NEG_INF
    #possible_solutions.map do |c|
    #  val = eval(c)
    #  if val == 18
    #    puts "#{ri}, #{k}"
    #    puts c
    #  end
    #  val
    #end.compact.max
  end

  def max3?(v1,v2,v3)
    v1 >= v2 && v1 >= v3
  end

  def safe_sum(v1, v2)
    (v1 || 0) + (v2 || 0)
  end

  puts solve(0, k)
end
