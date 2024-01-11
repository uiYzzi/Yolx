import 'dart:io';
import 'dart:math';

import 'package:yolx/common/const.dart';

permission777(filePath) {
  Process.runSync('chmod', ['-R', '777', filePath]);
}

String formatFileSize(int size) {
  if (size <= 0) return '0 B';
  final int index = (log(size) / log(1024)).floor();
  return '${(size / pow(1024, index)).toStringAsFixed(2)} ${sizeUnits[index]}';
}
