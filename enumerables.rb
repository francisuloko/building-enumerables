module Enumerable
  def my_each(array)
    array.length.times do |i|
      yield(array[i])
    end
  end

  def my_each_with_index(array)
    array.length.times do |i|
      yield(array[i], i)
    end
  end
end

array = %w[asd asdd qweee]
array.my_each(array) { |item| puts item }
array.my_each_with_index(array) { |item, index| puts "asdasd #{item}" }
