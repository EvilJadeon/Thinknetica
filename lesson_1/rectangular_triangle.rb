a = puts "Введите длину стороны a:"
side_a = gets.chomp
b = puts "Введите длину стороны b:"
side_b = gets.chomp
c = puts "Введите длину стороны c:"
side_c = gets.chomp


if side_a.to_f == side_b.to_f && side_b.to_f == side_c.to_f
  puts "Треугольник является равносторонним"
elsif side_a.to_f == side_b.to_f || side_b.to_f == side_c.to_f || side_c.to_f == side_a.to_f
  puts "Треугольник является равнобедренным"
elsif side_a.to_f ** 2 == side_b.to_f ** 2 + side_c.to_f ** 2 || side_b.to_f ** 2 == side_a.to_f ** 2 + side_c.to_f ** 2 || side_c.to_f ** 2 == side_b.to_f ** 2 + side_a.to_f ** 2
  puts "Треугольник является прямоугольным"
else
  puts "Размеры треугольника не соответствуют условиям задачи"
end
