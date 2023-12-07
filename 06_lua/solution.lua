function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

time_input = io.read("*l")
distance_input = io.read("*l")
joined_time = time_input:gsub("%D+", "")
joined_distance = distance_input:gsub("%D+", "")

times = split(time_input:gsub("%D+", " "):sub(2), ' ')
distances = split(distance_input:gsub("%D+", " "):sub(2), ' ')

beat_combinations = {}
partOne = 1
partTwo = 0

for i=1, #times, 1 do
	local _time, distance = tonumber(times[i]), tonumber(distances[i])
	beat_combinations[i] = 0

	for hold=1, _time - 1, 1 do
		time_travelled = tonumber(hold * (_time - hold))
		if (time_travelled > distance) then
			beat_combinations[i] = beat_combinations[i] + 1
		end
	end

	partOne = partOne * beat_combinations[i]
end

for hold=14, joined_time - 1, 1 do
	time_travelled = tonumber(hold * (joined_time - hold))
	if (time_travelled > tonumber(joined_distance)) then
		partTwo = partTwo + 1
	end
end

print(partOne)
print(partTwo)
