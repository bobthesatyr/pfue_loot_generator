require_relative 'dice_roller.rb'

class LootGenerator
  include DiceRoller

  def initialize(treasure_level, gain_speed, creature_type, budget_modifier)


  end

  def load_data(file_name)
    data_root = File.dirname(__FILE__) + '/../data'

  end
end