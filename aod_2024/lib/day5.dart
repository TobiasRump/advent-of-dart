import 'package:aod_2024/day_base.dart';

class Day5 extends AdventOfCode {
  Day5() : super(day: 5);

  final String xmas = "XMAS";

  @override
  void runDay() {
    print("\n------ DAY 5 -------");

    final List<String> testData = getDataFromAssetFile('input_day5.txt');
    final Day5Input extractedData = extractData(testData);

    int result = 0;
    final incorrectDataUpdates = [];

    for (final update in extractedData.pageUpdates) {
      if (isValidPage(update, extractedData.pageRules)) {
        result += update.elementAt((update.length / 2).floor());
      } else {
        incorrectDataUpdates.add(update);
      }
    }

    print("Part1: $result");

    result = 0;

    for (final update in incorrectDataUpdates) {
      List<int> tempUpdate = [...update];
      for (int currentPageIdx = tempUpdate.length; currentPageIdx > 0; currentPageIdx--) {
        int checkIdx = tempUpdate.length - currentPageIdx;
        while (checkIdx < update.length - 1) {
          final currentRule = PageRule(srcPage: tempUpdate[checkIdx], nextPage: tempUpdate[checkIdx + 1]);
          if (!extractedData.pageRules.contains(currentRule)) {
            final removedItem = tempUpdate.removeAt(checkIdx);
            tempUpdate = [...tempUpdate, removedItem];
            checkIdx = 0;
            continue;
          }
          checkIdx++;
        }
      }
      result += tempUpdate.elementAt((update.length / 2).floor());
    }

    print("Part2: $result");
  }

  Day5Input extractData(List<String> data) {
    List<PageRule> pageRules = [];
    List<List<int>> updates = [];
    for (final data in data) {
      if (data == "") continue;

      if (data.contains("|")) {
        final splitData = data.split('|');
        pageRules.add(PageRule(srcPage: int.parse(splitData.first), nextPage: int.parse(splitData.last)));
      }

      if (data.contains(",")) {
        updates.add(data.split(',').map(int.parse).toList());
      }
    }
    return (pageRules: pageRules, pageUpdates: updates);
  }

  bool isValidPage(List<int> pages, List<PageRule> validPages) {
    for (int i = 0; i < pages.length - 1; i++) {
      final rule = PageRule(srcPage: pages[i], nextPage: pages[i + 1]);
      if (!validPages.contains(rule)) {
        return false;
      }
    }
    return true;
  }
}

typedef Day5Input = ({List<PageRule> pageRules, List<List<int>> pageUpdates});

class PageRule {
  final int srcPage;
  final int nextPage;

  PageRule({
    required this.srcPage,
    required this.nextPage,
  });

  @override
  String toString() {
    return "$srcPage|$nextPage";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageRule && other.srcPage == srcPage && other.nextPage == nextPage;
  }

  @override
  int get hashCode => srcPage.hashCode ^ nextPage.hashCode;
}
