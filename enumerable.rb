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
end
