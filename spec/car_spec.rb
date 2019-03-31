require 'car'

describe 'Car' do
  describe 'attributes' do

    before(:example) do
      @car = Car.new
    end

    # put 'x' befor 'it' => 'xit' in order to skip the test
    it 'allows reading and writing for :make' do
      # just write 'skip' at the first line of the method to skip the test
      # or skip('Reason - message')
      @car.make = 'Test'
      expect(@car.make).to eq('Test')
    end

    it 'allows reading and writing for :year' do
      @car.year = 9999
      expect(@car.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      @car.color = 'Gogo'
      expect(@car.color).to eq('Gogo')
    end

    it 'allows reading for :wheels' do
      expect(@car.wheels).to eq(4)
    end

    it 'allows writing for :doors'
  end

  describe '.colors' do
    it 'returns an array of colors' do
      colors = %w[blue black red green]
      expect(Car.colors).to match_array(colors)
    end
  end

  describe '#full_name' do
    it 'returns string in expected format' do
      my_bach = Car.new(make: 'Mybach', year: 2019, color: 'black')
      expect(my_bach.full_name).to eq('2019 Mybach (black)')
    end

    context 'when initialized without arguments' do
      it 'return string using default value' do
        car = Car.new
        expect(car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end
end