import 'package:aod_2024/day_base.dart';

class Day1 extends AdventOfCode {
  Day1() : super(day: 1);

  @override
  void runDay() {
    print("------ DAY 1 -------");

    int result = 0;

    final data = getDataFromAssetFile('input_day1.txt');
    final lists = _extractListsFromData(data);

    for (int i = 0; i < lists.leftList.length; i++) {
      result += (lists.leftList.elementAt(i) - lists.rightList.elementAt(i)).abs();
    }
    print("Part 1: $result");

    int result2 = 0;

    for (int i = 0; i < lists.leftList.length; i++) {
      final currentItem = lists.leftList.elementAt(i);
      final exp = _getEqualAmounts(currentItem, lists.rightList);
      result2 += (currentItem * exp);
    }

    print("Part 2: $result2");
  }

  int _getEqualAmounts(int currentNumber, List<int> destList) {
    int result = 0;
    for (int item in destList) {
      if (item == currentNumber) result++;
    }

    return result;
  }

  Day1Input _extractListsFromData(List<String> data) {
    final leftList = <int>[];
    final rightList = <int>[];

    for (String line in data) {
      final splittedData = line.split(" ");
      leftList.add(int.parse(splittedData.first));
      rightList.add(int.parse(splittedData.last));
    }

    leftList.sort();
    rightList.sort();

    return (leftList: leftList, rightList: rightList);
  }
}

typedef Day1Input = ({List<int> leftList, List<int> rightList});
