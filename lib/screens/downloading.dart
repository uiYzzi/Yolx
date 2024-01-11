import 'package:fluent_ui/fluent_ui.dart';
import 'package:yolx/model/download_file.dart';
import 'package:yolx/widgets/download_file_card.dart';

import '../widgets/page.dart';

class DownloadingPage extends StatefulWidget {
  const DownloadingPage({super.key});

  @override
  State<DownloadingPage> createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> with PageMixin {
  bool selected = true;
  String? comboboxValue;

  @override
  Widget build(BuildContext context) {
    List<DownloadFile> downloadFiles = [
      DownloadFile(
        fileName: 'flutter_windows_3.16.5-stable.zip',
        totalSizeInBytes: 994857451, // 1 TB represented in bytes
        downloadedSizeInBytes: 434857451, // 50 GB represented in bytes
      ),
      DownloadFile(
        fileName: 'Presentation.pptx',
        totalSizeInBytes: 2147483648, // 2 GB represented in bytes
        downloadedSizeInBytes: 1073741824, // 1 GB represented in bytes
      ),
      DownloadFile(
        fileName: 'Video.mp4',
        totalSizeInBytes: 3221225472, // 3 GB represented in bytes
        downloadedSizeInBytes: 2147483648, // 2 GB represented in bytes
      ),
    ];
    assert(debugCheckHasFluentTheme(context));

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Downloading',
                  style: FluentTheme.of(context).typography.title),
              const Spacer(),
              Tooltip(
                message: 'Delete Selected Tasks',
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.delete, size: 18.0),
                  onPressed: () {},
                ),
              ),
              Tooltip(
                message: 'Refresh Task List',
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.refresh, size: 18.0),
                  onPressed: () {},
                ),
              ),
              Tooltip(
                message: 'Resume All Tasks',
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.play, size: 18.0),
                  onPressed: () {},
                ),
              ),
              Tooltip(
                message: 'Pause All Tasks',
                displayHorizontally: true,
                useMousePosition: false,
                style: const TooltipThemeData(preferBelow: true),
                child: IconButton(
                  icon: const Icon(FluentIcons.pause, size: 18.0),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Expanded(
              child: ListView.builder(
            itemCount: downloadFiles.length,
            itemBuilder: (context, index) {
              final contact = downloadFiles[index];
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
