import 'dart:io';
import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:yolx/common/const.dart';
import 'package:yolx/model/download_item.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

bool isTablet(MediaQueryData queryData) {
  double devicePixelRatio = queryData.devicePixelRatio;
  double screenWidth = queryData.size.shortestSide;

  // 判断设备是否为平板
  return (devicePixelRatio < 2.0 && screenWidth > 600) ||
      (devicePixelRatio >= 2.0 && screenWidth > 960);
}

permission777(filePath) {
  Process.runSync('chmod', ['-R', '777', filePath]);
}

String formatFileSize(int size) {
  if (size <= 0) return '0 B';
  final int index = (log(size) / log(1024)).floor();
  return '${(size / pow(1024, index)).toStringAsFixed(2)} ${sizeUnits[index]}';
}

List<DownloadItem> parseDownloadList(dynamic responseData) {
  List<DownloadItem> downloadList = [];
  for (var itemData in responseData) {
    var downloadItem = DownloadItem(
      completedLength: int.parse(itemData["completedLength"]),
      path: itemData["files"][0]["path"],
      connections: itemData["connections"],
      downloadSpeed: int.parse(itemData["downloadSpeed"]),
      gid: itemData["gid"],
      status: itemData["status"],
      totalLength: int.parse(itemData["totalLength"]),
      uploadSpeed: int.parse(itemData["uploadSpeed"]),
    );
    downloadList.add(downloadItem);
  }
  return downloadList;
}
