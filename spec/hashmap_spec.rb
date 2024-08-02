require_relative '../lib/hashmap'

RSpec.describe HashMap do
  let(:hashmap) { HashMap.new }

  context 'when updating the hash map' do
    it 'sets a key value pair in a bucket' do
      hashmap.set('a', 'b')
      expect(hashmap.quantity).to eq(1)
    end

    it 'removes the key value pair'
  end

  context 'when verifying the hash' do
    before { hashmap.set('jack', 'frost') }

    it 'returns an existing value' do
      expect(hashmap.get('jack')).to eq('frost')
    end

    it 'checks if a key exists' do
      expect(hashmap.has?('a')).to be false
      expect(hashmap.has?('jack')).to be true
    end

    it 'returns nil when key non-existent' do
      expect(hashmap.get('harry')).to be_nil
    end
  end
end
