# frozen_string_literal: true

# Implementing ruby enum methods
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

  def my_any?
    i = 0
    while i < length
      result = yield(self[i])
      return true if result == true

      i += 1
    end
    false
  end

  def my_none?(array)
    returns = true
    array.my_each { |item| returns = false unless yield(item) }
    returns
  end

  def my_count
    i = 0
    count = 0
    while i < length
      count += 1 if yield(self[i]) == true
      i += 1
    end
    count
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

  def my_inject
    sum = self[0]
    i = 1
    while i < length
      sum = yield(sum, self[i])
      i += 1
    end
    sum
  end

  def multiply_els(arr)
    arr.my_inject { |i, j| i * j }
  end
end

array = %w[asd asdd qweee 2 3 4 5]
num = [2, 4, 5]

array.my_each(array) { |item| puts item }
array.my_each_with_index(array) { |item, _index| puts "asdasd #{item}" }
# num.my_select(array) { |item| puts item  }

array.my_map { |item| item * 2 }
num.my_any? { |item| item < 2 }
num.my_count { |item| item <= 7 }
num.my_inject { |sum, item| sum + item }
num.multiply_els(num)
