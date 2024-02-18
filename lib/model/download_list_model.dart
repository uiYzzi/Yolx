import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yolx/model/download_item.dart';
import 'package:yolx/utils/file_utils.dart';
import 'package:yolx/utils/log.dart';

class DownloadListModel extends ChangeNotifier {
  List<DownloadItem> _downloadingList = [];
  List<DownloadItem> _waitingList = [];
  List<DownloadItem> _stoppedList = [];
  List<DownloadItem> _historyList = [];

  List<DownloadItem> get downloadingList => _downloadingList;
  List<DownloadItem> get waitingList => _waitingList;
  List<DownloadItem> get stoppedList {
    List<DownloadItem> combinedList = List<DownloadItem>.from(_stoppedList);
    List<String> downloadGids = _stoppedList.map((item) => item.gid).toList();
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
        _stoppedList.where((item) => item.status == "complete").toList();
    for (var item in completedItems) {
      item.status = "history";
    }

    List<String> historyIds = _historyList.map((item) => item.gid).toList();
    _historyList.insertAll(
        0, completedItems.where((item) => !historyIds.contains(item.gid)));
  }

  void updateStoppedList(List<DownloadItem> newList) {
    if (_stoppedList.length != newList.length) {
      _stoppedList = newList;
      saveHistoryListToJson();
    } else {
      _stoppedList = newList;
    }
    notifyListeners();
  }

  void updateDownloadingList(List<DownloadItem> newList) {
    _downloadingList = newList;
    notifyListeners();
  }

  void updateWaitingList(List<DownloadItem> newList) {
    _waitingList = newList;
    notifyListeners();
  }
}
