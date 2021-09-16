arr = [1, 1]

9.times do
  arr.push(arr[-1] + arr[-2])
end

print arr
