class Die
  attr_reader :num_sides

  def initialize(num_sides)
    @num_sides = num_sides
  end

  def roll(modifier=0)
    die_roll + modifier
  end

  private

  def die_roll
    rand(1..num_sides)
  end
end
