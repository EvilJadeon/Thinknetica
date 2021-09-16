a = 0
b = 1
array = []

while b <= 100
  array.push(b)
  a, b = b, a + b
end

print array
