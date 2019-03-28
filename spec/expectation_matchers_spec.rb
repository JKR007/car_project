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

      expect { raise StandardError }.to raise_error
      expect { raise StandardError }.to raise_exception

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

end