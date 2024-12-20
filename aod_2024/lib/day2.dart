import 'package:aod_2024/day_base.dart';

enum CheckMode {
  decr,
  incr;

  static CheckMode fromChange(int change) => change > 0 ? decr : incr;
}

extension UnsafeExtension on int {
  bool isUnsafe(CheckMode mode) {
    return (mode == CheckMode.decr ? this > 3 : this < -3) || this == 0;
  }
}

class Day2 extends AdventOfCode {
  Day2() : super(day: 2);

  @override
  void runDay() {
    print("\n------ DAY 2 -------");

    final data = getDataFromAssetFile('input_day2.txt');
    int saves = 0;

    for (String numberRow in data) {
      final List<int> numbers = numberRow.split(" ").map(int.parse).toList();
      saves += _checkSafety(numbers) ? 1 : 0;
    }
    print("Part1: $saves");

    saves = 0;
    for (String numberRow in data) {
      final List<int> numbers = numberRow.split(" ").map(int.parse).toList();
      saves += _checkSafetyWithTollerance(numbers) ? 1 : 0;
    }

    print("Part2: $saves");
  }

  bool _checkSafety(List<int> numbers) {
    CheckMode? checkMode;

    for (int i = 0; i + 1 < numbers.length; i++) {
      final lf = numbers.elementAt(i);
      final rh = numbers.elementAt(i + 1);

      final change = lf - rh;
      final currentCheckMode = CheckMode.fromChange(change);

      if (checkMode == null) {
        checkMode = currentCheckMode;
      } else {
        if (currentCheckMode != checkMode) {
          return false;
        }
      }

      if (change.isUnsafe(currentCheckMode)) {
        return false;
      }
    }
    return true;
  }

  bool _checkSafetyWithTollerance(List<int> numbers) {
    CheckMode? checkMode;
    int tollerance = 2;

    for (int i = 0; i + 1 < numbers.length; i++) {
      int lh = 0;
      int rh = 0;

      if (tollerance == 1) {
        lh = numbers.elementAt(i - 1);
        rh = numbers.elementAt(i + 1);
        tollerance--;
      } else {
        lh = numbers.elementAt(i);
        rh = numbers.elementAt(i + 1);
      }

      final change = lh - rh;
      final currentCheckMode = CheckMode.fromChange(change);

      if (checkMode == null) {
        checkMode = currentCheckMode;
      } else {
        if (currentCheckMode != checkMode) {
          tollerance--;
        }
      }

      if (change.isUnsafe(currentCheckMode)) {
        tollerance--;
      }
    }
    return tollerance < 0 ? false : true;
  }
}
