import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/model/download_item.dart';
import 'package:yolx/model/downloading_list_model.dart';
import 'package:yolx/widgets/download_file_card.dart';
import 'dart:async';
// ignore: library_prefixes
import 'package:yolx/utils/ariar2_http_utils.dart' as Aria2Http;
import 'package:yolx/widgets/new_download_dialog.dart';

import '../widgets/page.dart';

class DownloadingPage extends StatefulWidget {
  const DownloadingPage({super.key});

  @override
  State<DownloadingPage> createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> with PageMixin {
  bool selected = true;
  String? comboboxValue;
  // ignore: prefer_typing_uninitialized_variables
  var time;

  void showNewDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => NewDownloadDialog(),
    );
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

  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(milliseconds: 1000), (t) async {
      var res = await Aria2Http.tellActive(Global.rpcUrl);
      if (res == null) {
        return;
      }
      var downloadListModel =
          // ignore: use_build_context_synchronously
          Provider.of<DownloadingListModel>(context, listen: false);
      downloadListModel.updateDownloadList(parseDownloadList(res));
    });
  }

  @override
  void dispose() {
    time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    var downloadList = Provider.of<DownloadingListModel>(context).downloadList;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).downloading,
                  style: FluentTheme.of(context).typography.title),
              const Spacer(),
              Tooltip(
                message: S.of(context).newDownload,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.add, size: 18.0),
                  onPressed: () async {
                    showNewDialog(context);
                  },
                ),
              ),
              Tooltip(
                message: S.of(context).resumeAllTasks,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.play, size: 18.0),
                  onPressed: () async {
                    await Aria2Http.unpauseAll(Global.rpcUrl);
                  },
                ),
              ),
              Tooltip(
                message: S.of(context).pauseAllTasks,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.pause, size: 18.0),
                  onPressed: () async {
                    await Aria2Http.forcePauseAll(Global.rpcUrl);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Expanded(
              child: ListView.builder(
            itemCount: downloadList.length,
            itemBuilder: (context, index) {
              final contact = downloadList[index];
              return DownloadFileCard(
                downloadFile: contact,
              );
            },
          )),
        ],
      ),
    );
  }
}
