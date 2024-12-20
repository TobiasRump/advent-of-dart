import 'package:aod_2024/days.dart';

void main(List<String> arguments) {
  final days = [Day1(), Day2(), Day3(), Day4(), Day5(), Day6(), Day7(), Day9(), Day10(), Day11(), Day12()];

  for (var day in days) {
    if (day.day == 12) {
      day.runDay();
    }
  }
}
