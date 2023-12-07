partOne = 0
scratchcards = Hash.new

while a = gets
    digits = a.scan(/-?[0-9]*-?[0-9]/)
    card = digits[0].to_i
    cards = digits.drop(1).group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    multiplier = 1
	scratchcards[card] ||= 1

	multiplier = scratchcards[card] if scratchcards.key?(card)

    for i in card + 1..card+cards.length do
    	scratchcards[i] = if scratchcards.key?(i) then scratchcards[i] + multiplier else multiplier + 1 end
    end

    partOne += 2 ** (cards.length - 1) if cards.length > 0
end

puts "part one: #{partOne}"
puts "part two: #{scratchcards.values.sum}"
