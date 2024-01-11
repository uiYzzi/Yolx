import 'dart:io';

permission777(filePath) {
  Process.runSync('chmod', ['-R', '777', filePath]);
}
