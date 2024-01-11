import 'package:flutter/foundation.dart';
import 'package:yolx/model/download_item.dart';

class DownloadingListModel extends ChangeNotifier {
  List<DownloadItem> _downloadList = [];

  List<DownloadItem> get downloadList => _downloadList;

  void updateDownloadList(List<DownloadItem> newList) {
    _downloadList = newList;
    notifyListeners();
  }
}
