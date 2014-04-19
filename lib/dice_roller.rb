module DiceRoller

  # takes input as a string
  # string should be in format of (number)d(number)x(multiplier)+(number)
  def roll_any(dice_string)
    roll_total = 0
    roll_set = dice_string.split('+')
    roll_set.each do |roll|
      dice = roll.match(/(?<die_number>\d+)d(?<die_size>\d+)x?(?<multiple>\d*)?/m)
      if dice
        mini_total = 0
        dice[:die_number].to_i.times do
          mini_total = mini_total + Random.rand(1..dice[:die_size].to_i)
        end
        mini_total = mini_total * dice[:multiple].to_i unless dice[:multiple].empty?
        roll_total = roll_total + mini_total
      else
        roll_total = roll_total + roll.to_i
      end
    end
    roll_total
  end

end