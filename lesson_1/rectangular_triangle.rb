a = puts "Введите длину стороны a:"
side_a = gets.chomp.to_f
b = puts "Введите длину стороны b:"
side_b = gets.chomp.to_f
c = puts "Введите длину стороны c:"
side_c = gets.chomp.to_f

a, b, hypo = [side_a, side_b, side_c].sort

if a == b && b == hypo && hypo == a
  puts "Треугольник является равносторонним"
elsif a == b || b == hypo || hypo == a
  puts "Треугольник является равнобедренным"
elsif hypo ** 2 == a ** 2 + b ** 2
  puts "Треугольник является прямоугольным"
else
  puts "Размеры треугольника не соответствуют условиям задачи"
end
