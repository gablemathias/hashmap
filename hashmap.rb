class HashMap

  def initialize
    @buckets = [] # Initial "size" has to be 16
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    
    hash_code
  end

  def set(key, value)
    
  end
end