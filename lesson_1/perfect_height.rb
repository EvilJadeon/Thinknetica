n = puts "Введите ваше имя:"
name = gets.chomp
h = puts "Введите ваш рост:"
height = gets.chomp
result = (height.to_i - 110) * 1.15

if result >= 0
  puts "#{name}, #{result}"
else
  puts "Ваш вес уже оптимальный"
end
