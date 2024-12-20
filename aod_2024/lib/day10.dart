import 'dart:collection';

import 'package:aod_2024/day_base.dart';
import 'package:aod_2024/utils/dircetions.dart';

class Day10 extends AdventOfCode {
  Day10() : super(day: 10);

  @override
  void runDay() {
    print("\n------ DAY 10 -------");

    final List<String> testData = getDataFromAssetFile('input_day10.txt');
    final List<List<int>> card = _extractCardDataFrom(testData);
    int result = 0;

    for (int y = 0; y < card.length; y++) {
      for (int x = 0; x < card[y].length; x++) {
        result += _getPaths(y, x, card);
      }
    }

    print("Part1 $result");
  }

  List<List<int>> _extractCardDataFrom(List<String> testData) {
    return testData.map((line) => line.split('').map(int.parse).toList()).toList();
  }

  int _getPaths(int y, int x, List<List<int>> card) {
    if (card[y][x] != 0) return 0;

    int xMax = card[y].length;
    int yMax = card.length;

    Queue<List<int>> q = Queue<List<int>>();
    Set<List<int>> alreadySeen = {};
    q.add([x, y]);

    int sum = 0;
    while (q.isNotEmpty) {
      List<int> currentCoords = q.removeFirst();
      final qx = currentCoords.first;
      final qy = currentCoords.last;

      int current = card[qy][qx];
      if (current != 0) return 0;

      if (alreadySeen.contains(currentCoords)) {
        continue;
      }
      if (current == 9) {
        sum++;
      }

      for (final direction in LazyDirection.values) {
        final dy = y + direction.y;
        final dx = x + direction.x;
        if (dy < yMax && dy >= 0 && dx < xMax && dx >= 0) {
          final next = card[y + direction.y][x + direction.x];
          alreadySeen.add([dx, dy]);
          if (next == current + 1) {
            q.add([dx, dy]);
          }
        }
      }
    }

    return sum;
  }
}
