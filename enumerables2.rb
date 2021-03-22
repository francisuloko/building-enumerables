# frozen_string_literal: true

# Implementing ruby enum methods
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    length.times do |i|
      yield self[i]
    end
    self
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    length.times do |i|
      yield self[i], i
    end
    self
  end

  def my_select
    return enum_for(:my_select) unless block_given?

    newarray = []
    to_a.my_each { |i| newarray.push(i) if yield(i) }
    newarray
  end

  def my_all?(array = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
    elsif array.nil?
      to_a.my_each { |item| return false if !item || item.nil? }
    elsif array && (array.is_a? Class)
      to_a.my_each { |item| return true if item.class }
    elsif array && (array.is_a? Regexp)
      to_a.my_each { |item| return false unless item.match(array) }
    else
      to_a.my_each { |item| return false unless item != array }
    end
    false
  end

  def my_any?(array = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) == true }
    elsif array.nil?
      to_a.my_each { |item| return true if item == true }
    elsif array && (array.is_a? Class)
      to_a.my_each { |item| return false unless item.class }
    elsif array && (array.is_a? Regexp)
      to_a.my_each { |item| return false unless item.match(array) }
    else
      to_a.my_each { |item| return false unless item != array }
    end
    false
  end

  def my_none?(array = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) == false }
    elsif array.nil?
      to_a.my_each { |item| return false if item == true }
    elsif array && (array.is_a? Class)
      to_a.my_each { |item| return false unless item.class }
    elsif array && (array.is_a? Regexp)
      to_a.my_each { |item| return false unless item.match(array) }
    else
      to_a.my_each { |item| return false unless item != array }
    end
    false
  end

  def my_count(array = nil)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(item) }
    elsif array.nil?
      my_each { |item| count += 1 if item == true }
    else
      my_each { |item| count += 1 if item == array }
    end
    count
  end

  def my_map(proc = nil)
    return enum_for(:my_each) unless block_given?

    temp = []
    i = 0
    while i < length
      temp.push(yield(self[i]))
      i += 1
    end
    temp
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
