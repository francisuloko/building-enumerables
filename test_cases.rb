#!/usr/bin/env ruby
require './enumerables'

# 1. #my_each
puts ' '
p "START OF MY_EACH"
p "END OF MY_EACH"
puts ' '

# 2. #my_each_with_index
p 'START #my_each_with_index?'
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
  hash
end
puts hash

puts 'END of #my_each_with_index?'

puts ' '

# 2. my_all
p 'START #my_all?'
p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/t/)                        #=> false
p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
p [nil, true, 99].my_all?                              #=> false
p [].my_all?                                           #=> true
p 'END OF #MY_ALL?'

puts ' '

# 3. MY_SELECT
p 'START my_select'
p (1..10).my_select { |i|  i % 3 == 0 }   #=> [3, 6, 9]

p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

p [:foo, :bar].my_select { |x| x == :foo }   #=> [:foo]
p 'END OF MY_SELECT'

puts ' '

# 4. my_any
p 'START #my_any?'
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)                     #=> true
p [nil, true, 99].my_any?                              #=> true
p [].my_any?                                           #=> false
p 'END OF #MY_ANY?'

puts ' '

# 5. my_none
p 'START #my_none?'
p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false
p 'END OF #MY_NONE?'

puts ' '

# 6. my_count
p 'START my_count?'
ary = [1, 2, 4, 2]
p ary.my_count                                          #=> 4
p ary.my_count(2)                                       #=> 2
p ary.my_count(&:even?)                                 #=> 3
p 'END OF #MY_COUNT?'

puts ' '

# 7. my_map
p 'START my_map?'
p (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
p 'END OF my_count?'

puts ' '

# Sum some numbers
p (5..10).my_inject(:+)                             #=> 45
# Same using a block and inject
p (5..10).my_inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
p (5..10).my_inject(1, :*)                          #=> 151200
# Same using a block
p (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end
p longest                                        #=> "sheep"

p [2, 4, 5].multiply_els
p multiply_els([2, 4, 5])