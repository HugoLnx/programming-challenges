n, k = gets.split(/\s+/).map(&:to_i)
ps = []
ref = gets.strip.chars.to_a.map{|c| c == '0'}
ps.push(
  feats: {up: k.times.map(&:itself), down: []},
  sim: 0,
)
for _ in 2..n
  feats_raw = gets.strip.chars.to_a
  feats = {up: [], down: []}
  sim = 0
  for i in 0...feats_raw.size
    v = feats_raw[i] == '1'
    if v == ref[i]
      sim += 1 
      feats[:down] << i
    else
      feats[:up] << i
    end
  end
  ps.push(
    feats: feats,
    sim: sim
  )
end

BITS = 20.times.reduce({}) do |h, i|
  h[i] = (1 << i)
  h
end

ps.sort_by!{|p| p[:sim]}

combs_memo = {}
define_method :combs do |player_id, type, arr, n, i=0|
  call_id = n*21*21*3+i*21*3+player_id*3+type
  return combs_memo[call_id] if combs_memo[call_id]
  return combs_memo[call_id] = [] if i >= arr.size || n == 0
  combs_memo[call_id] = if n == 1
    all = []
    for m in i...arr.size
      all << BITS[arr[m]]
    end
    all
  else
    combs(player_id, type, arr, n-1, i+1).map{|c| c | BITS[arr[i]]} + combs(player_id, type, arr, n, i+1)
  end
end

define_method :up_combs do |i, up_amount|
  return [0] if up_amount == 0
  up = ps[i][:feats][:up]
  combs(i, 0, up, up_amount)
end

define_method :down_combs do |i, down_amount|
  return [0] if down_amount == 0
  down = ps[i][:feats][:down]
  combs(i, 1, down, down_amount)
end

#memo_up = {}
#define_method :up_combs do |i, up_amount|
#  call_id = i*22+up_amount
#  return memo_up[call_id] if memo_up[call_id]
#  return memo_up[call_id] = [0] if up_amount == 0
#  up = ps[i][:feats][:up]
#  memo_up[call_id] = up.combination(up_amount).map do |feats|
#    feats.reduce(0){|acc, feat| acc | BITS[feat]}
#  end
#end
#
#memo_down = {}
#define_method :down_combs do |i, down_amount|
#  call_id = i*22+down_amount
#  return memo_down[call_id] if memo_down[call_id]
#  return memo_down[call_id] = [0] if down_amount == 0
#  down = ps[i][:feats][:down]
#  memo_down[call_id] = down.combination(down_amount).map do |feats|
#    feats.reduce(0){|acc, feat| acc | BITS[feat]}
#  end
#end

tk = (ps.last[:sim]/2.0).ceil.to_i - 1
changes = {}
while changes.empty?
  tk += 1
  for ri in 1..ps.size
    i = ps.size - ri
    local_changes = {}
    is_first = i == ps.size-1
    up   = ps[i][:feats][:up]
    down = ps[i][:feats][:down]
    sim  = ps[i][:sim]
    need_reduce = sim - tk
    max_downs = tk < down.size ? tk : down.size
    max_up = max_downs - need_reduce
    max_up = 0 if max_up < 0
    max_up = up.size if max_up > up.size
    for up_amount in 0..max_up
      missing_amount = tk - up_amount
      max_downs = missing_amount if missing_amount < max_downs
      min_downs = need_reduce + up_amount
      up_combs = up_combs(i, up_amount)
      for down_amount in min_downs..max_downs
        down_combs(i, down_amount).each do |down_comb|
          up_combs.each do |up_comb|
            comb = up_comb | down_comb
            if is_first || changes[comb]
              local_changes[comb] = true
            end
          end
        end
      end
    end
    if local_changes.empty?
      break
    else
      changes = local_changes
    end
  end
end

def to_feats_list(bits)
  i = 0
  feats = []
  while bits > 0
    b = bits % 2
    bits = bits / 2
    feats << i if b == 1
    i += 1
  end
  feats
end

#p tk
#p changes.keys.map{|bits| to_feats_list(bits)}
to_feats_list(changes.keys.first).each{|i| ref[i] = !ref[i]}
puts ref.map{|v| v ? '1' : '0'}.join
