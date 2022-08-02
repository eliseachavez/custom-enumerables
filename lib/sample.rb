module Enumerable
  def my_each_with_index(&blk)
    idx = 0
    my_each do |element|
      blk.call(element, idx)
      idx += 1
    end
  end
end

class Array
  include Enumerable

  def my_each(&blk)
    return to_enum unless block_given?

    i = 0
    until i == size
      blk.call(self[i])
      i += 1
    end
    self
  end
end

[1,2,3].my_each
final = [[1, 0, 1, 0], [1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3], [5, 4, 5, 4], [8, 5, 8, 5], [13, 6, 13, 6], [21, 7, 21, 7], [34, 8, 34, 8]].my_each_with_index { |element, index| }
pp final
if final ==  [[[1, 0, 1, 0], 0], [[1, 1, 1, 1], 2], [[2, 2, 2, 2], 4], [[3, 3, 3, 3], 6], [[5, 4, 5, 4], 8], [[8, 5, 8, 5], 10], [[13, 6, 13, 6], 12], [[21, 7, 21, 7], 14], [[34, 8, 34, 8], 16]].my_each_with_index
  puts "success!!"
end
