import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/model/download_list_model.dart';
import 'package:yolx/utils/common_utils.dart';
import 'package:yolx/widgets/download_file_card.dart';
import 'dart:async';
import 'package:yolx/utils/ariar2_http_utils.dart' as Aria2Http;

import '../widgets/page.dart';

class StoppedPage extends StatefulWidget {
  const StoppedPage({super.key});

  @override
  State<StoppedPage> createState() => _StoppedPageState();
}

class _StoppedPageState extends State<StoppedPage> with PageMixin {
  bool selected = true;
  String? comboboxValue;
  // ignore: prefer_typing_uninitialized_variables
  var time;

  void updateList() async {
    if (!mounted) {
      return;
    }
    var res = await Aria2Http.tellStopped(Global.rpcUrl);
    if (res == null) {
      return;
    }
    if (mounted) {
      var downloadListModel =
          // ignore: use_build_context_synchronously
          Provider.of<DownloadListModel>(context, listen: false);
      downloadListModel.updateStoppedList(parseDownloadList(res));
    }
  }

  @override
  void initState() {
    super.initState();
    updateList();
    time = Timer.periodic(const Duration(milliseconds: 1000), (t) {
      updateList();
    });
  }

  @override
  void dispose() {
    time?.cancel(); // 取消定时器以避免未来触发
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    var downloadListModel = Provider.of<DownloadListModel>(context);
    var downloadList = downloadListModel.stoppedList;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).stopped,
                  style: FluentTheme.of(context).typography.title),
              const Spacer(),
              Tooltip(
                message: S.of(context).purgeTaskRecord,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.delete, size: 18.0),
                  onPressed: () async {
                    await Aria2Http.purgeDownloadResult(Global.rpcUrl);
                    // ignore: use_build_context_synchronously
                    downloadListModel.removeAllFromHistoryList();
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
