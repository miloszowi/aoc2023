import 'dart:io';
import 'dart:core';
import 'dart:collection';

void main() {
	Map<int, List<List<String>>> hands = {1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 0: []};
	Map<String, String> translate = {
		'A': 'n', 'K': 'm', 'Q': 'l',
		'J': 'k', 'T': 'j', '9': 'i',
		'8': 'h', '7': 'g', '6': 'f',
		'5': 'e', '4': 'd', '3': 'c',
		'2': 'b', 'J': 'a'
	};
	int rank = 0;
	while (true) {
	    var line = stdin.readLineSync();
	    if (null == line) break;
	    rank += 1;
	    var hand = line.split(' ');
    	hand[0] = hand[0].split('').map((val) => translate[val]).toList().join('');
    	var splittedHand = hand[0].split('');
		var power = powerOfHand(splittedHand);

    	hands[power].add(hand);
	}
	int partTwo = 0;
	var handsSorted = Map.fromEntries(
	    hands.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));

	handsSorted.forEach((k, cards) {
		cards.sort((a, b) => a[0].compareTo(b[0]));
		cards.reversed.forEach((current) {
			partTwo += (int.parse(current[1]) * rank);
			rank -= 1;
		});
	});

	print(partTwo);
}

int powerOfHand(List hand)
{
	var counts = Map();
	hand.forEach((x) => counts[x] = !counts.containsKey(x) ? (1) : (counts[x] + 1));
	var mapEntries = counts.entries.toList();
	mapEntries.sort((a, b) => b.value.compareTo(a.value));
	var sortedCounts = Map.fromEntries(mapEntries);
	var sorted = (counts.values.toList()..sort()).reversed.toList();

	if (hand.contains('a')) {
		if (sortedCounts.keys.first == 'a' && sorted.length != 1) {
			sorted[0] = sorted[1] + sorted[0];
		} else {
			sorted[0] += counts['a'];
		}
	}
	if (sorted[0] > 5) {
		sorted[0] = 5;
	}

	if (sorted[0] == 5){
		return 6;
	} else if (sorted[0] == 4) {
		return 5;
	} else if (sorted[0] == 3 && sorted[1] == 2) {
		return 4;
	} else if (sorted[0] == 3) {
		return 3;
	} else if (sorted[0] == 2 && sorted[1] == 2) {
		return 2;
	} else if (sorted[0] == 2) {
		return 1;
	}

	return 0;
}
