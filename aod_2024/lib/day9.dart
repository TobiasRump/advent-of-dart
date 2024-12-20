import 'package:aod_2024/day_base.dart';

class Day9 extends AdventOfCode {
  Day9() : super(day: 9);

  @override
  void runDay() {
    print("\n------ DAY 9 -------");
    print("Calculating...");

    final List<String> testData = getDataFromAssetFile('input_day9.txt');

    int result = 0;

    List<String> disk = [];

    final splittedNumber = testData.first.split("").map(int.parse).toList();
    int count = 0;
    for (int i = 0; i < splittedNumber.length; i++) {
      if (i.isOdd) {
        for (int a = 0; a < splittedNumber[i]; a++) {
          disk.add(".");
        }
      } else {
        for (int a = 0; a < splittedNumber[i]; a++) {
          disk.add("$count");
        }
        count++;
      }
    }
    int reversedIndex = disk.length - 1;
    for (int index = 0; index < disk.length; index++) {
      if (isValidList(disk)) {
        break;
      }

      if (disk[index] == ".") {
        bool hasNumberFound = false;
        reversedIndex = disk.length - 1;

        while (!hasNumberFound) {
          final char = disk[reversedIndex];
          if (char != ".") {
            hasNumberFound = true;
            disk[index] = disk[reversedIndex];
            disk[reversedIndex] = ".";
          } else {
            reversedIndex--;
          }
        }
      }
    }

    for (int i = 0; i < disk.length; i++) {
      if (disk[i] != ".") {
        result += (int.parse(disk[i]) * i);
      }
    }

    print("Part1: $result");

    result = 0;
    print("Part2: $result");
  }

  bool isValidList(List<String> numberList) {
    //28
    int splitIndex = numberList.indexWhere((element) => element == '.');
    bool numbersAreValid = numberList.sublist(0, splitIndex).every((element) => element != ".");
    bool dotsAreValid = numberList.sublist(splitIndex).every((element) => element == '.');

    return numbersAreValid && dotsAreValid;
  }
}
