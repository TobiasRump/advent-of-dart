import 'package:aod_2024/day_base.dart';

class Day7 extends AdventOfCode {
  Day7() : super(day: 7);

  @override
  void runDay() {
    print("\n------ DAY 7 -------");
    final List<String> testData = getDataFromAssetFile('input_day7.txt');
    final extractedData = extractDataFromInput(testData);
    int result = 0;

    for (final data in extractedData) {
      final equationsLength = data.equations.length - 1;
      final variants = generateOperatorVariants(Operator.availableOperatorsP1, equationsLength);

      for (final operations in variants) {
        int? value;

        for (int i = 0; i < equationsLength; i++) {
          value ??= data.equations[i];

          if (i + 1 == data.equations.length) {
            value = operations[i].operate(value, data.equations[i]);
          } else {
            value = operations[i].operate(value, data.equations[i + 1]);
          }
        }
        if (data.testValue == value && value != null) {
          result += value;
          break;
        }
      }
    }
    print("Part1: $result");

    result = 0;

    for (final data in extractedData) {
      final equationsLength = data.equations.length - 1;
      final variants = generateOperatorVariants(Operator.availableOperatorsP2, equationsLength);

      for (final operations in variants) {
        int? value;

        for (int i = 0; i < equationsLength; i++) {
          value ??= data.equations[i];

          if (i + 1 == data.equations.length) {
            value = operations[i].operate(value, data.equations[i]);
          } else {
            value = operations[i].operate(value, data.equations[i + 1]);
          }
        }
        if (data.testValue == value && value != null) {
          result += value;
          break;
        }
      }
    }
    print("Part2: $result");
  }

  List<List<Operator>> generateOperatorVariants(List<List<Operator>> operators, int length) {
    if (length == 1) {
      return operators;
    }

    List<List<Operator>> variants = operators;

    for (int i = 2; i <= length; i++) {
      List<List<Operator>> newVariants = [];
      for (var v in variants) {
        for (var o in operators) {
          newVariants.add([...v, ...o]);
        }
      }
      variants = newVariants;
    }

    return variants;
  }

  List<Day7Input> extractDataFromInput(List<String> data) {
    List<Day7Input> inputs = [];
    for (final dataLine in data) {
      final splittedLine = dataLine.split(":");
      final testValue = int.parse(splittedLine.first);
      final equations = splittedLine.last.split(" ").skip(1).map(int.parse).toList();
      inputs.add((testValue: testValue, equations: equations));
    }
    return inputs;
  }
}

typedef Day7Input = ({int testValue, List<int> equations});

enum Operator {
  add,
  multi,
  concat;

  static List<List<Operator>> get availableOperatorsP1 => [
        [add],
        [multi],
      ];

  static List<List<Operator>> get availableOperatorsP2 => [
        [add],
        [multi],
        [concat],
      ];

  int operate(int lh, int rh) {
    switch (this) {
      case add:
        return lh + rh;
      case multi:
        return lh * rh;
      case concat:
        return int.parse("$lh$rh");
    }
  }
}
