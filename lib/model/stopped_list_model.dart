import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yolx/model/download_item.dart';
import 'package:yolx/utils/file_utils.dart';
import 'package:yolx/utils/log.dart';

class StoppedListModel extends ChangeNotifier {
  List<DownloadItem> _downloadList = [];
  List<DownloadItem> _historyList = [];

  List<DownloadItem> get downloadList {
    List<DownloadItem> combinedList = List<DownloadItem>.from(_downloadList);
    List<String> downloadGids = _downloadList.map((item) => item.gid).toList();
    List<DownloadItem> uniqueHistoryItems =
        _historyList.where((item) => !downloadGids.contains(item.gid)).toList();
    combinedList.addAll(uniqueHistoryItems);
    return combinedList;
  }

  void removeAllFromHistoryList() {
    _historyList.clear();
    saveHistoryListToJson();
    notifyListeners();
  }

  void removeFromHistoryList(String gid) {
    _historyList.removeWhere((item) => item.gid == gid);
    saveHistoryListToJson();
    notifyListeners();
  }

  Future<void> saveHistoryListToJson() async {
    updateHistoryList();
    final historyListFile = await getLocalFile('historyList.json');
    List<Map<String, dynamic>> jsonList =
        _historyList.map((item) => item.toJson()).toList();
    String jsonString = json.encode(jsonList);
    await historyListFile.writeAsString(jsonString);
  }

  Future<void> loadHistoryListFromJson() async {
    try {
      final historyListFile = await getLocalFile('historyList.json');
      String jsonString = await historyListFile.readAsString();
      List<dynamic> jsonData = json.decode(jsonString);
      _historyList =
          jsonData.map((itemJson) => DownloadItem.fromJson(itemJson)).toList();
      notifyListeners();
    } catch (e) {
      Log.e(e);
    }
  }

  void updateHistoryList() {
    var completedItems =
        _downloadList.where((item) => item.status == "complete").toList();
    for (var item in completedItems) {
      item.status = "history";
    }

    List<String> historyIds = _historyList.map((item) => item.gid).toList();
    _historyList.insertAll(
        0, completedItems.where((item) => !historyIds.contains(item.gid)));
  }

  void updateDownloadList(List<DownloadItem> newList) {
    if (_downloadList.length != newList.length) {
      _downloadList = newList;
      saveHistoryListToJson();
    } else {
      _downloadList = newList;
    }
    notifyListeners();
  }
}
