movies = {
  terminator: 4,
  godzilla: 3,
  the_green_book: 5,
  superman: 5,
}

puts "Введите то, что вы хотели бы сделать:

--add - Добавить фильм и его рейтинг
--update - Обновить рейтинг фильма
--display - Показать фильмы и их рейтинг
--delete - Удалить фильм из списка "

choice = gets.chomp

case choice
  when "add"
    puts "Введите название фильма"
    title = gets.chomp
    puts "Введите рейтинг фильма 1..5"
    rating = gets.chomp
    if movies[title.to_sym].nil?
      movies[title.to_sym] = rating.to_i
      puts "#{title} с рейтингом #{rating} добавлен!"
    else
      puts "Фильм уже есть в списке!"
    end
  when "update"
    puts "Введите название фильма"
    title = gets.chomp
    puts "Введите рейтинг фильма 1..5"
    rating = gets.chomp
    if movies[title.to_sym].nil?
      puts "Фильма нет в списке!"
    else
      movies[title.to_sym] = rating.to_i
      puts "#{title} обновлен с рейтингом #{rating}!"
    end
  when "display"
    movies.each { |movie, rating| puts "#{movie}: #{rating}"}
  when "delete"
    puts "Введите название фильма:"
    title = gets.chomp
    if movies[title.to_sym].nil?
      puts "Такого фильма нет в списке!"
    else
      movies.delete(title.to_sym)
      puts "#{title.to_sym} удален!"
    end
  else
    puts "Error!"
end