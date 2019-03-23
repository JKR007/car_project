describe 'Expectation Matchers' do

  describe 'Equivalence Matchers' do

    it 'will match loose equality with #eq' do
      a = '2 horses'
      b = '2 horses'
      expect(a).to eq(b)
      expect(a).to be == b # synonym for #eq

      c = 5
      d = 5.0
      expect(c).to eq(d) # different types but close enough
    end

    it 'will match value equality with #eql' do
      a = '2 horses'
      b = '2 horses'
      expect(a).to eql(b)

      c = 5
      d = 5.0
      expect(c).not_to eql(d) # this throws exception since Int type is not equal to Double
    end

    it 'will match identity equality with #equal' do
      a = '2 horses'
      b = '2 horses'
      expect(a).not_to equal(b) # This checks for Object Identity (object_id)
                                # The same value but different object

      c = b

      expect(c).to equal(c) # same object
      expect(c).to be(b)    # sysnonym to equal
    end
  end
end