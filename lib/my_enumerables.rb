module Enumerable
  # mimics the Enumerable module and all the enumerators it provides to Array and Hash classes
  def my_each_with_index
    return to_enum unless block_given?

    idx = 0
    my_each do |element|
      yield(element, idx)
      idx += 1
    end
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
# my example of this:
# [1,2,3].my_each { |element| puts element} # second part is the block that is an argument to my_each
class Array
  # my_each iterates through each element of the calling array
  include Enumerable

  def my_each(&blk)
    return to_enum unless block_given? # guard clause #self.to_enum is redundant

    i = 0
    until i == size # self.size is redundant apparently, only need to say size
      blk.call(self[i])
      i += 1
    end
    self
  end
end

[1,2,3].my_each
final = [[1, 0, 1, 0], [1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3], [5, 4, 5, 4], [8, 5, 8, 5], [13, 6, 13, 6], [21, 7, 21, 7], [34, 8, 34, 8]].my_each_with_index
pp final
if final ==  [[[1, 0, 1, 0], 0], [[1, 1, 1, 1], 2], [[2, 2, 2, 2], 4], [[3, 3, 3, 3], 6], [[5, 4, 5, 4], 8], [[8, 5, 8, 5], 10], [[13, 6, 13, 6], 12], [[21, 7, 21, 7], 14], [[34, 8, 34, 8], 16]].my_each_with_index
  puts "success!!"
end
