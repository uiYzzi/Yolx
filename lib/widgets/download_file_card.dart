import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/model/download_item.dart';
import 'package:yolx/utils/common_utils.dart';
import 'package:path/path.dart' as path;
// ignore: library_prefixes
import 'package:yolx/utils/ariar2_http_utils.dart' as Aria2Http;

class DownloadFileCard extends StatelessWidget {
  final DownloadItem downloadFile;

  const DownloadFileCard({Key? key, required this.downloadFile})
      : super(key: key);

  void showContentDialog(BuildContext context) async {
    final ValueNotifier<bool> checkboxValue = ValueNotifier<bool>(false);
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(S.of(context).removeTask),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).removeTaskInfo),
            const SizedBox(height: 4),
            ValueListenableBuilder<bool>(
              valueListenable: checkboxValue,
              builder: (context, value, child) {
                return Checkbox(
                  content: Text(S.of(context).deleteFile),
                  checked: value,
                  onChanged: (newValue) {
                    checkboxValue.value = newValue ?? false;
                  },
                );
              },
            ),
            const SizedBox(width: 4),
          ],
        ),
        actions: [
          Button(
            child: Text(S.of(context).delete),
            onPressed: () async {
              if (downloadFile.status == "paused" ||
                  downloadFile.status == "active") {
                await Aria2Http.forceRemove(Global.rpcUrl, downloadFile.gid);
              } else {
                await Aria2Http.removeDownloadResult(
                    Global.rpcUrl, downloadFile.gid);
              }
              if (checkboxValue.value) {
                File file = File(downloadFile.path);
                if (file.existsSync()) {
                  file.deleteSync();
                }
                File aria2file = File('${downloadFile.path}.aria2');
                if (aria2file.existsSync()) {
                  aria2file.deleteSync();
                }
              }
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
          FilledButton(
            child: Text(S.of(context).cancel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(path.basename(downloadFile.path),
                  style: FluentTheme.of(context).typography.body),
              const Spacer(),
              if (downloadFile.status == 'paused' ||
                  downloadFile.status == 'waiting') ...[
                Tooltip(
                  message: S.of(context).topping,
                  displayHorizontally: true,
                  useMousePosition: false,
                  style: const TooltipThemeData(preferBelow: true),
                  child: IconButton(
                    icon: const Icon(FluentIcons.up, size: 12.0),
                    onPressed: () async {
                      await Aria2Http.changePosition(
                          Global.rpcUrl, downloadFile.gid, 0, 'POS_SET');
                    },
                  ),
                ),
              ],
              Tooltip(
                message: S.of(context).deleteThisTasks,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.clear, size: 12.0),
                  onPressed: () => showContentDialog(context),
                ),
              ),
              Tooltip(
                message: S.of(context).resumeThisTasks,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.play, size: 14.0),
                  onPressed: () async {
                    await Aria2Http.unpause(Global.rpcUrl, downloadFile.gid);
                  },
                ),
              ),
              Tooltip(
                message: S.of(context).pauseThisTasks,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.pause, size: 14.0),
                  onPressed: () async {
                    await Aria2Http.forcePause(Global.rpcUrl, downloadFile.gid);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ProgressBar(
                    value: ((downloadFile.completedLength /
                                        downloadFile.totalLength) *
                                    100) <=
                                100 &&
                            ((downloadFile.completedLength /
                                        downloadFile.totalLength) *
                                    100) >=
                                0
                        ? ((downloadFile.completedLength /
                                downloadFile.totalLength) *
                            100)
                        : null),
              )
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                  '${formatFileSize(downloadFile.completedLength)} / ${formatFileSize(downloadFile.totalLength)}',
                  style: FluentTheme.of(context).typography.caption),
              const Spacer(),
              if (downloadFile.downloadSpeed > 1) ...[
                const Icon(
                  FluentIcons.download,
                  size: 14,
                ),
                Text('${formatFileSize(downloadFile.downloadSpeed)}/s',
                    style: FluentTheme.of(context).typography.caption),
              ],
              if (downloadFile.uploadSpeed > 1) ...[
                const Icon(
                  FluentIcons.upload,
                  size: 14,
                ),
                Text('${formatFileSize(downloadFile.uploadSpeed)}/s',
                    style: FluentTheme.of(context).typography.caption),
              ],
              if (downloadFile.status == 'waiting') ...[
                Text(S.of(context).waiting,
                    style: FluentTheme.of(context).typography.caption),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
