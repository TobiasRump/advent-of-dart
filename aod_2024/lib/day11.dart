import 'package:aod_2024/day_base.dart';

class Day11 extends AdventOfCode {
  Day11() : super(day: 11);

  @override
  void runDay() async {
    print("\n------ DAY 11 -------");

    final List<String> testData = getDataFromAssetFile('input_day11.txt');
    final List<int> stones = _extractCardDataFrom(testData);

    int result = 0;
    result = getStonesLen(stones, 25);

    print("Part1 $result");

    result = 0;
    result = getStonesLen(stones, 75);

    print("Part2 $result");
  }

  int getStonesLen(List<int> input, int blinks) {
    Map<int, int> cacheMap = {};
    for (var number in input) {
      cacheMap[number] = 1;
    }

    for (int i = 0; i < blinks; i++) {
      Map<int, int> cachedMapCpy = Map.from(cacheMap);
      for (var key in cacheMap.keys) {
        if (cacheMap[key]! > 0) {
          int num = cacheMap[key]!;
          cachedMapCpy[key] = cachedMapCpy[key]! - num;
          List<int> res = _calcStoneList([key]);
          for (var val in res) {
            cachedMapCpy[val] = (cachedMapCpy[val] ?? 0) + num;
          }
        }
      }
      cacheMap = Map.from(cachedMapCpy);
    }
    return cacheMap.values.reduce((a, b) => a + b);
  }

  List<int> _calcStoneList(List<int> lst) {
    List<int> res = [];
    for (var num in lst) {
      final numStr = num.toString();
      if (num == 0) {
        res.add(1);
      } else if (numStr.length.isEven) {
        int length = numStr.length;
        final left = numStr.substring(0, length ~/ 2);
        final right = numStr.substring(length ~/ 2);
        res.addAll([int.parse(left), int.parse(right)]);
      } else {
        res.add(num * 2024);
      }
    }
    return res;
  }

  List<int> _extractCardDataFrom(List<String> testData) {
    return testData.first.split(' ').map(int.parse).toList();
  }
}
