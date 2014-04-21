require_relative 'dice_roller.rb'

class LootGenerator
  include DiceRoller
  attr_accessor :treasure_value_by_level, :treasure_type_by_creature, :type_list

  def initialize
    self.treasure_value_by_level = load_data 'treasure_value_by_level'
    self.treasure_type_by_creature = load_data 'treasure_type_by_creature'
    self.type_list = {}
    self.type_list['A'] = load_data 'type_a_coins'
    self.type_list['B'] = load_data 'type_b_coins_and_gems'
    self.type_list['C'] = load_data 'type_c_art_objects'
    #self.type_list['D'] = load_data 'type_d_coins_and_small_objects'
    #self.type_list['E'] = load_data 'type_e_armor_and_weapons'
    #self.type_list['F'] = load_data 'type_f_combatant_gear'
    #self.type_list['G'] = load_data 'type_g_spellcaster_gear'
    #self.type_list['H'] = load_data 'type_h_lair_treasure'
    #self.type_list['I'] = load_data 'type_i_treasure_hoard'
  end

  def generate(treasure_level, gain_speed, creature_type, budget_modifier)
    budget = determine_budget(treasure_level, gain_speed, budget_modifier)
    list = determine_loot_list(creature_type, budget)
    loot = []
    generate_gp(loot, list[:gp]) if list[:gp]
    #generate_gemstones(loot, list[:gemstones]) if list[:gemstones]
    #generate_art(loot, list[:art]) if list[:art]
    #generate_potions(loot, list[:potions]) if list[:potions]
    #generate_scroll(loot, list[:scroll]) if list[:scroll]
    #generate_wand(loot, list[:wand]) if list[:wand]
    #generate_armor(loot, list[:armor]) if list[:armor]
    #generate_weapon(loot, list[:weapon]) if list[:weapon]
    #generate_wondrous(loot, list[:wondrous]) if list[:wondrous]
    #generate_ring(loot, list[:ring]) if list[:ring]
    #generate_rod(loot, list[:rod]) if list[:rod]
    #generate_staff(loot, list[:staff]) if list[:staff]
    loot
  end

  def determine_budget(level, speed, modifier)
    treasure_modifiers = {'incidental' => 0.5, 'standard' => 1, 'double' => 2, 'triple' => 3}
    treasure_value_by_level[speed][level]*treasure_modifiers[modifier]
  end

  def determine_loot_list(creature_type, budget)
    type_array = treasure_type_by_creature[creature_type].dup
    loot_list = {}
    while budget>0 && !type_array.empty? do
      type = type_array[roll_any("d#{type_array.size}")]
      type_array.delete(type)
      type_list[type].each do |price, items|
        if price <= budget
          items.each do |treasure_type, specifics|
            loot_list[treasure_type] ? loot_list[treasure_type] = loot_list[treasure_type] + specifics : loot_list[treasure_type] = specifics
          end
          budget = budget - price
          break
        end
      end
    end
  end

  def grab_percentile_item(list_hash)
    roll = roll_any('d100')
    list_hash.each do |key, item|
      if roll <= key
        return item
      end
    end
  end

  def uncommon_check
    roll_any('d100') > 75 ? 'uncommon' : 'common'
  end

  def generate_gp(loot, list)
    types = {:cp => 0, :sp => 0, :gp => 0, :pp => 0}
    list.each do |amount|
      treasure = amount.split(':')
      types[treasure[0].intern] = types[treasure[0].intern] + roll_any(treasure[1])
    end
    loot << "#{types[:cp]} Copper, #{types[:sp]} Silver, #{types[:gp]} Gold, and #{types[:pp]} Platinum"
  end

  def load_data(file_name)
    data_root = File.dirname(__FILE__) + '/../data/'
    YAML::load_file(File.open(data_root + file_name + '.yaml'))
  end
end