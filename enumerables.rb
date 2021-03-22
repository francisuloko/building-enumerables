# Implementing  ruby enum methods
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

  def my_count(arg = nil)
    count = 0
    if block_given?
      to_a.my_each { |item| count += 1 if yield(item) }
    elsif arg
      to_a.my_each { |item| count += 1 if arg == item }
    else
      return length
    end
    count
  end

  def my_map(my_proc = nil)
    return enum_for(:my_map, my_proc) unless
      block_given? || my_proc

    temp = []
    if my_proc
      to_a.my_each { |item| temp << my_proc.call(item) }
    else
      to_a.my_each { |item| temp << yield(item) }
    end
    temp
  end

  def my_inject(sum = nil, symbol = nil)
    if sum.is_a?(Symbol)
      symbol = sum
      sum = nil
    end
    if block_given?
      to_a.my_each { |item| sum = sum.nil? ? item : yield(sum, item) }
    else
      to_a.my_each { |item| sum = sum.nil? ? item : sum.send(symbol, item) }
    end
    sum
  end
end

def multiply_els(arr = nil)
  arr.my_inject(:*)
end
