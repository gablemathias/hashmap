require_relative 'linked_list'

# HashMap Data Structure
# It makes use of the Linked List and its Nodes
# It is unordered compared to the Ruby Hash class.
class HashMap
  attr_reader :capacity, :quantity

  def initialize
    @buckets = [] # Initial "size" has to be 16
    @capacity = 16
    @load_factor = 0.75
    @quantity = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    return overwrite(key, value) if has?(key)

    index = hash(key) % capacity

    return if check_index(index)

    insert(index, key, value)

    self
  end

  def get(key)
    idx = index(key)
    return if idx.nil?

    node = @buckets[idx].head

    return node.value[1] if node.value[0] == key

    result = check_key(node, key)
    return result.value[1] unless result.nil?

    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def index(key)
    idx = hash(key) % 16
    turns = capacity / 16

    return if @buckets[idx].nil?

    turns.times do
      current_node = @buckets[idx].head

      result = check_key(current_node, key)
      return idx unless result.nil?

      idx %= 16
    end

    nil
  end

  def remove(key)
    return nil unless has?(key)

    node_head = @buckets[index(key)]
    idx = node_head.find([key, get(key)])
    action = -> { node_head.remove_at(idx) and @quantity -= 1 }
    pair = [key, get(key)]

    action.call
    pair
  end

  def length
    quantity
  end

  def clear
    @buckets = []
    @capacity = 16
    @quantity = 0
  end

  def entries # rubocop:disable Metrics/MethodLength
    arr = []
    @buckets.compact.each do |llist|
      nodes_size = llist.size
      node = llist.head
      if nodes_size > 1
        nodes_size.times do
          arr << node.value
          node = node.next_node
        end
      else
        arr << node.value
      end
    end

    arr
  end

  def keys
    entries.map { |pair| pair[0] }
  end

  def values
    entries.map { |pair| pair[1] }
  end

  private

  def check_key(node, key)
    return nil if node.nil?

    if node.next_node.nil?
      node if node.value[0] == key
    else
      check_key(node.next_node, key)
    end
  end

  def check_index(index)
    raise IndexError if index.negative? || index >= capacity
  end

  def get_node(key)
    node = @buckets[index(key)].head

    check_key(node, key)
  end

  def overwrite(key, new_value)
    node = get_node(key)
    node.value[1] = new_value
  end

  def buckets_overload?
    quantity >= capacity * @load_factor
  end

  def calibrate_capacity
    @capacity = capacity * 2
  end

  def insert(index, key, value)
    if @buckets[index].nil?
      @buckets[index] = LinkedList.new.append([key, value])
    else
      @buckets[index].append([key, value])
    end

    @quantity += 1
    calibrate_capacity if buckets_overload?
  end
end
