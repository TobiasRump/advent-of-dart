import 'dart:math';

import 'package:aod_2024/day_base.dart';
import 'package:aod_2024/utils/dircetions.dart';

class Day6 extends AdventOfCode {
  Day6() : super(day: 6);

  final player = "^";
  final obstacle = "#";
  final wayMarker = "X";

  @override
  void runDay() {
    print("\n------ DAY 6 -------");

    final List<String> testData = getDataFromAssetFile('input_day6.txt');
    int result = 0;
    final startDirection = LazyDirection.verticalUp;
    final startPosition = getPlayerStartPosition(testData);
    print(startPosition);

    result = 0;

    bool isInMap = true;
    Point<int> currentPos = startPosition;
    LazyDirection currentDirection = startDirection;
    List<String> tempMap = [...testData];

    while (isInMap) {
      final Point<int> nextPos = getNextPointFromDirection(currentPos, currentDirection);

      if (isNextPointNotInRange(nextPos, testData.first.length - 1, testData.length - 1)) {
        tempMap[currentPos.y] = replaceCharAt(tempMap[currentPos.y], currentPos.x, wayMarker);
        result++;
        break;
      }

      if (tempMap[nextPos.y][nextPos.x] == obstacle) {
        currentDirection = currentDirection.next();
      } else {
        if (!(tempMap[nextPos.y][nextPos.x] == wayMarker)) {
          result++;
        }
        tempMap[currentPos.y] = replaceCharAt(tempMap[currentPos.y], currentPos.x, wayMarker);
        tempMap[nextPos.y] = replaceCharAt(tempMap[nextPos.y], nextPos.x, player);

        currentPos = nextPos;
      }
    }
    print("Part1: $result");
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  getPlayerStartPosition(List<String> map) {
    for (final row in map) {
      if (row.contains(player)) {
        return Point(row.indexOf(player), map.indexOf(row));
      }
    }
  }

  Point<int> getNextPointFromDirection(Point<int> currentPos, LazyDirection currentDirection) {
    final nextX = currentPos.x + (currentDirection.x);
    final nextY = currentPos.y + (currentDirection.y);

    return Point<int>(nextX, nextY);
  }

  bool isNextPointNotInRange(Point<int> nextPos, int maxX, int maxY) {
    return nextPos.x < 0 || nextPos.x > maxX || nextPos.y < 0 || nextPos.y > maxY;
  }
}
