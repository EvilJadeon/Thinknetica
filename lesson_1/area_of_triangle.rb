a = puts "Введите длину основания треугольника:"
osn = gets.chomp
h = puts "Введите длину высоты треугольника:"
vis = gets.chomp

area = (osn.to_f * vis.to_f) / 2
result = puts "Площадь треугольника равна #{area}"
