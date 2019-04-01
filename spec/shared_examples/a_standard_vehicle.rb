shared_examples_for('a standard vehicle') do

  describe 'attributes' do
    # do not need to defince subject {  } explicitly
    # if we use a #className after #describe

    # use "subject" instead of "let"
    # if variable of is subject of example
    # subject { Car.new }

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

end