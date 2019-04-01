require 'truck'
require 'shared_examples/a_standard_vehicle'

describe Truck do

  it_behaves_like('a standard vehicle')

  describe '.color' do
    let(:colors) { %w[blue black red green yellow] }
    it 'return an array of colors' do
      expect(Truck.colors).to match_array(colors)
    end
  end

  describe '.full_name' do
    let(:my_car) { Truck.new(make: 'Mitsubishi', year: 2019, color: 'yellow') }
    it 'will return a string in expected format' do
      expect(my_car.full_name).to eq('2019 Mitsubishi Truck (yellow)')
    end

    context 'when initialized without arguments' do
      let(:truck) { Truck.new }
      it 'will return a string in default format' do
        expect(truck.full_name).to eq('2007 Ford Truck (unknown)')
      end
    end
  end
end