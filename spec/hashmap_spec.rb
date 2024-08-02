require 'rubocop-rspec'
require_relative '../lib/hashmap'

RSpec.describe HashMap do
  let(:hashmap) { HashMap.new }

  it 'sets a key value pair in a bucket'
  it 'returns an existing value from the hash'
  it 'checks if a key exists in the hash'
  it 'removes the key value pair from the hash'
end
