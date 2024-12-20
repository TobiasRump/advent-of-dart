import 'package:aod_2024/day_base.dart';

class Day3 extends AdventOfCode {
  Day3() : super(day: 3);

  @override
  void runDay() {
    print("\n------ DAY 3 -------");

    final data = getDataFromAssetFile('input_day3.txt');

    final regexMulFilter = RegExp(r'mul\([0-9]{1,3},[0-9]{1,3}\)');
    final regexNumberFilter = RegExp(r'[0-9]{1,3},[0-9]{1,3}');

    int result = 0;
    for (final line in data) {
      for (final match in regexMulFilter.allMatches(line).toList()) {
        final currentMatches = regexNumberFilter.firstMatch(match[0] ?? "");
        final multNumbers = currentMatches![0]!.split(",");
        result += int.parse(multNumbers.first) * int.parse(multNumbers.last);
      }
    }

    print("Part1: $result");

    final regexMulInstrctionFilterFilter = RegExp(r"don't.*?(do\(\))|don't.*");

    result = 0;
    final dataCombined = data.join("");

    final modifiedLine = dataCombined.replaceAll(regexMulInstrctionFilterFilter, "");

    for (final match in regexMulFilter.allMatches(modifiedLine).toList()) {
      final currentMatches = regexNumberFilter.firstMatch(match[0] ?? "");
      final multNumbers = currentMatches![0]!.split(",");
      result += int.parse(multNumbers.first) * int.parse(multNumbers.last);
    }
    print("Part2: $result");
  }
}
