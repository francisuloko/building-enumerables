# rubocop: disable Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/CyclomaticComplexity
# frozen_string_literal: true

# Implementing  ruby enum methods
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    to_a.length.times do |i|
      yield to_a[i]
    end
    self
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    to_a.length.times do |i|
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
      to_a.my_each { |item| return true if yield(item) }
    elsif arg && (arg.is_a? Regexp)
      to_a.my_each { |item| return true if item.match(arg) }
    elsif arr && (arg.class.is_a? Class)
      to_a.my_each { |_item| return true }
    else
      to_a.my_each { |item| return true if item }
    end
    false
  end

  def my_any?(arg = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
    elsif arg && (arg.is_a? Regexp)
      to_a.my_each { |item| return true if item.match(arg) }
    elsif arr && (arg.class.is_a? Class)
      to_a.my_each { |_item| return true }
    else
      to_a.my_each { |item| return true if item }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
    elsif arg
      to_a.my_each do |item|
        return true if item.is_a?(Numeric) || item.is_a?(Regexp)
      end
    else
      to_a.my_each { |item| return true if item }
    end
    false
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      to_a.my_each { |item| count += 1 if yield(item) }
    elsif arg
      to_a.my_each { |item| count += 1 if arg == item }
    else
      return to_a.length
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

  def my_inject(sum = nil, symbol = nil, &block)
    if block_given?
      to_a.my_each { |item| sum = sum.nil? ? item : yield(sum, item) }
    elsif sum.is_a?(Symbol)
      symbol = sum
      sum = nil
      to_a.my_each { |item| sum = sum.nil? ? item : sum.send(symbol, item) }
    else
      to_a.my_each(&block)
    end
    sum
  end
end
# rubocop: enable Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/CyclomaticComplexity

def multiply_els(arr = nil)
  arr.my_inject(:*)
end
