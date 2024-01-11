import 'package:fluent_ui/fluent_ui.dart';
import 'package:yolx/model/download_file.dart';

class DownloadFileCard extends StatelessWidget {
  final DownloadFile downloadFile;

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
              Text(downloadFile.fileName,
                  style: FluentTheme.of(context).typography.body)
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ProgressBar(
                    value: (downloadFile.downloadedSizeInBytes /
                            downloadFile.totalSizeInBytes) *
                        100),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(
              '${downloadFile.getFormattedDownloadedSize()} / ${downloadFile.getFormattedTotalSize()}',
              style: FluentTheme.of(context).typography.caption)
        ],
      ),
    );
  }
}
