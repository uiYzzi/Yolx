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
              Tooltip(
                message: S.of(context).deleteThisTasks,
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.clear, size: 12.0),
                  onPressed: () async {
                    await Aria2Http.removeDownloadResult(
                        Global.rpcUrl, downloadFile.gid);
                  },
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
              ]
            ],
          ),
        ],
      ),
    );
  }
}
