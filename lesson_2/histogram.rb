puts "Введите текст:"
text = gets.chomp
words = text.split

frequencies = Hash.new(0)

words.each {|word| frequencies[word] += 1}
frequencies = frequencies.sort_by do |word, num|
  num
end
frequencies.reverse!

frequencies.each do |word, num|
  puts word + " " + num.to_s
end
