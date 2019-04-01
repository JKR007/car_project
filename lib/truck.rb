class Truck

  attr_accessor :make, :year, :color
  attr_reader :wheels
  attr_writer :doors

  def initialize(options={})
    self.make = options[:make] || 'Ford'
    self.year = (options[:year] || 2007).to_i
    self.color = options[:color] || 'unknown'
    @wheels = 4
  end

  def self.colors
    %w[blue black red green yellow]
  end

  def full_name
    "#{self.year} #{self.make} Truck (#{self.color})"
  end

end
