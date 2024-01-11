import 'dart:math';

class DownloadFile {
  String fileName;
  int totalSizeInBytes; // 文件总大小，以字节为单位
  int downloadedSizeInBytes; // 已下载大小，以字节为单位

  DownloadFile({
    required this.fileName,
    required this.totalSizeInBytes,
    this.downloadedSizeInBytes = 0,
  });

  static const List<String> sizeUnits = [
    'B',
    'KB',
    'MB',
    'GB',
    'TB',
    'PB',
    'EB',
    'ZB',
    'YB'
  ];

  String _formatFileSize(int size) {
    if (size <= 0) return '0 B';
    final int index = (log(size) / log(1024)).floor();
    return '${(size / pow(1024, index)).toStringAsFixed(2)} ${sizeUnits[index]}';
  }

  String getFormattedTotalSize() {
    return _formatFileSize(totalSizeInBytes);
  }

  String getFormattedDownloadedSize() {
    return _formatFileSize(downloadedSizeInBytes);
  }
}
