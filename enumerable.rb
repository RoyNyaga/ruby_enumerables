# frozen_string_literal: true

module Enumerable
  def my_each
    length.times do |i|
      yield self[i]
    end
  end

  def my_each_with_index
    length.times do |i|
      yield self[i], i
    end
  end

  def my_select
    aux_array = []
    length.times do |i|
      aux_array << self[i] if yield self[i]
    end
    aux_array
  end

  def my_all?
    my_each { |value| return false unless yield value }
    true
  end

  def my_any?
    my_each { |value| return true if yield value }
    false
  end

  def my_none?
    my_each { |value| return false if yield value }
    true
  end

  def my_count
    count = 0
    if block_given?
      my_each { |value| count += 1 if yield value }
    else
      my_each { count += 1 }
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
