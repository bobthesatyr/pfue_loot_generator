require_relative '../lib/dice_roller.rb'
include DiceRoller

describe DiceRoller do
  it 'should be able to roll a single die.' do
    expect((1..2).to_a.include?(roll_any('d2'))).to eq(true)
    expect((1..4).to_a.include?(roll_any('d4'))).to eq(true)
    expect((1..6).to_a.include?(roll_any('d6'))).to eq(true)
    expect((1..8).to_a.include?(roll_any('d8'))).to eq(true)
    expect((1..10).to_a.include?(roll_any('d10'))).to eq(true)
    expect((1..12).to_a.include?(roll_any('d12'))).to eq(true)
    expect((1..20).to_a.include?(roll_any('d20'))).to eq(true)
    expect((1..100).to_a.include?(roll_any('d100'))).to eq(true)
  end
  it 'should be able to roll a multiple die.' do
    expect((2..4).to_a.include?(roll_any('2d2'))).to eq(true)
    expect((4..16).to_a.include?(roll_any('4d4'))).to eq(true)
    expect((6..36).to_a.include?(roll_any('6d6'))).to eq(true)
    expect((8..64).to_a.include?(roll_any('8d8'))).to eq(true)
    expect((10..100).to_a.include?(roll_any('10d10'))).to eq(true)
    expect((12..144).to_a.include?(roll_any('12d12'))).to eq(true)
    expect((20..400).to_a.include?(roll_any('20d20'))).to eq(true)
    expect((100..10000).to_a.include?(roll_any('100d100'))).to eq(true)
  end
  it 'should be able to multiply the roll of a die.' do
    expect([2,4].include?(roll_any('d2x2'))).to eq(true)
    expect([4,8,12,16].include?(roll_any('d4x4'))).to eq(true)
    expect([6,12,18,24,30,36].include?(roll_any('d6x6'))).to eq(true)
  end
  it 'should be able to add a static number to a roll.' do
    expect((3..4).to_a.include?(roll_any('d2+2'))).to eq(true)
    expect((5..8).to_a.include?(roll_any('d4+4'))).to eq(true)
    expect((7..12).to_a.include?(roll_any('d6+6'))).to eq(true)
    expect((9..16).to_a.include?(roll_any('d8+8'))).to eq(true)
    expect((11..20).to_a.include?(roll_any('d10+10'))).to eq(true)
    expect((13..24).to_a.include?(roll_any('d12+12'))).to eq(true)
    expect((21..40).to_a.include?(roll_any('d20+20'))).to eq(true)
    expect((101..200).to_a.include?(roll_any('d100+100'))).to eq(true)
  end
  it 'should be able to interpret complex die rolls.' do
    expect((3..12).to_a.include?(roll_any('d2+d4+d6'))).to eq(true)
    expect((3..30).to_a.include?(roll_any('d8+d10+d12'))).to eq(true)
    expect((12..36).to_a.include?(roll_any('d20+d6+10'))).to eq(true)
    expect((20..72).to_a.include?(roll_any('6d8+2d6+12'))).to eq(true)
    expect([15,25].include?(roll_any('d2x10+5'))).to eq(true)
  end
end