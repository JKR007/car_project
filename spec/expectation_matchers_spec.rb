describe 'Expectation Matchers' do

  describe 'equivalence matchers' do

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

  describe 'truthiness matchers' do
    it 'will match true/false' do
      expect(0 < 2).to be(true)  # do not use 'be_true'
      expect(3 > 5).to be(false) # do not use 'be_false'

      expect('string').not_to be(true) # the string is not exactly true
      expect(nil).not_to be(false)     # the nil is not exactly false
      expect(0).not_to be(false)       # 0 (zero) is not exactly false
    end

    it 'will match truthy/falsey' do
      expect(4 < 6).to be_truthy
      expect(1 > 1.5).to be_falsey

      expect('string').to be_truthy # any value counts as true
      expect(nil).to be_falsey      # nil counts as false
      expect(0).not_to be_falsey    # but 0 (zeor) is still not falsey enough
    end

    it 'will match nil' do
      expect(nil).to be_nil
      expect(nil).to be(nil)

      expect(false).not_to be(nil) # nil is nil not false
      expect(0).not_to be(nil)     # nil is nil not 0 (zero)
    end
  end

  describe 'numeric comparison matchers' do

    it 'will match less/greater than' do
      expect(5).to be > 3
      expect(5).to be >= 5
      expect(5).to be <= 5
      expect(5).to be < 6
    end

    it 'will match numeric ranges' do
      expect(5).to be_between(1, 5).inclusive
      expect(5).not_to be_between(1, 5).exclusive
      expect(5).to be_within(1).of(6)
      expect(1..10).to cover(5)
    end
  end
end