class LinkedList # rubocop:disable Style/Documentation
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(node)
    if head.nil?
      @head = create(node)
    else
      current_node = @head
      current_node = current_node.next_node until current_node.next_node.nil?
      current_node.next_node = create(node)
    end

    self
  end

  def prepend(node)
    if head.nil?
      @head = create(node)
      return self
    end

    old_head = head # A node
    @head = create(node)
    @head.next_node = old_head
  end

  def size
    current_node = head
    count = 0

    loop do
      break if current_node.nil?

      count += 1
      current_node = current_node.next_node
    end

    count
  end

  def tail
    current_node = head

    current_node = current_node.next_node until current_node.next_node.nil?

    current_node
  end

  def at(index)
    return head if index.zero?

    current_node = head
    until current_node.next_node.nil? || index.zero?
      current_node = current_node.next_node
      index -= 1
    end

    index.zero? ? current_node : nil
  end

  def pop
    last_node = tail
    if head == last_node
      @head = nil
      return last_node
    end

    current_node = head
    current_node = current_node.next_node until current_node.next_node == last_node

    current_node.next_node = nil
    last_node
  end

  def contains?(value)
    current_node = head

    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = head
    count = 0

    until current_node.nil?
      return count if current_node.value == value

      current_node = current_node.next_node
      count += 1
    end

    nil
  end

  def insert_at(value, index)
    prepend(value) and return if index.zero?
    return 'invalid index' if at(index).nil?

    new_node = create(value)
    node_before = at(index - 1)

    new_node.next_node = node_before.next_node
    node_before.next_node = new_node
  end

  def remove_at(index)
    @head = head.next_node if index.zero?
    return 'invalid index' if at(index).nil?

    target = at(index)
    node_before = at(index - 1)

    node_before.next_node = target.next_node
  end

  def to_s
    current_node = head
    string = ''

    return 'nil' if current_node.nil?

    until current_node.nil?
      string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    "#{string}nil"
  end

  private

  def create(node)
    Node.new(node)
  end
end

class Node # rubocop:disable Style/Documentation
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end
