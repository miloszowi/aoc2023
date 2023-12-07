import os
import re
import collections
from typing import List

maps = collections.defaultdict(list)

with open('{}/sample.txt'.format(os.path.dirname(__file__)), 'r') as f:
    seeds = [int(x) for x in re.findall(r'\d+', f.readline())]

    for line in filter(lambda x: x != "\n", f.readlines()):
        if 'map:' in line:
            c = line.split(':')[0]
            continue

        maps[c].append(re.findall(r'\d+', line))

def solve(given_seeds: List[int]) -> int:
    _min = 99999992137999999999999

    for seed in given_seeds:
        _min = min(_min, solve_for_seed(seed))

    return _min

def solve_for_seed(seed: int) -> int:
    for values in maps:
        for seed_set in maps[values]:
            destination, source, _range = [int(x) for x in seed_set]

            if seed in range(source, source + _range):
                seed = destination + (seed - source)
                break

    return seed

def solve_for_location(location: int) -> int:
    for values in dict(reversed(list(maps.items()))):
        for seed_set in maps[values]:
            source, destination, _range = [int(x) for x in seed_set]

            if location in range(source, source + _range):
                location = destination + (location - source)
                break

    return location

print(f"Part one: {solve(seeds)}")

seed_ranges = [range(seeds[i], seeds[i] + seeds[i + 1]) for i in range(0, len(seeds), 2)]

location = 0
while True:
    location += 1
    current_seed = solve_for_location(location)
    for _seed_range in seed_ranges:
        if current_seed in _seed_range:
            print(f"Part two: {location}")
            exit()
