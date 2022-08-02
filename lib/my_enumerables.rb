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
      ary << element if yield(element)
    end
    ary
  end

  def my_all?
    return to_enum unless block_given?

    false_count = 0
    my_each do |element|
      false_count += 1 unless yield(element)
    end

    false_count.positive? ? false : true
  end

  def my_any?
    return to_enum unless block_given?

    any = false
    my_each do |element|
      any = true if yield(element)
    end

    any ? true : false
  end

  def my_none?
    return to_enum unless block_given?

    true_count = 0
    my_each do |element|
      true_count += 1 if yield(element)
    end

    true_count.positive? ? false : true
  end

  def my_count
    return size unless block_given?

    true_count = 0
    my_each do |element|
      true_count += 1 if yield(element)
    end

    true_count
  end

  def my_map
    puts "hi"
  end

  def my_inject
    puts "hi"
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

#result = [1,1,2,3,5,8,13,21,34].my_count { |value| value > 5 }
#puts result
