require 'car'

describe 'Car' do
  describe 'attributes' do
    # use "subject" instead of "let"
    # if variable of is subject of example
    subject { Car.new }

    # let(:car) { Car.new }
    # lazy-execution and memoization
    # "let" is better than "before"

    # before(:example) do
    #   car = Car.new
    # end

    # put 'x' befor 'it' => 'xit' in order to skip the test
    it 'allows reading and writing for :make' do
      # just write 'skip' at the first line of the method to skip the test
      # or skip('Reason - message')
      subject.make = 'Test'
      expect(subject.make).to eq('Test')
    end

    it 'allows reading and writing for :year' do
      subject.year = 9999
      expect(subject.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      subject.color = 'Gogo'
      expect(subject.color).to eq('Gogo')
    end

    it 'allows reading for :wheels' do
      expect(subject.wheels).to eq(4)
    end

    it 'allows writing for :doors'
  end

  describe '.colors' do
    let(:colors) { %w[blue black red green] }
    it 'returns an array of colors' do
      expect(Car.colors).to match_array(colors)
    end
  end

  describe '#full_name' do
    let(:my_bach) { Car.new(make: 'Mybach', year: 2019, color: 'black') }
    it 'returns string in expected format' do
      expect(my_bach.full_name).to eq('2019 Mybach (black)')
    end

    context 'when initialized without arguments' do
      let(:car) { Car.new }
      it 'return string using default value' do
        expect(car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end
end