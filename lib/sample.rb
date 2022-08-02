module Enumerable
  def my_each_with_index
    i = 0
    while i < size
      my_each do |element|
        ary = []
        ary.push(yield element)
        ary.push(yield i)
        delete_at(i)
        insert(i, ary)
        i += 1
      end
    end
    self
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
