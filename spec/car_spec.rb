require 'car'
require 'shared_examples/a_standard_vehicle'

describe Car do

  it_behaves_like('a standard vehicle')

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