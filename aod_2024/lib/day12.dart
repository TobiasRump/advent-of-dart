import 'dart:math';

import 'package:aod_2024/day_base.dart';

class Day12 extends AdventOfCode {
  Day12() : super(day: 12);

  @override
  void runDay() async {
    print("\n------ DAY 12 -------");

    final List<String> garden = getDataFromAssetFile('input_day12.txt');

    int result = 0;
    garden.forEach(print);

    Map<Point, bool> seen = {};
    final yMax = garden.length;
    final xMax = garden.first.length;
    int maxPositions = yMax * xMax;
    while (maxPositions != seen.keys.length) {}

    print("Part1 $result");
    print("Part2 $result");
  }
}
