<?php

$cords = [];
$numberCords = [];

$handle = fopen("sample.txt", "r");

function surroundings(int $x, int $y): array
{
    $result = [];
    foreach (range($x - 1, $x + 1) as $rx) {
        foreach (range($y - 1, $y + 1) as $ry) {
            if ($rx === $x && $ry === $y) continue;
            $result[] = [$rx, $ry];
        }
    }
    return $result;
}

while ($line = rtrim(fgets($handle), "\n")) {
    $cords[] = str_split($line);
    preg_match_all('/\d+/', $line, $rowDigits, PREG_OFFSET_CAPTURE);
    foreach ($rowDigits[0] as $digit) {
        $numberCords[] = [
            'digit' => $digit[0],
            'x' => $digit[1],
            'y' => array_key_last($cords)
        ];
    }
}
$partOne = 0;
$closeToGear = [];

foreach ($numberCords as $numberCord) {
    $number = $numberCord['digit'];
    [$x, $y] = [$numberCord['x'], $numberCord['y']];

    for ($cx = $x; $cx < $x + strlen((string)$number); $cx++) {
        foreach (surroundings($cx, $y) as $surrounding) {
            [$sx, $sy] = $surrounding;
            if (isset($cords[$sy][$sx]) && $cords[$sy][$sx] !== '.' && !is_numeric($cords[$sy][$sx])) {
                $partOne += $number;
                $closeToGear["{$sx}{$sy}"][] = $number;
                break 2;
            }
        }
    }
}

$partTwo = 0;

foreach ($closeToGear as $gear => $numbers) {
    if (sizeof($numbers) == 2) {
        $partTwo += $numbers[0] * $numbers[1];
    }
}
echo "Part 1: {$partOne}\n";
echo "Part 2: {$partTwo}\n";
