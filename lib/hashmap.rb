require_relative 'linked_list'

class HashMap
  attr_reader :capacity

  def initialize
    @buckets = [] # Initial "size" has to be 16
    @capacity = 16
    @load_factor = 0.8
    @quantity = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    
    hash_code
  end

  def set(key, value)
    index = hash(key) % capacity

    check_index(index)

    if @buckets[index].nil?
      @buckets[index] = LinkedList.new.append([key, value])
    else
      @buckets[index].append([key, value])
    end

    calibrate_capacity if buckets_overload?
  end
  
    private

    def check_index(idx)
      raise IndexError if index.negative? || index >= @buckets.length
    end

    def buckets_overload?
      quantity >= capacity * @load_factor
    end

    def calibrate_capacity
      @capacity = capacity * 2
    end
end