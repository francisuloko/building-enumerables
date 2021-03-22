# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
    def my_each
      return enum_for(:my_each) unless block_given?
      i = 0
      while i < to_a.length
        yield(to_a[i])
        i += 1
      end
      self
    end
  
    def my_each_with_index
      return enum_for(:my_each_with_index) unless block_given?
      i = 0
      while i < to_a.length
        yield(to_a[i], i)
        i += 1
      end
      self
    end
  
    def my_select
      return to_enum unless block_given?
      temp = []
      my_each { |item| temp.push(item) if yield(item) }
      temp
    end
  
    def my_all?(arg = nil)
      if block_given
        my_each { |item| return false unless yield(item) }
      elsif arg
        my_each do |item|
          return false unless item.is_a?(Numeric) || item.is_a?(Regexp)
        end
      else
        my_each { |item| return false unless item }
      end
      true
    end
  
    def my_any?(arg = nil)
      if block_given?
        my_each { |item| return true if yield(item) }
      elsif arg
        my_each do |item|
          return true if item.is_a?(Integer) || item.is_a?(Regexp)
        end
      else
        my_each { |item| return true if item }
      end
      false
    end
  
    def my_none?(arg = nil)
      if block_given?
        my_each { |item| return false if yield(item) }
      elsif arg
        my_each do |item|
          return false if item.is_a?(Numeric) || item.is_a?(Regexp)
        end
      else
        my_each { |item| return false if item }
      end
      true
    end
  
    def my_count(arg = nil)
      count = 0
      if block_given?
        my_each { |item| count += 1 if yield(item) }
      elsif arg
        my_each { |item| count += 1 if arg == item }
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
        my_each { |item| temp << my_proc.call(item) }
      else
        my_each { |item| temp << yield(item) }
      end
      temp
    end
    
    def my_inject(sum = nil, symbol = nil)
      if sum.is_a?(Symbol)
        symbol = sum
        sum = nil
      end
      if block_given?
        my_each { |item| sum = sum.nil? ? item : yield(sum, item) }
      else
        my_each { |item| sum = sum.nil? ? item : sum.send(symbol, item) }
      end
      sum
    end
  
    def multiply_els
      my_inject(:*)
    end
  end
  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  
  def multiply_els(arr = nil)
    arr.my_inject(:*)
  end
  