class DownloadItem {
  int completedLength;
  String path;
  String connections;
  int downloadSpeed;
  String gid;
  String status;
  int totalLength;
  int uploadSpeed;

  DownloadItem({
    required this.completedLength,
    required this.path,
    required this.connections,
    required this.downloadSpeed,
    required this.gid,
    required this.status,
    required this.totalLength,
    required this.uploadSpeed,
  });
}
