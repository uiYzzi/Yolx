import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/model/download_item.dart';
import 'package:yolx/model/download_list_model.dart';
import 'package:yolx/utils/common_utils.dart';
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
      builder: (context) => const NewDownloadDialog(),
    );
  }

  void updateList() async {
    if (!mounted) {
      return;
    }
    var res = await Aria2Http.tellActive(Global.rpcUrl);
    if (res == null) {
      return;
    }
    if (mounted) {
      var downloadListModel =
          // ignore: use_build_context_synchronously
          Provider.of<DownloadListModel>(context, listen: false);
      List<DownloadItem> downloadList = parseDownloadList(res);
      if (downloadList.length == downloadListModel.downloadingList.length) {
        downloadListModel.updateDownloadingList(parseDownloadList(res));
      } else {
        downloadListModel.updateDownloadingList(parseDownloadList(res));
        var stoppedRes = await Aria2Http.tellStopped(Global.rpcUrl);
        if (stoppedRes == null) {
          return;
        }
        var stoppedListModel =
            // ignore: use_build_context_synchronously
            Provider.of<DownloadListModel>(context, listen: false);
        stoppedListModel.updateStoppedList(parseDownloadList(stoppedRes));
      }
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
    time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    var downloadList = Provider.of<DownloadListModel>(context).downloadingList;
    return Padding(
      padding: EdgeInsets.all((MediaQuery.sizeOf(context).width < 640.0)
          ? 12.0
          : kPageDefaultVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          if (downloadList.isNotEmpty) ...[
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
          ] else ...[
            Expanded(
                child: SvgPicture.asset(
              'assets/no_data.svg',
              width: 260,
              semanticsLabel: 'My Icon',
            )),
            Text(S.of(context).noTaskDownloaded)
          ]
        ],
      ),
    );
  }
}
