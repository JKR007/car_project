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

  describe 'collection matchers' do
    it 'will match arrays' do
      array = %w[a b c]

      expect(array).to include('a')
      expect(array).to include('b', 'c')

      expect(array).to start_with('a')
      expect(array).to end_with('c')

      expect(array).to match_array(%w[b c a])
      expect(array).not_to match_array(%w[b a])

      expect(array).to contain_exactly('b', 'a', 'c') # smiliar to match_array but using individual args
      expect(array).not_to contain_exactly('b', 'c')
    end

    it 'will match strings' do
      string = 'Gap Intelligence'

      expect(string).to include('ap Intel')
      expect(string).to include('lli', 'Gap')

      expect(string).to start_with('Ga')
      expect(string).to end_with('gence')

    end

    it 'will match hashes' do
      hash = { a: 1, b: 4, c: 5 }

      expect(hash).to include(:a)
      expect(hash).to include(a: 1)

      expect(hash).to include(a: 1, b: 4)
      expect(hash).to include(a: 1, c: 5, b: 4)

      expect(hash).not_to include('a' => 1, 'c' => 5)
    end
  end

  describe 'other useful matchers' do
    it 'will match strings with RegEx' do
      str = 'I am more than Junior, nearly Middle'
      expect(str).to match(/Junior(.+)Middle/)

      expect('12345').to match(/\d{5}/)
      expect(12_345).not_to match(/\d{5}/)

      email = 'someone@domain.com'
      expect(email).to match(/\A\w+@\w+\.\w{2,3}\Z/)
    end

    it 'will match object types' do
      expect('IamMiddleDev').to be_instance_of(String)
      expect('IamMiddleDev').to be_an_instance_of(String)

      class MyString < String
      end
      my_str = MyString.new('test')
      expect(my_str).to be_kind_of(String)
      expect('test').not_to be_kind_of(MyString)

      expect('IamMiddleDev').to be_a(String)
      expect([1, 2, 3]).to be_an(Array)
    end

    it 'will match objects with respond_to' do
      str = 'IamMiddleDev'
      expect(str).to respond_to(:length)
      expect(str).not_to respond_to(:sort)
    end

    it 'will match class instances with #have_attributes' do
      class Person
        attr_accessor :first_name, :last_name, :age
      end
      pn = Person.new
      pn.first_name = 'Gal'
      pn.last_name = 'Gadot'
      pn.age = 33

      expect(pn).to have_attributes(first_name: 'Gal')
      expect(pn).to have_attributes(first_name: 'Gal', last_name: 'Gadot', age: 33)
    end

    it 'will match anything with #satisfy' do
      # The most flexible matcher
      expect(20).to satisfy do |value|
        value > 10 && value <= 20 && value.even?
      end
    end

  end

  describe 'predicate matchers' do
    it 'will match be_* to custom methods ending in ?' do
      # using built-in methods
      expect([]).to be_empty        # [].empty?
      expect(1).to be_integer       # 1.integer?
      expect(0).to be_zero          # 0.zero?
      expect(1).to be_nonzero       # 1.nonzero?
      expect(1).to be_odd           # 1.odd?
      expect(2).to be_even          # 2.even?

      # using custom methods
      class Product
        def visible?
          true
        end
      end
      product = Product.new
      expect(product).to be_visible  # product.visible?
    end

    it 'will march have_* to custom methods ending in has_?' do
      # using built-in methods
      hash = { a: 1, b: 2 }
      expect(hash).to have_key(:a)   # hash.has_key?
      expect(hash).to have_value(2)  # hash.has_value?

      # using custom methods
      class Product
        def has_promo_code?
          true
        end
      end

      product = Product.new
      expect(product).to have_promo_code
      expect(product.has_promo_code?).to be true
    end
  end

  describe 'observation matchers' do
    # Observation matchers format: expect{}

    it 'will match when events change object attributes' do
      # call the test before and after the block (check two times)
      array = []
      expect { array << 1 }.to change(array, :empty?).from(true).to(false)

      class StepUp
        attr_accessor :count
        def initialize
          @count = 0
        end

        def increment
          @count += 1
        end
      end
      step = StepUp.new
      expect { step.increment }.to change(step, :count).from(0).to(1)

    end

    it 'will match when events change any values' do
      num = 5
      expect { num += 1 }.to change { num }.from(5).to(6)
      expect { num += 1 }.to change { num }.by(1)
      expect { num += 1 }.to change { num }.by_at_least(1)
      expect { num += 1 }.to change { num }.by_at_most(1)

      expect { num *= 2 }.to change { num%2 }.from(1).to(0)
    end

    it 'will match when errors raised' do
      # Observation Errors

      expect { raise StandardError }.to raise_error.with_message('StandardError')
      expect { raise StandardError }.to raise_exception.with_message('StandardError')

      expect { 1 / 0 }.to raise_error(ZeroDivisionError)
      expect { 1 / 0 }.to raise_error.with_message('divided by 0')
      expect { 1 / 0 }.to raise_error.with_message(/divided/)

      # Note! The negative does not accept arguments
      expect { 1 / 1 }.not_to raise_error

    end

    it 'will match when output is generated' do
      # Observes output sent - to $stdout or $stderr

      expect { print('Hello') }.to output.to_stdout
      expect { print 'Hello' }.to output('Hello').to_stdout
      expect { print 'Hello' }.to output(/ll/).to_stdout

      expect { warn 'Problem' }.to output(/Problem/).to_stderr
    end
  end

  describe 'compound expectations' do
    it 'will match using: and, or, &, |' do
      expect([1, 2, 3, 4]).to start_with(1).and end_with(4)
      expect([1, 2, 3, 4]).to start_with(1) & include(3)

      expect(10 * 2).to be_odd.or be < 100
      array = %w[a b].shuffle
      expect(array).to start_with('a') | end_with('a')
    end
  end

  describe 'composing matchers' do
    # from RSpec 3, some matchers accept matchers as arguments
    it 'will match all collection elements using a matcher' do
      array = [1, 3, 5]
      expect(array).to all(be_odd)
    end

    it 'will match by sending matchers as arguments to matchers' do
      string = 'Hello'
      expect{ string = 'Goodbye' }.to change{ string}.from(match(/ll/)).to(match(/oo/))

      hash = { a: 1, b: 2, c: 3 }
      expect(hash).to include(a: be_odd, b: be_even, c: be_odd)
      expect(hash).to include(a: be > 0, c: be_within(2).of(4))
    end

    it 'will match using non-phrase aliases for matchers' do
      # Old version <=> RSpec 3
      fruits = %w[apple banana water-melon]
      expect(fruits).to start_with(start_with('a')) & include(a_string_matching(/b.n.n/)) & end_with(end_with('n'))

      # Readability improved >= RSpec 3
      expect(fruits).to start_with(a_string_starting_with('a')) & include(a_string_matching(/a.a.a/)) & end_with(a_string_ending_with('n'))

      array = [0, 2, 4]
      # Old version <=> RSpec 3
      expect(array).to start_with(be < 1) | end_with(be_within(2).of(6) & be_even)
      
      # Readability improved >= RSpec 3
      expect(array).to start_with(a_value = 2) | end_with(a_value_within(3).of(5))
    end

  end

end