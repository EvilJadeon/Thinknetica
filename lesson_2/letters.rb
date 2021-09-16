aplphabet = Hash[(:a..:z).to_a.zip(1..26).to_a]

result = aplphabet.select! {|key, value| [:a, :e, :i, :o, :u, :y].include? (key)}

print result
