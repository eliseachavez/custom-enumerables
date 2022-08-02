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
    return to_enum unless block_given?

    ary = []
    my_each do |element|
      ary << yield(element)
    end
    ary
  end

  def my_inject(arg, &blk)
    return 'Error, no block given' unless block_given?

    idx = 0
    accumulator = arg if arg
    my_each do |element|
      accumulator = element if accumulator.nil? && idx.zero?
      accumulator = blk.call(accumulator, element)
      idx += 1
    end
    accumulator
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
