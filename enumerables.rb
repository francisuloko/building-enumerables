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

  def my_select(array)
    newarray = []
    array.my_each do |i|
      newarray.push(i) if yield(i)
    end
    newarray
  end

  def my_all?(array)
    returns = true
    array.my_each { |item| returns = false unless yield(item) }
    returns
  end

  def my_map
    temp = []
    i = 0
    while i < length
      temp.push(yield(self[i]))
      i += 1
    end
    p temp
  end

  def my_any?
    i = 0
    while i < length
      result = yield(self[i])
      return true if result == true

      i += 1
    end
    false
  end
end

array = %w[asd asdd qweee 2 3 4 5]
num = [3, 2, 1, 5, 8, 12]
array.my_each(array) { |item| puts item }
array.my_each_with_index(array) { |item, _index| puts "asdasd #{item}" }
# num.my_select(array) { |item| puts item  }

array.my_map { |item| item * 2 }
p array.my_any? { |item| item.length < 2 }
