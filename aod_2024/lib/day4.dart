import 'package:aod_2024/day_base.dart';
import 'package:aod_2024/utils/dircetions.dart';

class Day4 extends AdventOfCode {
  Day4() : super(day: 4);

  final String xmas = "XMAS";

  @override
  void runDay() {
    print("\n------ DAY 4 -------");

    final testData = getDataFromAssetFile('input_day4.txt');

    int result = 0;

    for (int y = 0; y < testData.length; y++) {
      for (int x = 0; x < testData[y].length; x++) {
        if (testData[y][x] == xmas[0]) {
          result += countMatches(testData, x, y, Direction.horizontalRight);
          result += countMatches(testData, x, y, Direction.horizontalLeft);
          result += countMatches(testData, x, y, Direction.verticalDown);
          result += countMatches(testData, x, y, Direction.verticalUp);
          result += countMatches(testData, x, y, Direction.diagonalDownRight);
          result += countMatches(testData, x, y, Direction.diagonalUpRight);
          result += countMatches(testData, x, y, Direction.diagonalDownLeft);
          result += countMatches(testData, x, y, Direction.diagonalUpLeft);
        }
      }
    }
    print("Part1: $result");

    result = 0;
    final entryPoint = "A";
    List<List<String>> patterns = [
      ["M", "S", "M", "S"],
      ["M", "M", "S", "S"],
      ["S", "M", "S", "M"],
      ["S", "S", "M", "M"]
    ];

    for (int y = 0; y < testData.length; y++) {
      for (int x = 0; x < testData[y].length; x++) {
        if (testData[y][x] == entryPoint) {
          for (final pattern in patterns) {
            if (matchesPattern(testData, x, y, pattern)) {
              result++;
            }
          }
        }
      }
    }
    print("Part2: $result");
  }

  bool matchesPattern(List<String> data, int startX, int startY, List<String> pattern) {
    List<Direction> directions = [Direction.diagonalUpLeft, Direction.diagonalUpRight, Direction.diagonalDownLeft, Direction.diagonalDownRight];

    for (int i = 0; i < directions.length; i++) {
      if (!searchKey(data, startX, startY, directions[i], pattern[i])) {
        return false;
      }
    }
    return true;
  }

  bool searchKey(List<String> data, int startX, int startY, Direction direction, String key) {
    int x = startX + 1 * direction.x;
    int y = startY + 1 * direction.y;
    if (x < 0 || y < 0 || x >= data[0].length || y >= data.length || data[y][x] != key) return false;
    return true;
  }

  int countMatches(List<String> data, int startX, int startY, Direction direction) {
    for (int i = 0; i < xmas.length; i++) {
      int x = startX + i * direction.x;
      int y = startY + i * direction.y;
      if (x < 0 || y < 0 || x >= data[0].length || y >= data.length || data[y][x] != xmas[i]) return 0;
    }
    return 1;
  }
}
