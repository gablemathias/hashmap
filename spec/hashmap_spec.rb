require_relative '../lib/hashmap'

RSpec.describe HashMap do
  let(:hashmap) { HashMap.new }

  context 'when updating the hash map' do
    it 'sets a key value pair in a bucket' do
      hashmap.set('a', 'b')
      expect(hashmap.quantity).to eq(1)
    end

    it 'removes the key value pair' do
      node = hashmap.set('a', 'b')
      node.remove('a')

      expect(hashmap.quantity).to eq(0)
      expect(hashmap.get('a')).to be_nil
    end

    it 'overwrites current value in the given key' do
      hashmap.set('a', 'b')
      hashmap.set('a', 'c')

      expect(hashmap.get('a')).to eq('c')
      expect(hashmap.quantity).to eq(1)
    end

    it 'empty the hashmap' do
      hashmap.set('a', 'b')
      hashmap.set('c', 'd')
      hashmap.clear

      expect(hashmap.quantity).to be_zero
    end
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

    context 'when checking all the hashmap' do
      before do
        hashmap.set('a', 'b')
        hashmap.set('c', 'd')
      end

      it 'returns array with entries' do
        target = %w[a b], %w[c d], %w[jack frost]
        expect(hashmap.entries).to match_array target
      end

      it 'returns array with keys' do
        target = %w[a c jack]
        expect(hashmap.keys).to match_array target
      end

      it 'returns array with values' do
        target = %w[b frost d]
        expect(hashmap.values).to match_array target
      end
    end
  end
end
