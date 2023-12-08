var instructions = readline().split("").map((x) => x === 'L' ? 0 : 1);readline();

var network = {};
var starting_nodes = [];

while (true) {
	var node = readline(); if (node === null) break;
	var source = node.split(' ')[0];
	var destination = node.substring(node.indexOf("(") + 1, node.lastIndexOf(")")).split(',').map((el) => el.trim());
	network[source] = destination;
	if (source[2] === 'A') {
		starting_nodes.push(source);
	}
}

function calculateWalk(position) {
	for (var walk = 0; position[2] != 'Z';) {
		instructions.forEach((instruction) => {
			walk++;
			position = network[position][instruction];
			if (position[2] === 'Z') {
				 return;
			}
		});
	}
	return walk;
}

function gcd(a, b)
{
	return !b ? a : gcd(b, a % b);
}

var partTwo = 1;

starting_nodes.forEach((current_node) => {
	walk = calculateWalk(current_node);
	partTwo = partTwo * (walk / (!walk ? partTwo : gcd(walk, partTwo % walk)));
});

console.log('Part one: ' + calculateWalk('AAA'))
console.log('Part two: ' + partTwo);