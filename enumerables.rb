# frozen_string_literal: true

# Implementing ruby enum methods
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    length.times do |i|
      yield to_a[i]
    end
    self
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    length.times do |i|
      yield to_a[i], i
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    temp = []
    to_a.my_each { |item| temp.push(item) if yield(item) }
    temp
  end

  def my_all?(arg = nil)
    if block_given?
      to_a.my_each { |item| return false unless yield(item) }
    elsif arg
      to_a.my_each do |item|
        return false unless item.is_a?(Numeric) || item.is_a?(Regexp)
      end
    else
      to_a.my_each { |item| return false unless item }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
    elsif arg
      to_a.my_each do |item|
        return true if item.is_a?(Integer) || item.is_a?(Regexp)
      end
    else
      to_a.my_each { |item| return true if item }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      to_a.my_each { |item| return false if yield(item) }
    elsif arg
      to_a.my_each do |item|
        return false if item.is_a?(Numeric) || item.is_a?(Regexp)
      end
    else
      to_a.my_each { |item| return false if item }
    end
    true
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
