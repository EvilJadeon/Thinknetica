puts "Введите день:"
day = gets.to_i
puts "Введите месяц:"
month = gets.to_i
puts "Введите год:"
year = gets.to_i

day_of_month = [31,28,31,30,31,30,31,31,30,31,30,31]

res = 0
i = 0

for i in day_of_month
  res = (i - 1) * (month - 1)
end

if month > 2
  if year % 4 == 0
    if (year % 100 == 0) && (year % 400 != 0)
      res = res
    else
      res = res + 1
    end
  end
end

puts "Номер дня с начала года: #{res}"
