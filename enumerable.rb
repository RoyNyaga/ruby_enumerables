# frozen_string_literal: true

module Enumerable
  # Loops over the elements of an array
  def my_each
    length.times do |i|
      yield self[i]
    end
  end

  # Loops over elements and their indeces
  def my_each_with_index
    length.times do |i|
      yield self[i], i
    end
  end

  # Selects the values of an array based on specified property
  def my_select
    aux_array = []
    length.times do |i|
      aux_array << self[i] if yield self[i]
    end
    aux_array
  end

  # Checks for similar property in all the element of an array
  def my_all?
    my_each { |value| return false unless yield value }
    true
  end

  # Checks whether any of the elements have specified property
  def my_any?
    my_each { |value| return true if yield value }
    false
  end

  # Reverses the my All method
  def my_none?
    my_each { |value| return false if yield value }
    true
  end

  def my_count(*arg)
    count = 0
    if arg.empty?
      block_given? ? length.times { |i| count += 1 if yield self[i] } : count = length
    else
      length.times { |i| count += 1 if self[i] == arg[0] }
    end
    count
  end

  def my_map(proc = nil)
    [].tap { |arr| my_each { |value| arr << (proc ? proc[value] : yield(value)) } }
  end

  def my_inject(acc = nil)
    if acc
      rest = self
    else
      acc, *rest = self
    end
    rest.my_each { |val| acc = yield acc, val }
    acc
  end
end

# Multiple els method test for my inject method
def multiply_els(array)
  array.my_inject { |element, n| element * n }
end

# result of test
puts multiply_els([2, 4, 5])
