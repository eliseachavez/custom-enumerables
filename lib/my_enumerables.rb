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

  def my_select
    return to_enum unless block_given?

    ary = []
    my_each do |element|
      if yield(element)
        ary << element
      end
    end
    ary
  end

  def my_all?
    return to_enum unless block_given?

    nil_count = 0
    my_each do |element|
      nil_count += 1 unless yield(element)
    end

    nil_count.positive? ? false : true
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
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

# ary = [1, 1, 2, 3, 5, 8, 13, 21, 34]
# ans = ary.my_all? { |value| value > 0 }
# puts "Are ALL values over 5? #{ans}"

# ary2 = [1, 1, 2, 3, -2, 5, 8, 13, 21, 34]
# ans = ary2.my_all? { |value| value > 0 }
# puts "Are ALL values over 5? #{ans}"
