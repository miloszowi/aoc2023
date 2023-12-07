import 'dart:io';
import 'dart:core';
import 'dart:collection';

void main() {
	Map<int, List<List<String>>> hands = {1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 0: []};
	Map<String, String> translate = {
		'A': 'm', 'K': 'l', 'Q': 'k',
		'J': 'j', 'T': 'i', '9': 'h',
		'8': 'g', '7': 'f', '6': 'e',
		'5': 'd', '4': 'c', '3': 'b',
		'2': 'a'
	};
	int rank = 0;
	while (true) {
	    var line = stdin.readLineSync();
	    if (null == line) break;
	    rank += 1;
	    var hand = line.split(' ');
    	hand[0] = hand[0].split('').map((val) => translate[val]).toList().join('');
	    var power = powerOfHand(hand[0].split(''));

    	hands[power].add(hand);
	}
	int partOne = 0;
	var handsSorted = Map.fromEntries(
	    hands.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));

	handsSorted.forEach((k, cards) {
		cards.sort((a, b) => a[0].compareTo(b[0]));
		cards.reversed.forEach((current) {
			partOne += (int.parse(current[1]) * rank);
			rank -= 1;
		});
	});

	print(partOne);
}

int powerOfHand(List hand)
{
	var counts = Map();
	hand.forEach((x) => counts[x] = !counts.containsKey(x) ? (1) : (counts[x] + 1));
	var sorted = (counts.values.toList()..sort()).reversed.toList();

	if (sorted.length == 1){
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
