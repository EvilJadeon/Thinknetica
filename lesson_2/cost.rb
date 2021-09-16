puts "Продуктовая корзина"

array = []
array_result = []
total = 0
total_array = []

loop do
  puts "Введите название товара:"
  product_name = gets.chomp

  puts "Введите цену за единицу товара:"
  price = gets.to_f

  puts "Введите кол-во купленного товара:"
  quantity = gets.to_f

  hash = {product_name => {price => quantity}}
  total = price * quantity
  hash_1 = {product_name => total}

  array.push(hash)
  array_result.push(hash_1)
  total_array.push(total)

  break if product_name == 'стоп'
end

  puts "Ваша корзина:"
  array.pop()
  print array

  puts "\nИтого за каждый товар:"
  array_result.pop()
  print array_result

  total_array.pop()
  total_array = total_array.sum
  puts "\nИтоговая сумма всех покупок в корзине: #{total_array}"
