require_relative 'lib/hashmap'

# Running HashMap DS to check full structure
test = HashMap.new

puts "Capacity: #{test.capacity}"
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

p test.entries
p test.keys
p test.values
p test.length

p 'checking changes'
p test.set('ice cream', 'vanilla')
p test.get('ice cream')
p test.values
p test.length

puts "Capacity: #{test.capacity}"
