require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array[0]
    i = 1
    left = []
    right = []
    while i < array.length
      if array[i] < pivot
        left << array[i]
      else
        right << array[i]
      end
      i+=1
    end

    return QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
      el1 <=> el2
    end
    return if length <= 1
    right_start = self.partition(array, start, length, &prc)
    self.sort2!(array, start, right_start - start, &prc)
    self.sort2!(array, right_start + 1 , length - right_start - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new do |el1, el2|
      el1 <=> el2
    end
    pivot = array[start]

    remaining = start+1
    idx = start+1
    while remaining < length+start
      if prc.call(pivot,array[remaining]) == 1
        array[idx], array[remaining] = array[remaining], array[idx] if remaining != idx
        idx += 1
      end
      remaining += 1
    end
    i = start
    while i < idx-1
      array[i] = array[i+1]
      i+=1
    end
    array[idx-1] = pivot
    idx-1
  end
end
