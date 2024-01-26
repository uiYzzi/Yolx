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

  factory DownloadItem.fromJson(Map<String, dynamic> json) {
    return DownloadItem(
      completedLength: json['completedLength'],
      path: json['path'],
      connections: json['connections'],
      downloadSpeed: json['downloadSpeed'],
      gid: json['gid'],
      status: json['status'],
      totalLength: json['totalLength'],
      uploadSpeed: json['uploadSpeed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedLength': completedLength,
      'path': path,
      'connections': connections,
      'downloadSpeed': downloadSpeed,
      'gid': gid,
      'status': status,
      'totalLength': totalLength,
      'uploadSpeed': uploadSpeed,
    };
  }
}
