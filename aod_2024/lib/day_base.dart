import 'dart:io';

import 'package:path/path.dart' as p;

abstract class AdventOfCode with TestDataLoader {
  final int day;

  AdventOfCode({
    required this.day,
  });
  void runDay();
}

mixin TestDataLoader {
  List<String> getDataFromAssetFile(String filename) {
    final filePath = p.join(Directory.current.path, 'assets', filename);
    final file = File(filePath);

    try {
      final data = file.readAsLinesSync();
      return data;
    } catch (e) {
      print("[ERROR] to read file  $filename in ${Directory.current.path}/assets");
      return [];
    }
  }
}
