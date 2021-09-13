input_a = puts "Введите переменную a:"
a = gets.chomp.to_f
input_b = puts "Введите переменную b:"
b = gets.chomp.to_f
input_c = puts "Введите переменную c:"
c = gets.chomp.to_f

d = b ** 2 - (4 * a * c)
if d >= 0
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
end

if d > 0
  puts "Дискриминант: #{d}, x1: #{x1}, x2: #{x2}"
elsif d == 0
  puts "Дискриминант: #{d}, х1: #{x1}"
else
  puts "Дискриминант: #{d}, корней нет"
end
